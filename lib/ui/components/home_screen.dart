import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../track_list/tracks_screen.dart';
import '../artist_list/artists_screen.dart';
import '../album_list/albums_screen.dart';
import '../settings/settings_screen.dart';
import '../player/audio_player_view.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              child: TabBarView(children: [TracksScreen(), ArtistsScreen(), AlbumsScreen(), SettingsScreen()]),
            ),
            const AudioPlayerView(),
          ],
        ),
      ),
    );
  }
}
