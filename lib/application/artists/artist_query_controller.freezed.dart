// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'artist_query_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ArtistQueryState {

 String get searchQuery; ArtistSortType get sortType;
/// Create a copy of ArtistQueryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArtistQueryStateCopyWith<ArtistQueryState> get copyWith => _$ArtistQueryStateCopyWithImpl<ArtistQueryState>(this as ArtistQueryState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArtistQueryState&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.sortType, sortType) || other.sortType == sortType));
}


@override
int get hashCode => Object.hash(runtimeType,searchQuery,sortType);

@override
String toString() {
  return 'ArtistQueryState(searchQuery: $searchQuery, sortType: $sortType)';
}


}

/// @nodoc
abstract mixin class $ArtistQueryStateCopyWith<$Res>  {
  factory $ArtistQueryStateCopyWith(ArtistQueryState value, $Res Function(ArtistQueryState) _then) = _$ArtistQueryStateCopyWithImpl;
@useResult
$Res call({
 String searchQuery, ArtistSortType sortType
});




}
/// @nodoc
class _$ArtistQueryStateCopyWithImpl<$Res>
    implements $ArtistQueryStateCopyWith<$Res> {
  _$ArtistQueryStateCopyWithImpl(this._self, this._then);

  final ArtistQueryState _self;
  final $Res Function(ArtistQueryState) _then;

/// Create a copy of ArtistQueryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? searchQuery = null,Object? sortType = null,}) {
  return _then(_self.copyWith(
searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,sortType: null == sortType ? _self.sortType : sortType // ignore: cast_nullable_to_non_nullable
as ArtistSortType,
  ));
}

}


/// Adds pattern-matching-related methods to [ArtistQueryState].
extension ArtistQueryStatePatterns on ArtistQueryState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ArtistQueryState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ArtistQueryState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ArtistQueryState value)  $default,){
final _that = this;
switch (_that) {
case _ArtistQueryState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ArtistQueryState value)?  $default,){
final _that = this;
switch (_that) {
case _ArtistQueryState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String searchQuery,  ArtistSortType sortType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ArtistQueryState() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String searchQuery,  ArtistSortType sortType)  $default,) {final _that = this;
switch (_that) {
case _ArtistQueryState():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String searchQuery,  ArtistSortType sortType)?  $default,) {final _that = this;
switch (_that) {
case _ArtistQueryState() when $default != null:
return $default(_that.searchQuery,_that.sortType);case _:
  return null;

}
}

}

/// @nodoc


class _ArtistQueryState implements ArtistQueryState {
  const _ArtistQueryState({required this.searchQuery, required this.sortType});
  

@override final  String searchQuery;
@override final  ArtistSortType sortType;

/// Create a copy of ArtistQueryState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ArtistQueryStateCopyWith<_ArtistQueryState> get copyWith => __$ArtistQueryStateCopyWithImpl<_ArtistQueryState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ArtistQueryState&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.sortType, sortType) || other.sortType == sortType));
}


@override
int get hashCode => Object.hash(runtimeType,searchQuery,sortType);

@override
String toString() {
  return 'ArtistQueryState(searchQuery: $searchQuery, sortType: $sortType)';
}


}

/// @nodoc
abstract mixin class _$ArtistQueryStateCopyWith<$Res> implements $ArtistQueryStateCopyWith<$Res> {
  factory _$ArtistQueryStateCopyWith(_ArtistQueryState value, $Res Function(_ArtistQueryState) _then) = __$ArtistQueryStateCopyWithImpl;
@override @useResult
$Res call({
 String searchQuery, ArtistSortType sortType
});




}
/// @nodoc
class __$ArtistQueryStateCopyWithImpl<$Res>
    implements _$ArtistQueryStateCopyWith<$Res> {
  __$ArtistQueryStateCopyWithImpl(this._self, this._then);

  final _ArtistQueryState _self;
  final $Res Function(_ArtistQueryState) _then;

/// Create a copy of ArtistQueryState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? searchQuery = null,Object? sortType = null,}) {
  return _then(_ArtistQueryState(
searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,sortType: null == sortType ? _self.sortType : sortType // ignore: cast_nullable_to_non_nullable
as ArtistSortType,
  ));
}


}

// dart format on
