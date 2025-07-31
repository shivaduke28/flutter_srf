import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../services/import_service.dart';
import '../providers/srf_containers_provider.dart';

class ImportDialog extends HookConsumerWidget {
  const ImportDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final importProgress = ref.watch(importServiceProvider);
    final pathController = useTextEditingController();

    return AlertDialog(
      title: const Text('音楽をインポート'),
      content: SizedBox(
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!importProgress.isImporting) ...[
              const Text('MP3ファイルが含まれるフォルダのパスを入力してください。'),
              const SizedBox(height: 16),
              TextField(
                controller: pathController,
                decoration: const InputDecoration(
                  labelText: 'フォルダパス',
                  hintText: '/Users/username/Music',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () async {
                  final path = pathController.text.trim();
                  if (path.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('パスを入力してください'),
                        backgroundColor: Colors.orange,
                      ),
                    );
                    return;
                  }

                  try {
                    final importService = ref.read(
                      importServiceProvider.notifier,
                    );
                    final containers = await importService.importDirectory(
                      path,
                    );

                    // コンテナリストを更新
                    await ref.read(srfContainersProvider.notifier).refresh();

                    if (context.mounted) {
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${containers.length}曲をインポートしました'),
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
