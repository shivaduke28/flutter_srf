// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'srf_container.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SrfContainer _$SrfContainerFromJson(Map<String, dynamic> json) =>
    _SrfContainer(
      id: json['id'] as String,
      name: json['name'] as String,
      path: json['path'] as String,
      metadata: SrfMetadata.fromJson(json['metadata'] as Map<String, dynamic>),
      audioFiles: (json['audioFiles'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      modifiedAt: json['modifiedAt'] == null
          ? null
          : DateTime.parse(json['modifiedAt'] as String),
    );

Map<String, dynamic> _$SrfContainerToJson(_SrfContainer instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'path': instance.path,
      'metadata': instance.metadata,
      'audioFiles': instance.audioFiles,
      'createdAt': instance.createdAt?.toIso8601String(),
      'modifiedAt': instance.modifiedAt?.toIso8601String(),
    };
