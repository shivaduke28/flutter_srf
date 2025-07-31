import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'songs_list_screen.dart';
import 'artists_list_screen.dart';
import 'albums_list_screen.dart';
import 'settings_screen.dart';

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
        body: const TabBarView(
          children: [
            SongsListScreen(),
            ArtistsListScreen(),
            AlbumsListScreen(),
            SettingsScreen(),
          ],
        ),
      ),
    );
  }
}
