import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../tracks/track_list_screen.dart';
import '../artists/artists_screen.dart';
import '../albums/albums_screen.dart';
import '../settings/settings_screen.dart';
import '../common/player_control_bar.dart';

class HomeScreen extends HookConsumerWidget {
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
              child: TabBarView(
                children: [
                  SongsListScreen(),
                  ArtistsScreen(),
                  AlbumsScreen(),
                  SettingsScreen(),
                ],
              ),
            ),
            const PlayerControlBar(),
          ],
        ),
      ),
    );
  }
}
