import 'package:flutter/material.dart';
import 'package:flutter_srf/application/albums/queried_albums_provider.dart';
import 'package:flutter_srf/ui/album_list/album_list_item_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AlbumListView extends ConsumerWidget {
  const AlbumListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final albumsAsync = ref.watch(queriedAlbumsProvider);

    return albumsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('エラー: $error')),
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
    );
  }
}
