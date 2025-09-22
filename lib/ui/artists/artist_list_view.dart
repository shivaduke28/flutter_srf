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
      data: (artists) {
        if (artists.isEmpty) {
          return const Center(child: Text('アーティストが見つかりません'));
        }

        return ListView.builder(
          itemCount: artists.length,
          itemBuilder: (context, index) {
            final artist = artists[index];
            return ArtistListItemView(artist: artist);
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(child: Text('エラーが発生しました: $error')),
    );
  }
}
