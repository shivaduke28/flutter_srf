// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tracks_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TracksState {

 List<Track> get allTracks; String get searchQuery; TrackSortType get sortType;
/// Create a copy of TracksState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TracksStateCopyWith<TracksState> get copyWith => _$TracksStateCopyWithImpl<TracksState>(this as TracksState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TracksState&&const DeepCollectionEquality().equals(other.allTracks, allTracks)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.sortType, sortType) || other.sortType == sortType));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(allTracks),searchQuery,sortType);

@override
String toString() {
  return 'TracksState(allTracks: $allTracks, searchQuery: $searchQuery, sortType: $sortType)';
}


}

/// @nodoc
abstract mixin class $TracksStateCopyWith<$Res>  {
  factory $TracksStateCopyWith(TracksState value, $Res Function(TracksState) _then) = _$TracksStateCopyWithImpl;
@useResult
$Res call({
 List<Track> allTracks, String searchQuery, TrackSortType sortType
});




}
/// @nodoc
class _$TracksStateCopyWithImpl<$Res>
    implements $TracksStateCopyWith<$Res> {
  _$TracksStateCopyWithImpl(this._self, this._then);

  final TracksState _self;
  final $Res Function(TracksState) _then;

/// Create a copy of TracksState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? allTracks = null,Object? searchQuery = null,Object? sortType = null,}) {
  return _then(_self.copyWith(
allTracks: null == allTracks ? _self.allTracks : allTracks // ignore: cast_nullable_to_non_nullable
as List<Track>,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,sortType: null == sortType ? _self.sortType : sortType // ignore: cast_nullable_to_non_nullable
as TrackSortType,
  ));
}

}


/// Adds pattern-matching-related methods to [TracksState].
extension TracksStatePatterns on TracksState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TracksState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TracksState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TracksState value)  $default,){
final _that = this;
switch (_that) {
case _TracksState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TracksState value)?  $default,){
final _that = this;
switch (_that) {
case _TracksState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Track> allTracks,  String searchQuery,  TrackSortType sortType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TracksState() when $default != null:
return $default(_that.allTracks,_that.searchQuery,_that.sortType);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Track> allTracks,  String searchQuery,  TrackSortType sortType)  $default,) {final _that = this;
switch (_that) {
case _TracksState():
return $default(_that.allTracks,_that.searchQuery,_that.sortType);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Track> allTracks,  String searchQuery,  TrackSortType sortType)?  $default,) {final _that = this;
switch (_that) {
case _TracksState() when $default != null:
return $default(_that.allTracks,_that.searchQuery,_that.sortType);case _:
  return null;

}
}

}

/// @nodoc


class _TracksState implements TracksState {
  const _TracksState({required final  List<Track> allTracks, required this.searchQuery, required this.sortType}): _allTracks = allTracks;
  

 final  List<Track> _allTracks;
@override List<Track> get allTracks {
  if (_allTracks is EqualUnmodifiableListView) return _allTracks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_allTracks);
}

@override final  String searchQuery;
@override final  TrackSortType sortType;

/// Create a copy of TracksState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TracksStateCopyWith<_TracksState> get copyWith => __$TracksStateCopyWithImpl<_TracksState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TracksState&&const DeepCollectionEquality().equals(other._allTracks, _allTracks)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.sortType, sortType) || other.sortType == sortType));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_allTracks),searchQuery,sortType);

@override
String toString() {
  return 'TracksState(allTracks: $allTracks, searchQuery: $searchQuery, sortType: $sortType)';
}


}

/// @nodoc
abstract mixin class _$TracksStateCopyWith<$Res> implements $TracksStateCopyWith<$Res> {
  factory _$TracksStateCopyWith(_TracksState value, $Res Function(_TracksState) _then) = __$TracksStateCopyWithImpl;
@override @useResult
$Res call({
 List<Track> allTracks, String searchQuery, TrackSortType sortType
});




}
/// @nodoc
class __$TracksStateCopyWithImpl<$Res>
    implements _$TracksStateCopyWith<$Res> {
  __$TracksStateCopyWithImpl(this._self, this._then);

  final _TracksState _self;
  final $Res Function(_TracksState) _then;

/// Create a copy of TracksState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? allTracks = null,Object? searchQuery = null,Object? sortType = null,}) {
  return _then(_TracksState(
allTracks: null == allTracks ? _self._allTracks : allTracks // ignore: cast_nullable_to_non_nullable
as List<Track>,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,sortType: null == sortType ? _self.sortType : sortType // ignore: cast_nullable_to_non_nullable
as TrackSortType,
  ));
}


}

// dart format on
