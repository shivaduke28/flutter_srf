import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import '../services/library_service.dart';

class SettingsScreen extends HookConsumerWidget {
  const SettingsScreen({super.key});

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
                subtitle: Text(
                  settings.libraryPath.isEmpty ? '未設定' : settings.libraryPath,
                ),
                trailing: const Icon(Icons.folder),
                onTap: () async {
                  final result = await FilePicker.platform.getDirectoryPath();
                  if (result != null) {
                    await ref
                        .read(libraryServiceProvider.notifier)
                        .setLibraryPath(result);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('ライブラリパスを設定しました: $result')),
                      );
                    }
                  }
                },
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
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('エラー: $error')),
    );
  }
}
