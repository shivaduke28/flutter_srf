import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'track.dart';

part 'track_repository.g.dart';

/// Track Repository - Single Source of Truth for tracks
/// This repository manages the in-memory track list
/// Does not handle file I/O operations directly
@Riverpod(keepAlive: true)
class TrackRepository extends _$TrackRepository {
  @override
  List<Track> build() {
    return [];
  }

  /// Initialize repository with tracks from external source
  void initialize(List<Track> tracks) {
    state = tracks;
  }

  /// Add a single track
  void addTrack(Track track) {
    state = [...state, track];
  }

  /// Add multiple tracks
  void addTracks(List<Track> tracks) {
    state = [...state, ...tracks];
  }

  /// Update a track
  void updateTrack(String id, Track updatedTrack) {
    state = [
      for (final track in state)
        if (track.id == id) updatedTrack else track,
    ];
  }

  /// Remove a track by id
  void removeTrack(String id) {
    state = state.where((track) => track.id != id).toList();
  }

  /// Remove multiple tracks
  void removeTracks(List<String> ids) {
    state = state.where((track) => !ids.contains(track.id)).toList();
  }

  /// Clear all tracks
  void clear() {
    state = [];
  }

  /// Get a track by id
  Track? getTrack(String id) {
    try {
      return state.firstWhere((track) => track.id == id);
    } catch (_) {
      return null;
    }
  }

  /// Get all tracks
  List<Track> getAllTracks() {
    return state;
  }
}