// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'srf_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SrfMetadata _$SrfMetadataFromJson(Map<String, dynamic> json) => _SrfMetadata(
  title: json['title'] as String,
  artist: json['artist'] as String,
  duration: (json['duration'] as num).toDouble(),
  trackNumber: (json['trackNumber'] as num?)?.toInt(),
  artists: (json['artists'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  album: json['album'] as String?,
  albumArtist: json['albumArtist'] as String?,
  year: (json['year'] as num?)?.toInt(),
  genre: json['genre'] as String?,
  comment: json['comment'] as String?,
  dateAdded: json['dateAdded'] == null
      ? null
      : DateTime.parse(json['dateAdded'] as String),
  lastModified: json['lastModified'] == null
      ? null
      : DateTime.parse(json['lastModified'] as String),
);

Map<String, dynamic> _$SrfMetadataToJson(_SrfMetadata instance) =>
    <String, dynamic>{
      'title': instance.title,
      'artist': instance.artist,
      'duration': instance.duration,
      'trackNumber': instance.trackNumber,
      'artists': instance.artists,
      'album': instance.album,
      'albumArtist': instance.albumArtist,
      'year': instance.year,
      'genre': instance.genre,
      'comment': instance.comment,
      'dateAdded': instance.dateAdded?.toIso8601String(),
      'lastModified': instance.lastModified?.toIso8601String(),
    };
