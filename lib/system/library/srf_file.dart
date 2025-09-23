import 'package:flutter_srf/system/library/srf_track.dart';

class SrfFile {
  final String path;
  final String name;
  final List<SrfTrack> tracks;

  SrfFile({required this.path, required this.name, required this.tracks});
}
