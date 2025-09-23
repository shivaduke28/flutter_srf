// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'library_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LibrarySettings _$LibrarySettingsFromJson(Map<String, dynamic> json) => _LibrarySettings(
  libraryPath: json['libraryPath'] as String,
  watchedDirectories: (json['watchedDirectories'] as List<dynamic>).map((e) => e as String).toList(),
  autoImport: json['autoImport'] as bool,
  supportedExtensions: (json['supportedExtensions'] as List<dynamic>).map((e) => e as String).toList(),
  lastScanDate: json['lastScanDate'] == null ? null : DateTime.parse(json['lastScanDate'] as String),
);

Map<String, dynamic> _$LibrarySettingsToJson(_LibrarySettings instance) => <String, dynamic>{
  'libraryPath': instance.libraryPath,
  'watchedDirectories': instance.watchedDirectories,
  'autoImport': instance.autoImport,
  'supportedExtensions': instance.supportedExtensions,
  'lastScanDate': instance.lastScanDate?.toIso8601String(),
};
