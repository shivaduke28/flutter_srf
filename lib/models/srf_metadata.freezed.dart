// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'srf_metadata.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SrfMetadata {

 String get title; String get artist; double get duration; int? get trackNumber; List<String>? get artists; String? get album; String? get albumArtist; int? get year; String? get genre; String? get comment; DateTime? get dateAdded; DateTime? get lastModified;
/// Create a copy of SrfMetadata
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SrfMetadataCopyWith<SrfMetadata> get copyWith => _$SrfMetadataCopyWithImpl<SrfMetadata>(this as SrfMetadata, _$identity);

  /// Serializes this SrfMetadata to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SrfMetadata&&(identical(other.title, title) || other.title == title)&&(identical(other.artist, artist) || other.artist == artist)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.trackNumber, trackNumber) || other.trackNumber == trackNumber)&&const DeepCollectionEquality().equals(other.artists, artists)&&(identical(other.album, album) || other.album == album)&&(identical(other.albumArtist, albumArtist) || other.albumArtist == albumArtist)&&(identical(other.year, year) || other.year == year)&&(identical(other.genre, genre) || other.genre == genre)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.dateAdded, dateAdded) || other.dateAdded == dateAdded)&&(identical(other.lastModified, lastModified) || other.lastModified == lastModified));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,artist,duration,trackNumber,const DeepCollectionEquality().hash(artists),album,albumArtist,year,genre,comment,dateAdded,lastModified);

@override
String toString() {
  return 'SrfMetadata(title: $title, artist: $artist, duration: $duration, trackNumber: $trackNumber, artists: $artists, album: $album, albumArtist: $albumArtist, year: $year, genre: $genre, comment: $comment, dateAdded: $dateAdded, lastModified: $lastModified)';
}


}

/// @nodoc
abstract mixin class $SrfMetadataCopyWith<$Res>  {
  factory $SrfMetadataCopyWith(SrfMetadata value, $Res Function(SrfMetadata) _then) = _$SrfMetadataCopyWithImpl;
@useResult
$Res call({
 String title, String artist, double duration, int? trackNumber, List<String>? artists, String? album, String? albumArtist, int? year, String? genre, String? comment, DateTime? dateAdded, DateTime? lastModified
});




}
/// @nodoc
class _$SrfMetadataCopyWithImpl<$Res>
    implements $SrfMetadataCopyWith<$Res> {
  _$SrfMetadataCopyWithImpl(this._self, this._then);

  final SrfMetadata _self;
  final $Res Function(SrfMetadata) _then;

/// Create a copy of SrfMetadata
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? artist = null,Object? duration = null,Object? trackNumber = freezed,Object? artists = freezed,Object? album = freezed,Object? albumArtist = freezed,Object? year = freezed,Object? genre = freezed,Object? comment = freezed,Object? dateAdded = freezed,Object? lastModified = freezed,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,artist: null == artist ? _self.artist : artist // ignore: cast_nullable_to_non_nullable
as String,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as double,trackNumber: freezed == trackNumber ? _self.trackNumber : trackNumber // ignore: cast_nullable_to_non_nullable
as int?,artists: freezed == artists ? _self.artists : artists // ignore: cast_nullable_to_non_nullable
as List<String>?,album: freezed == album ? _self.album : album // ignore: cast_nullable_to_non_nullable
as String?,albumArtist: freezed == albumArtist ? _self.albumArtist : albumArtist // ignore: cast_nullable_to_non_nullable
as String?,year: freezed == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int?,genre: freezed == genre ? _self.genre : genre // ignore: cast_nullable_to_non_nullable
as String?,comment: freezed == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String?,dateAdded: freezed == dateAdded ? _self.dateAdded : dateAdded // ignore: cast_nullable_to_non_nullable
as DateTime?,lastModified: freezed == lastModified ? _self.lastModified : lastModified // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [SrfMetadata].
extension SrfMetadataPatterns on SrfMetadata {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SrfMetadata value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SrfMetadata() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SrfMetadata value)  $default,){
final _that = this;
switch (_that) {
case _SrfMetadata():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SrfMetadata value)?  $default,){
final _that = this;
switch (_that) {
case _SrfMetadata() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String artist,  double duration,  int? trackNumber,  List<String>? artists,  String? album,  String? albumArtist,  int? year,  String? genre,  String? comment,  DateTime? dateAdded,  DateTime? lastModified)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SrfMetadata() when $default != null:
return $default(_that.title,_that.artist,_that.duration,_that.trackNumber,_that.artists,_that.album,_that.albumArtist,_that.year,_that.genre,_that.comment,_that.dateAdded,_that.lastModified);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String artist,  double duration,  int? trackNumber,  List<String>? artists,  String? album,  String? albumArtist,  int? year,  String? genre,  String? comment,  DateTime? dateAdded,  DateTime? lastModified)  $default,) {final _that = this;
switch (_that) {
case _SrfMetadata():
return $default(_that.title,_that.artist,_that.duration,_that.trackNumber,_that.artists,_that.album,_that.albumArtist,_that.year,_that.genre,_that.comment,_that.dateAdded,_that.lastModified);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String artist,  double duration,  int? trackNumber,  List<String>? artists,  String? album,  String? albumArtist,  int? year,  String? genre,  String? comment,  DateTime? dateAdded,  DateTime? lastModified)?  $default,) {final _that = this;
switch (_that) {
case _SrfMetadata() when $default != null:
return $default(_that.title,_that.artist,_that.duration,_that.trackNumber,_that.artists,_that.album,_that.albumArtist,_that.year,_that.genre,_that.comment,_that.dateAdded,_that.lastModified);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SrfMetadata implements SrfMetadata {
  const _SrfMetadata({required this.title, required this.artist, required this.duration, this.trackNumber, final  List<String>? artists, this.album, this.albumArtist, this.year, this.genre, this.comment, this.dateAdded, this.lastModified}): _artists = artists;
  factory _SrfMetadata.fromJson(Map<String, dynamic> json) => _$SrfMetadataFromJson(json);

@override final  String title;
@override final  String artist;
@override final  double duration;
@override final  int? trackNumber;
 final  List<String>? _artists;
@override List<String>? get artists {
  final value = _artists;
  if (value == null) return null;
  if (_artists is EqualUnmodifiableListView) return _artists;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String? album;
@override final  String? albumArtist;
@override final  int? year;
@override final  String? genre;
@override final  String? comment;
@override final  DateTime? dateAdded;
@override final  DateTime? lastModified;

/// Create a copy of SrfMetadata
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SrfMetadataCopyWith<_SrfMetadata> get copyWith => __$SrfMetadataCopyWithImpl<_SrfMetadata>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SrfMetadataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SrfMetadata&&(identical(other.title, title) || other.title == title)&&(identical(other.artist, artist) || other.artist == artist)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.trackNumber, trackNumber) || other.trackNumber == trackNumber)&&const DeepCollectionEquality().equals(other._artists, _artists)&&(identical(other.album, album) || other.album == album)&&(identical(other.albumArtist, albumArtist) || other.albumArtist == albumArtist)&&(identical(other.year, year) || other.year == year)&&(identical(other.genre, genre) || other.genre == genre)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.dateAdded, dateAdded) || other.dateAdded == dateAdded)&&(identical(other.lastModified, lastModified) || other.lastModified == lastModified));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,artist,duration,trackNumber,const DeepCollectionEquality().hash(_artists),album,albumArtist,year,genre,comment,dateAdded,lastModified);

@override
String toString() {
  return 'SrfMetadata(title: $title, artist: $artist, duration: $duration, trackNumber: $trackNumber, artists: $artists, album: $album, albumArtist: $albumArtist, year: $year, genre: $genre, comment: $comment, dateAdded: $dateAdded, lastModified: $lastModified)';
}


}

/// @nodoc
abstract mixin class _$SrfMetadataCopyWith<$Res> implements $SrfMetadataCopyWith<$Res> {
  factory _$SrfMetadataCopyWith(_SrfMetadata value, $Res Function(_SrfMetadata) _then) = __$SrfMetadataCopyWithImpl;
@override @useResult
$Res call({
 String title, String artist, double duration, int? trackNumber, List<String>? artists, String? album, String? albumArtist, int? year, String? genre, String? comment, DateTime? dateAdded, DateTime? lastModified
});




}
/// @nodoc
class __$SrfMetadataCopyWithImpl<$Res>
    implements _$SrfMetadataCopyWith<$Res> {
  __$SrfMetadataCopyWithImpl(this._self, this._then);

  final _SrfMetadata _self;
  final $Res Function(_SrfMetadata) _then;

/// Create a copy of SrfMetadata
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? artist = null,Object? duration = null,Object? trackNumber = freezed,Object? artists = freezed,Object? album = freezed,Object? albumArtist = freezed,Object? year = freezed,Object? genre = freezed,Object? comment = freezed,Object? dateAdded = freezed,Object? lastModified = freezed,}) {
  return _then(_SrfMetadata(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,artist: null == artist ? _self.artist : artist // ignore: cast_nullable_to_non_nullable
as String,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as double,trackNumber: freezed == trackNumber ? _self.trackNumber : trackNumber // ignore: cast_nullable_to_non_nullable
as int?,artists: freezed == artists ? _self._artists : artists // ignore: cast_nullable_to_non_nullable
as List<String>?,album: freezed == album ? _self.album : album // ignore: cast_nullable_to_non_nullable
as String?,albumArtist: freezed == albumArtist ? _self.albumArtist : albumArtist // ignore: cast_nullable_to_non_nullable
as String?,year: freezed == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int?,genre: freezed == genre ? _self.genre : genre // ignore: cast_nullable_to_non_nullable
as String?,comment: freezed == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String?,dateAdded: freezed == dateAdded ? _self.dateAdded : dateAdded // ignore: cast_nullable_to_non_nullable
as DateTime?,lastModified: freezed == lastModified ? _self.lastModified : lastModified // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
