import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../application/library/library_manager.dart';
import 'import_dialog.dart';

class SettingsScreen extends HookConsumerWidget {
  const SettingsScreen({super.key});

  Future<void> _openInFinder(BuildContext context, String path) async {
    try {
      // ディレクトリが存在しない場合は作成
      final dir = Directory(path);
      if (!await dir.exists()) {
        await dir.create(recursive: true);
      }

      // ファイルURIを作成してシステムのファイルエクスプローラーで開く
      final uri = Uri.file(path);
      if (!await launchUrl(uri)) {
        throw Exception('Could not launch $uri');
      }
    } catch (e, stackTrace) {
      // デバッグビルドではログ出力
      assert(() {
        debugPrint('Error opening directory: $e');
        debugPrint('Stack trace: $stackTrace');
        return true;
      }());

      // ユーザーにエラーを通知
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('フォルダを開けませんでした: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final libraryManager = ref.watch(libraryManagerProvider.notifier);

    return FutureBuilder<String>(
      future: libraryManager.libraryPath,
      builder: (context, snapshot) {
        final libraryPath = snapshot.data ?? '読み込み中...';
        const supportedExtensions = ['.mp3', '.m4a', '.wav', '.flac'];

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              child: ListTile(
                title: const Text('ライブラリパス'),
                subtitle: Text(libraryPath),
                trailing: IconButton(
                  icon: const Icon(Icons.folder_open),
                  tooltip: 'Finderで開く',
                  onPressed: snapshot.hasData
                      ? () async {
                          await _openInFinder(context, libraryPath);
                        }
                      : null,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                title: const Text('サポートされる拡張子'),
                subtitle: Text(supportedExtensions.join(', ')),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                title: const Text('楽曲をインポート'),
                subtitle: const Text('フォルダから楽曲をインポート'),
                leading: const Icon(Icons.folder_open),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () async {
                  await showDialog(
                    context: context,
                    builder: (context) => const ImportDialog(),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                title: const Text('ライブラリを再スキャン'),
                subtitle: const Text('楽曲の追加・削除後に手動でライブラリを更新'),
                leading: const Icon(Icons.refresh),
                onTap: () async {
                  // 確認ダイアログを表示
                  final confirmed = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('ライブラリを再スキャン'),
                      content: const Text(
                        'ライブラリを再スキャンしますか？\n楽曲数が多い場合は時間がかかることがあります。',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text('キャンセル'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: const Text('再スキャン'),
                        ),
                      ],
                    ),
                  );

                  if (confirmed == true) {
                    // ライブラリを再スキャン
                    await ref
                        .read(libraryManagerProvider.notifier)
                        .scanLibrary(forceRefresh: true);

                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('ライブラリを再スキャンしました')),
                      );
                    }
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
