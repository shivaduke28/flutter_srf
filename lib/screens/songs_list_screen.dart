import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../providers/srf_containers_provider.dart';
import '../widgets/song_list_tile.dart';
import '../widgets/import_dialog.dart';
import '../services/library_service.dart';

class SongsListScreen extends HookConsumerWidget {
  const SongsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final containersAsync = ref.watch(srfContainersProvider);
    final searchController = useTextEditingController();
    final searchQuery = useState('');
    final sortType = useState(SortType.title);

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: '検索...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: searchQuery.value.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          searchController.clear();
                          searchQuery.value = '';
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: (value) => searchQuery.value = value,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text('並び替え: '),
                DropdownButton<SortType>(
                  value: sortType.value,
                  onChanged: (value) {
                    if (value != null) {
                      sortType.value = value;
                    }
                  },
                  items: const [
                    DropdownMenuItem(
                      value: SortType.title,
                      child: Text('タイトル'),
                    ),
                    DropdownMenuItem(
                      value: SortType.artist,
                      child: Text('アーティスト'),
                    ),
                    DropdownMenuItem(
                      value: SortType.dateAdded,
                      child: Text('追加日'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: containersAsync.when(
              data: (containers) {
                final notifier = ref.read(srfContainersProvider.notifier);
                var filteredContainers = searchQuery.value.isEmpty
                    ? containers
                    : notifier.searchContainers(searchQuery.value);

                filteredContainers = notifier.sortContainers(
                  filteredContainers,
                  sortType.value,
                );

                if (filteredContainers.isEmpty) {
                  return const Center(child: Text('楽曲がありません'));
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    await ref.read(srfContainersProvider.notifier).refresh();
                  },
                  child: ListView.builder(
                    itemCount: filteredContainers.length,
                    itemBuilder: (context, index) {
                      final container = filteredContainers[index];
                      return SongListTile(container: container);
                    },
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text('エラー: $error')),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final settings = await ref.read(libraryServiceProvider.future);
          if (settings.libraryPath.isEmpty) {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('先に設定画面でライブラリパスを設定してください')),
              );
            }
            return;
          }

          if (context.mounted) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const ImportDialog(),
            );
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
