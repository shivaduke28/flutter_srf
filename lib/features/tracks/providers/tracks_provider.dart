import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/track.dart';
import '../../library/providers/library_manager.dart';

part 'tracks_provider.g.dart';

/// TracksProvider - Provides track list from LibraryManager
@riverpod
class Tracks extends _$Tracks {
  @override
  Future<List<Track>> build() async {
    return ref.watch(libraryManagerProvider);
  }
}
