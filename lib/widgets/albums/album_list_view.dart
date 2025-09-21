import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'providers/queried_albums_provider.dart';
import 'providers/album_query_provider.dart';
import 'providers/album_sort_type_provider.dart';
import 'album_detail_screen.dart';

class AlbumListView extends ConsumerWidget {
  const AlbumListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final albumsAsync = ref.watch(queriedAlbumsProvider);
    final sortType = ref.watch(albumSortTypeNotifierProvider);
    final query = ref.watch(albumQueryNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('アルバム'),
        actions: [
          PopupMenuButton<AlbumSortType>(
            icon: const Icon(Icons.sort),
            onSelected: (AlbumSortType type) {
              ref
                  .read(albumSortTypeNotifierProvider.notifier)
                  .setSortType(type);
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                value: AlbumSortType.name,
                child: Row(
                  children: [
                    if (sortType == AlbumSortType.name)
                      const Icon(Icons.check, size: 20)
                    else
                      const SizedBox(width: 20),
                    const SizedBox(width: 8),
                    const Text('名前順'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: AlbumSortType.artist,
                child: Row(
                  children: [
                    if (sortType == AlbumSortType.artist)
                      const Icon(Icons.check, size: 20)
                    else
                      const SizedBox(width: 20),
                    const SizedBox(width: 8),
                    const Text('アーティスト順'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: AlbumSortType.year,
                child: Row(
                  children: [
                    if (sortType == AlbumSortType.year)
                      const Icon(Icons.check, size: 20)
                    else
                      const SizedBox(width: 20),
                    const SizedBox(width: 8),
                    const Text('年代順'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: AlbumSortType.trackCount,
                child: Row(
                  children: [
                    if (sortType == AlbumSortType.trackCount)
                      const Icon(Icons.check, size: 20)
                    else
                      const SizedBox(width: 20),
                    const SizedBox(width: 8),
                    const Text('曲数順'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'アルバムを検索...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: query.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          ref
                              .read(albumQueryNotifierProvider.notifier)
                              .clearQuery();
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: (value) {
                ref
                    .read(albumQueryNotifierProvider.notifier)
                    .updateQuery(value);
              },
            ),
          ),
          Expanded(
            child: albumsAsync.when(
              data: (albums) {
                if (albums.isEmpty) {
                  return Center(
                    child: Text(
                      query.isNotEmpty
                          ? '「$query」に一致するアルバムが見つかりません'
                          : 'アルバムが見つかりません',
                    ),
                  );
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
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                AlbumDetailScreen(album: album),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).colorScheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.primary.withValues(alpha: 0.1),
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(12),
                                  ),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.album,
                                    size: 64,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    album.name,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    album.artist,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodySmall,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${album.trackCount}曲${album.year != null ? ' • ${album.year}' : ''}',
                                    style: Theme.of(context).textTheme.bodySmall
                                        ?.copyWith(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.onSurfaceVariant,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) =>
                  Center(child: Text('エラーが発生しました: $error')),
            ),
          ),
        ],
      ),
    );
  }
}
