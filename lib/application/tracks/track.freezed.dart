// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'track.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Track {

  String get id;

  String get title;

  String get artist;

  String get album;

  double get duration;

  String get filePath;

  DateTime? get createdAt;

  DateTime? get modifiedAt;

  /// Create a copy of Track
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TrackCopyWith<Track> get copyWith =>
      _$TrackCopyWithImpl<Track>(this as Track, _$identity);

  /// Serializes this Track to a JSON map.
  Map<String, dynamic> toJson();


  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is Track &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.artist, artist) || other.artist == artist) &&
            (identical(other.album, album) || other.album == album) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.filePath, filePath) ||
                other.filePath == filePath) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.modifiedAt, modifiedAt) ||
                other.modifiedAt == modifiedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(
          runtimeType,
          id,
          title,
          artist,
          album,
          duration,
          filePath,
          createdAt,
          modifiedAt);

  @override
  String toString() {
    return 'Track(id: $id, title: $title, artist: $artist, album: $album, duration: $duration, filePath: $filePath, createdAt: $createdAt, modifiedAt: $modifiedAt)';
  }


}

/// @nodoc
abstract mixin class $TrackCopyWith<$Res> {
  factory $TrackCopyWith(Track value,
      $Res Function(Track) _then) = _$TrackCopyWithImpl;

  @useResult
  $Res call({
    String id, String title, String artist, String album, double duration, String filePath, DateTime? createdAt, DateTime? modifiedAt
  });


}

/// @nodoc
class _$TrackCopyWithImpl<$Res>
    implements $TrackCopyWith<$Res> {
  _$TrackCopyWithImpl(this._self, this._then);

  final Track _self;
  final $Res Function(Track) _then;

  /// Create a copy of Track
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call(
      {Object? id = null, Object? title = null, Object? artist = null, Object? album = null, Object? duration = null, Object? filePath = null, Object? createdAt = freezed, Object? modifiedAt = freezed,}) {
    return _then(_self.copyWith(
      id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
      as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
      as String,
      artist: null == artist
          ? _self.artist
          : artist // ignore: cast_nullable_to_non_nullable
      as String,
      album: null == album
          ? _self.album
          : album // ignore: cast_nullable_to_non_nullable
      as String,
      duration: null == duration
          ? _self.duration
          : duration // ignore: cast_nullable_to_non_nullable
      as double,
      filePath: null == filePath
          ? _self.filePath
          : filePath // ignore: cast_nullable_to_non_nullable
      as String,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
      as DateTime?,
      modifiedAt: freezed == modifiedAt
          ? _self.modifiedAt
          : modifiedAt // ignore: cast_nullable_to_non_nullable
      as DateTime?,
    ));
  }

}


/// Adds pattern-matching-related methods to [Track].
extension TrackPatterns on Track {
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

  @optionalTypeArgs TResult maybeMap

  <

  TResult

  extends

  Object?

  >

  (

  TResult Function( _Track value)? $default,{required TResult orElse(),}){
  final _that = this;
  switch (_that) {
  case _Track() when $default != null:
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

  @optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Track value) $default,){
  final _that = this;
  switch (_that) {
  case _Track():
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

  @optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Track value)? $default,){
  final _that = this;
  switch (_that) {
  case _Track() when $default != null:
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

  @optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, String title, String artist, String album, double duration, String filePath, DateTime? createdAt, DateTime? modifiedAt)? $default,{required TResult orElse(),}) {final _that = this;
  switch (_that) {
  case _Track() when $default != null:
  return $default(_that.id,_that.title,_that.artist,_that.album,_that.duration,_that.filePath,_that.createdAt,_that.modifiedAt);case _:
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

  @optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, String title, String artist, String album, double duration, String filePath, DateTime? createdAt, DateTime? modifiedAt) $default,) {final _that = this;
  switch (_that) {
  case _Track():
  return $default(_that.id,_that.title,_that.artist,_that.album,_that.duration,_that.filePath,_that.createdAt,_that.modifiedAt);}
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

  @optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, String title, String artist, String album, double duration, String filePath, DateTime? createdAt, DateTime? modifiedAt)? $default,) {final _that = this;
  switch (_that) {
  case _Track() when $default != null:
  return $default(_that.id,_that.title,_that.artist,_that.album,_that.duration,_that.filePath,_that.createdAt,_that.modifiedAt);case _:
  return null;

  }
  }

}

/// @nodoc
@JsonSerializable()
class _Track implements Track {
  const _Track(
      {required this.id, required this.title, required this.artist, required this.album, required this.duration, required this.filePath, this.createdAt, this.modifiedAt});

  factory _Track.fromJson(Map<String, dynamic> json) => _$TrackFromJson(json);

  @override final String id;
  @override final String title;
  @override final String artist;
  @override final String album;
  @override final double duration;
  @override final String filePath;
  @override final DateTime? createdAt;
  @override final DateTime? modifiedAt;

  /// Create a copy of Track
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TrackCopyWith<_Track> get copyWith =>
      __$TrackCopyWithImpl<_Track>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TrackToJson(this,);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _Track &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.artist, artist) || other.artist == artist) &&
            (identical(other.album, album) || other.album == album) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.filePath, filePath) ||
                other.filePath == filePath) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.modifiedAt, modifiedAt) ||
                other.modifiedAt == modifiedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(
          runtimeType,
          id,
          title,
          artist,
          album,
          duration,
          filePath,
          createdAt,
          modifiedAt);

  @override
  String toString() {
    return 'Track(id: $id, title: $title, artist: $artist, album: $album, duration: $duration, filePath: $filePath, createdAt: $createdAt, modifiedAt: $modifiedAt)';
  }


}

/// @nodoc
abstract mixin class _$TrackCopyWith<$Res> implements $TrackCopyWith<$Res> {
  factory _$TrackCopyWith(_Track value,
      $Res Function(_Track) _then) = __$TrackCopyWithImpl;

  @override
  @useResult
  $Res call({
    String id, String title, String artist, String album, double duration, String filePath, DateTime? createdAt, DateTime? modifiedAt
  });


}

/// @nodoc
class __$TrackCopyWithImpl<$Res>
    implements _$TrackCopyWith<$Res> {
  __$TrackCopyWithImpl(this._self, this._then);

  final _Track _self;
  final $Res Function(_Track) _then;

  /// Create a copy of Track
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call(
      {Object? id = null, Object? title = null, Object? artist = null, Object? album = null, Object? duration = null, Object? filePath = null, Object? createdAt = freezed, Object? modifiedAt = freezed,}) {
    return _then(_Track(
      id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
      as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
      as String,
      artist: null == artist
          ? _self.artist
          : artist // ignore: cast_nullable_to_non_nullable
      as String,
      album: null == album
          ? _self.album
          : album // ignore: cast_nullable_to_non_nullable
      as String,
      duration: null == duration
          ? _self.duration
          : duration // ignore: cast_nullable_to_non_nullable
      as double,
      filePath: null == filePath
          ? _self.filePath
          : filePath // ignore: cast_nullable_to_non_nullable
      as String,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
      as DateTime?,
      modifiedAt: freezed == modifiedAt
          ? _self.modifiedAt
          : modifiedAt // ignore: cast_nullable_to_non_nullable
      as DateTime?,
    ));
  }


}

// dart format on
