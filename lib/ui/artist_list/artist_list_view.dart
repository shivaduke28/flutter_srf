import 'package:flutter/material.dart';
import 'package:flutter_srf/application/artists/queried_artists_provider.dart';
import 'package:flutter_srf/ui/artist_list/artist_list_item_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
