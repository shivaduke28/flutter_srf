import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../widgets/sort_popup_menu_button.dart';
import '../../application/tracks/track_sort_type_provider.dart';
import '../../application/tracks/track_query_provider.dart';
import '../tracks/track_list_view.dart';

class TracksScreen extends StatelessWidget {
  const TracksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const TracksMainScreen(),
        );
      },
    );
  }
}

class TracksMainScreen extends HookConsumerWidget {
  const TracksMainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sortType = ref.watch(trackSortTypeNotifierProvider);
    final query = ref.watch(trackQueryNotifierProvider);
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
              hintText: '楽曲を検索...',
              prefixIcon: const Icon(Icons.search, size: 20),
              suffixIcon: query.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear, size: 20),
                      onPressed: () {
                        searchController.clear();
                        ref
                            .read(trackQueryNotifierProvider.notifier)
                            .clearQuery();
                      },
                    )
                  : null,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 8),
            ),
            onChanged: (value) {
              ref.read(trackQueryNotifierProvider.notifier).updateQuery(value);
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
              ref
                  .read(trackSortTypeNotifierProvider.notifier)
                  .setSortType(type);
            },
          ),
        ],
      ),
      body: const TrackListView(),
    );
  }
}
