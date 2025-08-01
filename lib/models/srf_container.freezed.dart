// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'srf_container.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SrfContainer {

 String get id; String get name; String get path;@JsonKey(toJson: _metadataToJson) SrfMetadata get metadata; List<String> get audioFiles; DateTime? get createdAt; DateTime? get modifiedAt;
/// Create a copy of SrfContainer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SrfContainerCopyWith<SrfContainer> get copyWith => _$SrfContainerCopyWithImpl<SrfContainer>(this as SrfContainer, _$identity);

  /// Serializes this SrfContainer to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SrfContainer&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.path, path) || other.path == path)&&(identical(other.metadata, metadata) || other.metadata == metadata)&&const DeepCollectionEquality().equals(other.audioFiles, audioFiles)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.modifiedAt, modifiedAt) || other.modifiedAt == modifiedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,path,metadata,const DeepCollectionEquality().hash(audioFiles),createdAt,modifiedAt);

@override
String toString() {
  return 'SrfContainer(id: $id, name: $name, path: $path, metadata: $metadata, audioFiles: $audioFiles, createdAt: $createdAt, modifiedAt: $modifiedAt)';
}


}

/// @nodoc
abstract mixin class $SrfContainerCopyWith<$Res>  {
  factory $SrfContainerCopyWith(SrfContainer value, $Res Function(SrfContainer) _then) = _$SrfContainerCopyWithImpl;
@useResult
$Res call({
 String id, String name, String path,@JsonKey(toJson: _metadataToJson) SrfMetadata metadata, List<String> audioFiles, DateTime? createdAt, DateTime? modifiedAt
});


$SrfMetadataCopyWith<$Res> get metadata;

}
/// @nodoc
class _$SrfContainerCopyWithImpl<$Res>
    implements $SrfContainerCopyWith<$Res> {
  _$SrfContainerCopyWithImpl(this._self, this._then);

  final SrfContainer _self;
  final $Res Function(SrfContainer) _then;

/// Create a copy of SrfContainer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? path = null,Object? metadata = null,Object? audioFiles = null,Object? createdAt = freezed,Object? modifiedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as SrfMetadata,audioFiles: null == audioFiles ? _self.audioFiles : audioFiles // ignore: cast_nullable_to_non_nullable
as List<String>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,modifiedAt: freezed == modifiedAt ? _self.modifiedAt : modifiedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of SrfContainer
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SrfMetadataCopyWith<$Res> get metadata {
  
  return $SrfMetadataCopyWith<$Res>(_self.metadata, (value) {
    return _then(_self.copyWith(metadata: value));
  });
}
}


/// Adds pattern-matching-related methods to [SrfContainer].
extension SrfContainerPatterns on SrfContainer {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SrfContainer value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SrfContainer() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SrfContainer value)  $default,){
final _that = this;
switch (_that) {
case _SrfContainer():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SrfContainer value)?  $default,){
final _that = this;
switch (_that) {
case _SrfContainer() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String path, @JsonKey(toJson: _metadataToJson)  SrfMetadata metadata,  List<String> audioFiles,  DateTime? createdAt,  DateTime? modifiedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SrfContainer() when $default != null:
return $default(_that.id,_that.name,_that.path,_that.metadata,_that.audioFiles,_that.createdAt,_that.modifiedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String path, @JsonKey(toJson: _metadataToJson)  SrfMetadata metadata,  List<String> audioFiles,  DateTime? createdAt,  DateTime? modifiedAt)  $default,) {final _that = this;
switch (_that) {
case _SrfContainer():
return $default(_that.id,_that.name,_that.path,_that.metadata,_that.audioFiles,_that.createdAt,_that.modifiedAt);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String path, @JsonKey(toJson: _metadataToJson)  SrfMetadata metadata,  List<String> audioFiles,  DateTime? createdAt,  DateTime? modifiedAt)?  $default,) {final _that = this;
switch (_that) {
case _SrfContainer() when $default != null:
return $default(_that.id,_that.name,_that.path,_that.metadata,_that.audioFiles,_that.createdAt,_that.modifiedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SrfContainer implements SrfContainer {
  const _SrfContainer({required this.id, required this.name, required this.path, @JsonKey(toJson: _metadataToJson) required this.metadata, required final  List<String> audioFiles, this.createdAt, this.modifiedAt}): _audioFiles = audioFiles;
  factory _SrfContainer.fromJson(Map<String, dynamic> json) => _$SrfContainerFromJson(json);

@override final  String id;
@override final  String name;
@override final  String path;
@override@JsonKey(toJson: _metadataToJson) final  SrfMetadata metadata;
 final  List<String> _audioFiles;
@override List<String> get audioFiles {
  if (_audioFiles is EqualUnmodifiableListView) return _audioFiles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_audioFiles);
}

@override final  DateTime? createdAt;
@override final  DateTime? modifiedAt;

/// Create a copy of SrfContainer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SrfContainerCopyWith<_SrfContainer> get copyWith => __$SrfContainerCopyWithImpl<_SrfContainer>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SrfContainerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SrfContainer&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.path, path) || other.path == path)&&(identical(other.metadata, metadata) || other.metadata == metadata)&&const DeepCollectionEquality().equals(other._audioFiles, _audioFiles)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.modifiedAt, modifiedAt) || other.modifiedAt == modifiedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,path,metadata,const DeepCollectionEquality().hash(_audioFiles),createdAt,modifiedAt);

@override
String toString() {
  return 'SrfContainer(id: $id, name: $name, path: $path, metadata: $metadata, audioFiles: $audioFiles, createdAt: $createdAt, modifiedAt: $modifiedAt)';
}


}

/// @nodoc
abstract mixin class _$SrfContainerCopyWith<$Res> implements $SrfContainerCopyWith<$Res> {
  factory _$SrfContainerCopyWith(_SrfContainer value, $Res Function(_SrfContainer) _then) = __$SrfContainerCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String path,@JsonKey(toJson: _metadataToJson) SrfMetadata metadata, List<String> audioFiles, DateTime? createdAt, DateTime? modifiedAt
});


@override $SrfMetadataCopyWith<$Res> get metadata;

}
/// @nodoc
class __$SrfContainerCopyWithImpl<$Res>
    implements _$SrfContainerCopyWith<$Res> {
  __$SrfContainerCopyWithImpl(this._self, this._then);

  final _SrfContainer _self;
  final $Res Function(_SrfContainer) _then;

/// Create a copy of SrfContainer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? path = null,Object? metadata = null,Object? audioFiles = null,Object? createdAt = freezed,Object? modifiedAt = freezed,}) {
  return _then(_SrfContainer(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as SrfMetadata,audioFiles: null == audioFiles ? _self._audioFiles : audioFiles // ignore: cast_nullable_to_non_nullable
as List<String>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,modifiedAt: freezed == modifiedAt ? _self.modifiedAt : modifiedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of SrfContainer
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SrfMetadataCopyWith<$Res> get metadata {
  
  return $SrfMetadataCopyWith<$Res>(_self.metadata, (value) {
    return _then(_self.copyWith(metadata: value));
  });
}
}

// dart format on
