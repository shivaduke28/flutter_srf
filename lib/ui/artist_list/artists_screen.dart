import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../components/sort_popup_menu_button.dart';
import '../../application/artists/artists_notifier.dart';
import 'artist_list_view.dart';

class ArtistsScreen extends StatelessWidget {
  const ArtistsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: (_) => const ArtistsMainScreen());
      },
    );
  }
}

class ArtistsMainScreen extends HookConsumerWidget {
  const ArtistsMainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final artistsState = ref.watch(artistsControllerProvider);
    final controller = ref.read(artistsControllerProvider.notifier);
    final searchController = useTextEditingController();

    return artistsState.when(
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (error, stack) =>
          Scaffold(body: Center(child: Text('エラー: $error'))),
      data: (state) {
        final sortType = state.sortType;
        final query = state.searchQuery;

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
                  hintText: 'アーティストを検索...',
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
                onChanged: (value) {
                  controller.updateSearchQuery(value);
                },
              ),
            ),
            actions: [
              SortPopupMenuButton<ArtistSortType>(
                currentValue: sortType,
                items: const [
                  SortMenuItem(value: ArtistSortType.name, label: '名前順'),
                  SortMenuItem(value: ArtistSortType.trackCount, label: '曲数順'),
                  SortMenuItem(
                    value: ArtistSortType.albumCount,
                    label: 'アルバム数順',
                  ),
                ],
                onSelected: (ArtistSortType type) {
                  controller.updateSortType(type);
                },
              ),
            ],
          ),
          body: const ArtistListView(),
        );
      },
    );
  }
}
