// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'track_query_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TrackQueryState {

 String get searchQuery; TrackSortType get sortType;
/// Create a copy of TrackQueryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrackQueryStateCopyWith<TrackQueryState> get copyWith => _$TrackQueryStateCopyWithImpl<TrackQueryState>(this as TrackQueryState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrackQueryState&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.sortType, sortType) || other.sortType == sortType));
}


@override
int get hashCode => Object.hash(runtimeType,searchQuery,sortType);

@override
String toString() {
  return 'TrackQueryState(searchQuery: $searchQuery, sortType: $sortType)';
}


}

/// @nodoc
abstract mixin class $TrackQueryStateCopyWith<$Res>  {
  factory $TrackQueryStateCopyWith(TrackQueryState value, $Res Function(TrackQueryState) _then) = _$TrackQueryStateCopyWithImpl;
@useResult
$Res call({
 String searchQuery, TrackSortType sortType
});




}
/// @nodoc
class _$TrackQueryStateCopyWithImpl<$Res>
    implements $TrackQueryStateCopyWith<$Res> {
  _$TrackQueryStateCopyWithImpl(this._self, this._then);

  final TrackQueryState _self;
  final $Res Function(TrackQueryState) _then;

/// Create a copy of TrackQueryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? searchQuery = null,Object? sortType = null,}) {
  return _then(_self.copyWith(
searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,sortType: null == sortType ? _self.sortType : sortType // ignore: cast_nullable_to_non_nullable
as TrackSortType,
  ));
}

}


/// Adds pattern-matching-related methods to [TrackQueryState].
extension TrackQueryStatePatterns on TrackQueryState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TrackQueryState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TrackQueryState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TrackQueryState value)  $default,){
final _that = this;
switch (_that) {
case _TrackQueryState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TrackQueryState value)?  $default,){
final _that = this;
switch (_that) {
case _TrackQueryState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String searchQuery,  TrackSortType sortType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TrackQueryState() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String searchQuery,  TrackSortType sortType)  $default,) {final _that = this;
switch (_that) {
case _TrackQueryState():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String searchQuery,  TrackSortType sortType)?  $default,) {final _that = this;
switch (_that) {
case _TrackQueryState() when $default != null:
return $default(_that.searchQuery,_that.sortType);case _:
  return null;

}
}

}

/// @nodoc


class _TrackQueryState implements TrackQueryState {
  const _TrackQueryState({required this.searchQuery, required this.sortType});
  

@override final  String searchQuery;
@override final  TrackSortType sortType;

/// Create a copy of TrackQueryState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrackQueryStateCopyWith<_TrackQueryState> get copyWith => __$TrackQueryStateCopyWithImpl<_TrackQueryState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrackQueryState&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.sortType, sortType) || other.sortType == sortType));
}


@override
int get hashCode => Object.hash(runtimeType,searchQuery,sortType);

@override
String toString() {
  return 'TrackQueryState(searchQuery: $searchQuery, sortType: $sortType)';
}


}

/// @nodoc
abstract mixin class _$TrackQueryStateCopyWith<$Res> implements $TrackQueryStateCopyWith<$Res> {
  factory _$TrackQueryStateCopyWith(_TrackQueryState value, $Res Function(_TrackQueryState) _then) = __$TrackQueryStateCopyWithImpl;
@override @useResult
$Res call({
 String searchQuery, TrackSortType sortType
});




}
/// @nodoc
class __$TrackQueryStateCopyWithImpl<$Res>
    implements _$TrackQueryStateCopyWith<$Res> {
  __$TrackQueryStateCopyWithImpl(this._self, this._then);

  final _TrackQueryState _self;
  final $Res Function(_TrackQueryState) _then;

/// Create a copy of TrackQueryState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? searchQuery = null,Object? sortType = null,}) {
  return _then(_TrackQueryState(
searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,sortType: null == sortType ? _self.sortType : sortType // ignore: cast_nullable_to_non_nullable
as TrackSortType,
  ));
}


}

// dart format on
