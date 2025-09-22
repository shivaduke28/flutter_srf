import 'package:flutter/material.dart';
import '../providers/artists_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'artist_list_item_view.dart';

class ArtistListView extends ConsumerWidget {
  const ArtistListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(artistsControllerProvider.notifier);
    final artists = controller.filteredAndSortedArtists;

    if (artists.isEmpty) {
      return const Center(child: Text('アーティストが見つかりません'));
    }

    return ListView.builder(
      itemCount: artists.length,
      itemBuilder: (context, index) {
        return ArtistListItemView(artist: artists[index]);
      },
    );
  }
}
