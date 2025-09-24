import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_srf/application/import/import_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ImportDialog extends HookConsumerWidget {
  const ImportDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final importState = ref.watch(importNotifierProvider);
    final selectedPath = useState<String?>(null);

    return AlertDialog(
      title: const Text('音楽をインポート'),
      content: SizedBox(
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!importState.isImporting) ...[
              const Text('MP3ファイルが含まれるフォルダを選択してください。'),
              const SizedBox(height: 16),
              if (selectedPath.value != null) ...[
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        const Icon(Icons.folder, color: Colors.blue),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            selectedPath.value!,
                            style: Theme.of(context).textTheme.bodySmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () async {
                      final result = await FilePicker.platform.getDirectoryPath();
                      if (result != null) {
                        selectedPath.value = result;
                      }
                    },
                    icon: const Icon(Icons.folder_open),
                    label: Text(selectedPath.value == null ? 'フォルダを選択' : '別のフォルダを選択'),
                  ),
                  if (selectedPath.value != null) ...[
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: () async {
                        try {
                          final importNotifier = ref.read(importNotifierProvider.notifier);
                          await importNotifier.importDirectory(selectedPath.value!);

                          if (context.mounted) {
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('インポートが完了しました')));
                          }
                        } on Exception catch (e) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(
                              context,
                            ).showSnackBar(SnackBar(content: Text('エラー: $e'), backgroundColor: Colors.red));
                          }
                        }
                      },
                      icon: const Icon(Icons.download),
                      label: const Text('インポート'),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
                    ),
                  ],
                ],
              ),
            ] else ...[
              Text('インポート中... ${importState.processedFiles}/${importState.totalFiles}'),
              const SizedBox(height: 8),
              LinearProgressIndicator(value: ref.read(importNotifierProvider.notifier).progress),
              const SizedBox(height: 8),
              Text(
                importState.currentFile,
                style: Theme.of(context).textTheme.bodySmall,
                overflow: TextOverflow.ellipsis,
              ),
              if (importState.errors.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  'エラー: ${importState.errors.length}件',
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ],
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: importState.isImporting
              ? () {
                  ref.read(importNotifierProvider.notifier).cancelImport();
                  Navigator.of(context).pop();
                }
              : () => Navigator.of(context).pop(),
          child: Text(importState.isImporting ? 'キャンセル' : '閉じる'),
        ),
      ],
    );
  }
}
