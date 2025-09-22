import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../features/tracks/ui/tracks_screen.dart';
import '../../features/artists/ui/artists_screen.dart';
import '../../features/albums/ui/albums_screen.dart';
import '../../features/settings/ui/settings_screen.dart';
import '../../features/player/ui/audio_player_view.dart';
import '../../features/library/providers/library_manager.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch library manager to trigger initialization
    ref.watch(libraryManagerProvider);

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter SRF'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.music_note), text: '楽曲'),
              Tab(icon: Icon(Icons.person), text: 'アーティスト'),
              Tab(icon: Icon(Icons.album), text: 'アルバム'),
              Tab(icon: Icon(Icons.settings), text: '設定'),
            ],
          ),
        ),
        body: Column(
          children: [
            const Expanded(
              child: TabBarView(
                children: [
                  TracksScreen(),
                  ArtistsScreen(),
                  AlbumsScreen(),
                  SettingsScreen(),
                ],
              ),
            ),
            const AudioPlayerView(),
          ],
        ),
      ),
    );
  }
}
