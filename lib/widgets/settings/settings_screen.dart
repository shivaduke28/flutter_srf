import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../services/library_service.dart';
import '../../providers/srf_containers_provider.dart';

class SettingsScreen extends HookConsumerWidget {
  const SettingsScreen({super.key});

  Future<void> _openInFinder(String path) async {
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
    } catch (e) {
      print('Error opening directory: $e');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(libraryServiceProvider);

    return settingsAsync.when(
      data: (settings) {
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              child: ListTile(
                title: const Text('ライブラリパス'),
                subtitle: Text(settings.libraryPath),
                trailing: IconButton(
                  icon: const Icon(Icons.folder_open),
                  tooltip: 'Finderで開く',
                  onPressed: () async {
                    await _openInFinder(settings.libraryPath);
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: SwitchListTile(
                title: const Text('自動インポート'),
                subtitle: const Text('監視ディレクトリに追加されたファイルを自動的にインポート'),
                value: settings.autoImport,
                onChanged: (value) {
                  // TODO: 設定変更の実装
                },
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                title: const Text('サポートされる拡張子'),
                subtitle: Text(settings.supportedExtensions.join(', ')),
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
                    await ref.read(srfContainersProvider.notifier).refresh();

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
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('エラー: $error')),
    );
  }
}
