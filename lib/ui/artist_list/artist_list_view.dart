import 'package:flutter/material.dart';
import '../../application/artists/queried_artists_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'artist_list_item_view.dart';

class ArtistListView extends ConsumerWidget {
  const ArtistListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final artistsAsync = ref.watch(queriedArtistsProvider);

    return artistsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('エラー: $error')),
      data: (artists) {
        if (artists.isEmpty) {
          return const Center(child: Text('アーティストが見つかりません'));
        }

        return ListView.builder(
          itemCount: artists.length,
          itemBuilder: (context, index) {
            return ArtistListItemView(artist: artists[index]);
          },
        );
      },
    );
  }
}
