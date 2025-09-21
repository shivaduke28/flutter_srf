import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../common/sort_popup_menu_button.dart';
import 'providers/queried_albums_provider.dart';
import 'providers/album_query_provider.dart';
import 'providers/album_sort_type_provider.dart';
import 'album_list_item_view.dart';

class AlbumListView extends HookConsumerWidget {
  const AlbumListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final albumsAsync = ref.watch(queriedAlbumsProvider);
    final sortType = ref.watch(albumSortTypeNotifierProvider);
    final query = ref.watch(albumQueryNotifierProvider);
    final searchController = useTextEditingController();

    // providerの値が変わったらcontrollerも更新
    useEffect(() {
      if (searchController.text != query) {
        searchController.text = query;
      }
      return null;
    }, [query]);

    return Scaffold(
      appBar: AppBar(
        title: const Text('アルバム'),
        actions: [
          SortPopupMenuButton<AlbumSortType>(
            currentValue: sortType,
            items: const [
              SortMenuItem(value: AlbumSortType.name, label: '名前順'),
              SortMenuItem(value: AlbumSortType.artist, label: 'アーティスト順'),
              SortMenuItem(value: AlbumSortType.year, label: '年代順'),
              SortMenuItem(value: AlbumSortType.trackCount, label: '曲数順'),
            ],
            onSelected: (AlbumSortType type) {
              ref
                  .read(albumSortTypeNotifierProvider.notifier)
                  .setSortType(type);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'アルバムを検索...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: query.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          ref
                              .read(albumQueryNotifierProvider.notifier)
                              .clearQuery();
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: (value) {
                ref
                    .read(albumQueryNotifierProvider.notifier)
                    .updateQuery(value);
              },
            ),
          ),
          Expanded(
            child: albumsAsync.when(
              data: (albums) {
                if (albums.isEmpty) {
                  return const Center(child: Text('アルバムが見つかりません'));
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1,
                  ),
                  itemCount: albums.length,
                  itemBuilder: (context, index) {
                    final album = albums[index];
                    return AlbumListItemView(album: album);
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) =>
                  Center(child: Text('エラーが発生しました: $error')),
            ),
          ),
        ],
      ),
    );
  }
}
