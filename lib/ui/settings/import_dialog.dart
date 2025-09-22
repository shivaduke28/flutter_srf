import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:file_picker/file_picker.dart';
import '../../../application/library/services/import_service.dart';
import '../../../application/tracks/track_repository.dart';

class ImportDialog extends HookConsumerWidget {
  const ImportDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final importProgress = ref.watch(importServiceProvider);
    final selectedPath = useState<String?>(null);

    return AlertDialog(
      title: const Text('音楽をインポート'),
      content: SizedBox(
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!importProgress.isImporting) ...[
              const Text('MP3ファイルが含まれるフォルダを選択してください。'),
              const SizedBox(height: 16),
              if (selectedPath.value != null) ...[
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
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
                      final result = await FilePicker.platform
                          .getDirectoryPath();
                      if (result != null) {
                        selectedPath.value = result;
                      }
                    },
                    icon: const Icon(Icons.folder_open),
                    label: Text(
                      selectedPath.value == null ? 'フォルダを選択' : '別のフォルダを選択',
                    ),
                  ),
                  if (selectedPath.value != null) ...[
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: () async {
                        try {
                          final importService = ref.read(
                            importServiceProvider.notifier,
                          );
                          final tracks = await importService
                              .importDirectory(selectedPath.value!);

                          // TrackRepositoryに追加
                          final repository = ref.read(trackRepositoryProvider.notifier);
                          repository.addTracks(tracks);

                          if (context.mounted) {
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  '${tracks.length}曲をインポートしました',
                                ),
                              ),
                            );
                          }
                        } catch (e) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('エラー: $e'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        }
                      },
                      icon: const Icon(Icons.download),
                      label: const Text('インポート'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ],
              ),
            ] else ...[
              Text(
                'インポート中... ${importProgress.processedFiles}/${importProgress.totalFiles}',
              ),
              const SizedBox(height: 8),
              LinearProgressIndicator(value: importProgress.progress),
              const SizedBox(height: 8),
              Text(
                importProgress.currentFile,
                style: Theme.of(context).textTheme.bodySmall,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: importProgress.isImporting
              ? () {
                  ref.read(importServiceProvider.notifier).cancelImport();
                  Navigator.of(context).pop();
                }
              : () => Navigator.of(context).pop(),
          child: Text(importProgress.isImporting ? 'キャンセル' : '閉じる'),
        ),
      ],
    );
  }
}
