import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../widgets/sort_popup_menu_button.dart';
import '../../../application/albums/album_sort_type_provider.dart';
import '../../../application/albums/album_query_provider.dart';
import 'album_list_view.dart';

class AlbumsScreen extends StatelessWidget {
  const AlbumsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const AlbumsMainScreen(),
        );
      },
    );
  }
}

class AlbumsMainScreen extends HookConsumerWidget {
  const AlbumsMainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: 'アルバムを検索...',
              prefixIcon: const Icon(Icons.search, size: 20),
              suffixIcon: query.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear, size: 20),
                      onPressed: () {
                        searchController.clear();
                        ref
                            .read(albumQueryNotifierProvider.notifier)
                            .clearQuery();
                      },
                    )
                  : null,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 8),
            ),
            onChanged: (value) {
              ref.read(albumQueryNotifierProvider.notifier).updateQuery(value);
            },
          ),
        ),
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
      body: const AlbumListView(),
    );
  }
}
