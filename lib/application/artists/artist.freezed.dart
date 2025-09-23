// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'artist.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Artist {

  String get id;

  String get name;

  List<String> get albumIds;

  List<String> get trackIds;

  /// Create a copy of Artist
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ArtistCopyWith<Artist> get copyWith =>
      _$ArtistCopyWithImpl<Artist>(this as Artist, _$identity);

  /// Serializes this Artist to a JSON map.
  Map<String, dynamic> toJson();


  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is Artist &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other.albumIds, albumIds) &&
            const DeepCollectionEquality().equals(other.trackIds, trackIds));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(
          runtimeType, id, name, const DeepCollectionEquality().hash(albumIds),
          const DeepCollectionEquality().hash(trackIds));

  @override
  String toString() {
    return 'Artist(id: $id, name: $name, albumIds: $albumIds, trackIds: $trackIds)';
  }


}

/// @nodoc
abstract mixin class $ArtistCopyWith<$Res> {
  factory $ArtistCopyWith(Artist value,
      $Res Function(Artist) _then) = _$ArtistCopyWithImpl;

  @useResult
  $Res call({
    String id, String name, List<String> albumIds, List<String> trackIds
  });


}

/// @nodoc
class _$ArtistCopyWithImpl<$Res>
    implements $ArtistCopyWith<$Res> {
  _$ArtistCopyWithImpl(this._self, this._then);

  final Artist _self;
  final $Res Function(Artist) _then;

  /// Create a copy of Artist
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call(
      {Object? id = null, Object? name = null, Object? albumIds = null, Object? trackIds = null,}) {
    return _then(_self.copyWith(
      id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
      as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
      as String,
      albumIds: null == albumIds
          ? _self.albumIds
          : albumIds // ignore: cast_nullable_to_non_nullable
      as List<String>,
      trackIds: null == trackIds
          ? _self.trackIds
          : trackIds // ignore: cast_nullable_to_non_nullable
      as List<String>,
    ));
  }

}


/// Adds pattern-matching-related methods to [Artist].
extension ArtistPatterns on Artist {
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

  TResult Function( _Artist value)? $default,{required TResult orElse(),}){
  final _that = this;
  switch (_that) {
  case _Artist() when $default != null:
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

  @optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Artist value) $default,){
  final _that = this;
  switch (_that) {
  case _Artist():
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

  @optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Artist value)? $default,){
  final _that = this;
  switch (_that) {
  case _Artist() when $default != null:
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

  @optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, String name, List<String> albumIds, List<String> trackIds)? $default,{required TResult orElse(),}) {final _that = this;
  switch (_that) {
  case _Artist() when $default != null:
  return $default(_that.id,_that.name,_that.albumIds,_that.trackIds);case _:
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

  @optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, String name, List<String> albumIds, List<String> trackIds) $default,) {final _that = this;
  switch (_that) {
  case _Artist():
  return $default(_that.id,_that.name,_that.albumIds,_that.trackIds);}
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

  @optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, String name, List<String> albumIds, List<String> trackIds)? $default,) {final _that = this;
  switch (_that) {
  case _Artist() when $default != null:
  return $default(_that.id,_that.name,_that.albumIds,_that.trackIds);case _:
  return null;

  }
  }

}

/// @nodoc
@JsonSerializable()
class _Artist implements Artist {
  const _Artist({required this.id, required this.name, required final List<
      String> albumIds, required final List<String> trackIds})
      : _albumIds = albumIds,
        _trackIds = trackIds;

  factory _Artist.fromJson(Map<String, dynamic> json) => _$ArtistFromJson(json);

  @override final String id;
  @override final String name;
  final List<String> _albumIds;

  @override List<String> get albumIds {
    if (_albumIds is EqualUnmodifiableListView) return _albumIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_albumIds);
  }

  final List<String> _trackIds;

  @override List<String> get trackIds {
    if (_trackIds is EqualUnmodifiableListView) return _trackIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_trackIds);
  }


  /// Create a copy of Artist
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ArtistCopyWith<_Artist> get copyWith =>
      __$ArtistCopyWithImpl<_Artist>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ArtistToJson(this,);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _Artist &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._albumIds, _albumIds) &&
            const DeepCollectionEquality().equals(other._trackIds, _trackIds));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(
          runtimeType, id, name, const DeepCollectionEquality().hash(_albumIds),
          const DeepCollectionEquality().hash(_trackIds));

  @override
  String toString() {
    return 'Artist(id: $id, name: $name, albumIds: $albumIds, trackIds: $trackIds)';
  }


}

/// @nodoc
abstract mixin class _$ArtistCopyWith<$Res> implements $ArtistCopyWith<$Res> {
  factory _$ArtistCopyWith(_Artist value,
      $Res Function(_Artist) _then) = __$ArtistCopyWithImpl;

  @override
  @useResult
  $Res call({
    String id, String name, List<String> albumIds, List<String> trackIds
  });


}

/// @nodoc
class __$ArtistCopyWithImpl<$Res>
    implements _$ArtistCopyWith<$Res> {
  __$ArtistCopyWithImpl(this._self, this._then);

  final _Artist _self;
  final $Res Function(_Artist) _then;

  /// Create a copy of Artist
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call(
      {Object? id = null, Object? name = null, Object? albumIds = null, Object? trackIds = null,}) {
    return _then(_Artist(
      id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
      as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
      as String,
      albumIds: null == albumIds
          ? _self._albumIds
          : albumIds // ignore: cast_nullable_to_non_nullable
      as List<String>,
      trackIds: null == trackIds
          ? _self._trackIds
          : trackIds // ignore: cast_nullable_to_non_nullable
      as List<String>,
    ));
  }


}

// dart format on
