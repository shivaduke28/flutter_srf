import 'package:freezed_annotation/freezed_annotation.dart';

part 'library_settings.freezed.dart';
part 'library_settings.g.dart';

@freezed
sealed class LibrarySettings with _$LibrarySettings {
  const factory LibrarySettings({
    required String libraryPath,
    required List<String> watchedDirectories,
    required bool autoImport,
    required List<String> supportedExtensions,
    DateTime? lastScanDate,
  }) = _LibrarySettings;

  factory LibrarySettings.fromJson(Map<String, dynamic> json) =>
      _$LibrarySettingsFromJson(json);

  factory LibrarySettings.defaultSettings() => const LibrarySettings(
    libraryPath: '',
    watchedDirectories: [],
    autoImport: false,
    supportedExtensions: ['.mp3'],
  );
}
