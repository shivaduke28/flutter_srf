// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'albums_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AlbumsState {

 List<AlbumInfo> get allAlbums; String get searchQuery; AlbumSortType get sortType;
/// Create a copy of AlbumsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AlbumsStateCopyWith<AlbumsState> get copyWith => _$AlbumsStateCopyWithImpl<AlbumsState>(this as AlbumsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AlbumsState&&const DeepCollectionEquality().equals(other.allAlbums, allAlbums)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.sortType, sortType) || other.sortType == sortType));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(allAlbums),searchQuery,sortType);

@override
String toString() {
  return 'AlbumsState(allAlbums: $allAlbums, searchQuery: $searchQuery, sortType: $sortType)';
}


}

/// @nodoc
abstract mixin class $AlbumsStateCopyWith<$Res>  {
  factory $AlbumsStateCopyWith(AlbumsState value, $Res Function(AlbumsState) _then) = _$AlbumsStateCopyWithImpl;
@useResult
$Res call({
 List<AlbumInfo> allAlbums, String searchQuery, AlbumSortType sortType
});




}
/// @nodoc
class _$AlbumsStateCopyWithImpl<$Res>
    implements $AlbumsStateCopyWith<$Res> {
  _$AlbumsStateCopyWithImpl(this._self, this._then);

  final AlbumsState _self;
  final $Res Function(AlbumsState) _then;

/// Create a copy of AlbumsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? allAlbums = null,Object? searchQuery = null,Object? sortType = null,}) {
  return _then(_self.copyWith(
allAlbums: null == allAlbums ? _self.allAlbums : allAlbums // ignore: cast_nullable_to_non_nullable
as List<AlbumInfo>,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,sortType: null == sortType ? _self.sortType : sortType // ignore: cast_nullable_to_non_nullable
as AlbumSortType,
  ));
}

}


/// Adds pattern-matching-related methods to [AlbumsState].
extension AlbumsStatePatterns on AlbumsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AlbumsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AlbumsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AlbumsState value)  $default,){
final _that = this;
switch (_that) {
case _AlbumsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AlbumsState value)?  $default,){
final _that = this;
switch (_that) {
case _AlbumsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<AlbumInfo> allAlbums,  String searchQuery,  AlbumSortType sortType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AlbumsState() when $default != null:
return $default(_that.allAlbums,_that.searchQuery,_that.sortType);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<AlbumInfo> allAlbums,  String searchQuery,  AlbumSortType sortType)  $default,) {final _that = this;
switch (_that) {
case _AlbumsState():
return $default(_that.allAlbums,_that.searchQuery,_that.sortType);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<AlbumInfo> allAlbums,  String searchQuery,  AlbumSortType sortType)?  $default,) {final _that = this;
switch (_that) {
case _AlbumsState() when $default != null:
return $default(_that.allAlbums,_that.searchQuery,_that.sortType);case _:
  return null;

}
}

}

/// @nodoc


class _AlbumsState implements AlbumsState {
  const _AlbumsState({required final  List<AlbumInfo> allAlbums, required this.searchQuery, required this.sortType}): _allAlbums = allAlbums;
  

 final  List<AlbumInfo> _allAlbums;
@override List<AlbumInfo> get allAlbums {
  if (_allAlbums is EqualUnmodifiableListView) return _allAlbums;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_allAlbums);
}

@override final  String searchQuery;
@override final  AlbumSortType sortType;

/// Create a copy of AlbumsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AlbumsStateCopyWith<_AlbumsState> get copyWith => __$AlbumsStateCopyWithImpl<_AlbumsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AlbumsState&&const DeepCollectionEquality().equals(other._allAlbums, _allAlbums)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.sortType, sortType) || other.sortType == sortType));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_allAlbums),searchQuery,sortType);

@override
String toString() {
  return 'AlbumsState(allAlbums: $allAlbums, searchQuery: $searchQuery, sortType: $sortType)';
}


}

/// @nodoc
abstract mixin class _$AlbumsStateCopyWith<$Res> implements $AlbumsStateCopyWith<$Res> {
  factory _$AlbumsStateCopyWith(_AlbumsState value, $Res Function(_AlbumsState) _then) = __$AlbumsStateCopyWithImpl;
@override @useResult
$Res call({
 List<AlbumInfo> allAlbums, String searchQuery, AlbumSortType sortType
});




}
/// @nodoc
class __$AlbumsStateCopyWithImpl<$Res>
    implements _$AlbumsStateCopyWith<$Res> {
  __$AlbumsStateCopyWithImpl(this._self, this._then);

  final _AlbumsState _self;
  final $Res Function(_AlbumsState) _then;

/// Create a copy of AlbumsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? allAlbums = null,Object? searchQuery = null,Object? sortType = null,}) {
  return _then(_AlbumsState(
allAlbums: null == allAlbums ? _self._allAlbums : allAlbums // ignore: cast_nullable_to_non_nullable
as List<AlbumInfo>,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,sortType: null == sortType ? _self.sortType : sortType // ignore: cast_nullable_to_non_nullable
as AlbumSortType,
  ));
}


}

// dart format on
