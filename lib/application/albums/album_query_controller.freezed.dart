// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'album_query_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AlbumQueryState {

 String get searchQuery; AlbumSortType get sortType;
/// Create a copy of AlbumQueryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AlbumQueryStateCopyWith<AlbumQueryState> get copyWith => _$AlbumQueryStateCopyWithImpl<AlbumQueryState>(this as AlbumQueryState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AlbumQueryState&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.sortType, sortType) || other.sortType == sortType));
}


@override
int get hashCode => Object.hash(runtimeType,searchQuery,sortType);

@override
String toString() {
  return 'AlbumQueryState(searchQuery: $searchQuery, sortType: $sortType)';
}


}

/// @nodoc
abstract mixin class $AlbumQueryStateCopyWith<$Res>  {
  factory $AlbumQueryStateCopyWith(AlbumQueryState value, $Res Function(AlbumQueryState) _then) = _$AlbumQueryStateCopyWithImpl;
@useResult
$Res call({
 String searchQuery, AlbumSortType sortType
});




}
/// @nodoc
class _$AlbumQueryStateCopyWithImpl<$Res>
    implements $AlbumQueryStateCopyWith<$Res> {
  _$AlbumQueryStateCopyWithImpl(this._self, this._then);

  final AlbumQueryState _self;
  final $Res Function(AlbumQueryState) _then;

/// Create a copy of AlbumQueryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? searchQuery = null,Object? sortType = null,}) {
  return _then(_self.copyWith(
searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,sortType: null == sortType ? _self.sortType : sortType // ignore: cast_nullable_to_non_nullable
as AlbumSortType,
  ));
}

}


/// Adds pattern-matching-related methods to [AlbumQueryState].
extension AlbumQueryStatePatterns on AlbumQueryState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AlbumQueryState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AlbumQueryState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AlbumQueryState value)  $default,){
final _that = this;
switch (_that) {
case _AlbumQueryState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AlbumQueryState value)?  $default,){
final _that = this;
switch (_that) {
case _AlbumQueryState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String searchQuery,  AlbumSortType sortType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AlbumQueryState() when $default != null:
return $default(_that.searchQuery,_that.sortType);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String searchQuery,  AlbumSortType sortType)  $default,) {final _that = this;
switch (_that) {
case _AlbumQueryState():
return $default(_that.searchQuery,_that.sortType);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String searchQuery,  AlbumSortType sortType)?  $default,) {final _that = this;
switch (_that) {
case _AlbumQueryState() when $default != null:
return $default(_that.searchQuery,_that.sortType);case _:
  return null;

}
}

}

/// @nodoc


class _AlbumQueryState implements AlbumQueryState {
  const _AlbumQueryState({required this.searchQuery, required this.sortType});
  

@override final  String searchQuery;
@override final  AlbumSortType sortType;

/// Create a copy of AlbumQueryState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AlbumQueryStateCopyWith<_AlbumQueryState> get copyWith => __$AlbumQueryStateCopyWithImpl<_AlbumQueryState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AlbumQueryState&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.sortType, sortType) || other.sortType == sortType));
}


@override
int get hashCode => Object.hash(runtimeType,searchQuery,sortType);

@override
String toString() {
  return 'AlbumQueryState(searchQuery: $searchQuery, sortType: $sortType)';
}


}

/// @nodoc
abstract mixin class _$AlbumQueryStateCopyWith<$Res> implements $AlbumQueryStateCopyWith<$Res> {
  factory _$AlbumQueryStateCopyWith(_AlbumQueryState value, $Res Function(_AlbumQueryState) _then) = __$AlbumQueryStateCopyWithImpl;
@override @useResult
$Res call({
 String searchQuery, AlbumSortType sortType
});




}
/// @nodoc
class __$AlbumQueryStateCopyWithImpl<$Res>
    implements _$AlbumQueryStateCopyWith<$Res> {
  __$AlbumQueryStateCopyWithImpl(this._self, this._then);

  final _AlbumQueryState _self;
  final $Res Function(_AlbumQueryState) _then;

/// Create a copy of AlbumQueryState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? searchQuery = null,Object? sortType = null,}) {
  return _then(_AlbumQueryState(
searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,sortType: null == sortType ? _self.sortType : sortType // ignore: cast_nullable_to_non_nullable
as AlbumSortType,
  ));
}


}

// dart format on
