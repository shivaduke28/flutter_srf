import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_srf/application/albums/album_query_controller.dart';
import 'package:flutter_srf/ui/album_list/album_list_view.dart';
import 'package:flutter_srf/ui/components/sort_popup_menu_button.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AlbumsScreen extends StatelessWidget {
  const AlbumsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: (_) => const AlbumsMainScreen());
      },
    );
  }
}

class AlbumsMainScreen extends HookConsumerWidget {
  const AlbumsMainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final queryState = ref.watch(albumQueryControllerProvider);
    final controller = ref.read(albumQueryControllerProvider.notifier);
    final searchController = useTextEditingController();

    final sortType = queryState.sortType;
    final query = queryState.searchQuery;

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
                        controller.clearSearchQuery();
                      },
                    )
                  : null,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 8),
            ),
            onChanged: controller.updateSearchQuery,
          ),
        ),
        actions: [
          SortPopupMenuButton<AlbumSortType>(
            currentValue: sortType,
            items: const [
              SortMenuItem(value: AlbumSortType.name, label: '名前順'),
              SortMenuItem(value: AlbumSortType.artist, label: 'アーティスト順'),
              SortMenuItem(value: AlbumSortType.trackCount, label: '曲数順'),
            ],
            onSelected: controller.updateSortType,
          ),
        ],
      ),
      body: const AlbumListView(),
    );
  }
}
