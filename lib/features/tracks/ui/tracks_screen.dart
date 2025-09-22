import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../shared/ui/sort_popup_menu_button.dart';
import '../providers/tracks_controller.dart';
import './track_list_view.dart';

class TracksScreen extends StatelessWidget {
  const TracksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: (_) => const TracksMainScreen());
      },
    );
  }
}

class TracksMainScreen extends HookConsumerWidget {
  const TracksMainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(tracksControllerProvider.notifier);
    final searchController = useTextEditingController();

    // TracksControllerは同期的なので、直接状態を取得
    final state = ref.watch(tracksControllerProvider);
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
                  hintText: '楽曲を検索...',
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
              SortPopupMenuButton<TrackSortType>(
                currentValue: sortType,
                items: const [
                  SortMenuItem(value: TrackSortType.title, label: 'タイトル順'),
                  SortMenuItem(value: TrackSortType.artist, label: 'アーティスト順'),
                  SortMenuItem(value: TrackSortType.album, label: 'アルバム順'),
                  SortMenuItem(value: TrackSortType.dateAdded, label: '追加日順'),
                ],
                onSelected: (TrackSortType type) {
                  controller.updateSortType(type);
                },
              ),
            ],
          ),
        body: const TrackListView(),
      );
  }
}
