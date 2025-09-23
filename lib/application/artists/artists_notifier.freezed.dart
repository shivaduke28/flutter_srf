// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'artists_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ArtistsState {

 List<Artist> get allArtists; String get searchQuery; ArtistSortType get sortType;
/// Create a copy of ArtistsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArtistsStateCopyWith<ArtistsState> get copyWith => _$ArtistsStateCopyWithImpl<ArtistsState>(this as ArtistsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArtistsState&&const DeepCollectionEquality().equals(other.allArtists, allArtists)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.sortType, sortType) || other.sortType == sortType));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(allArtists),searchQuery,sortType);

@override
String toString() {
  return 'ArtistsState(allArtists: $allArtists, searchQuery: $searchQuery, sortType: $sortType)';
}


}

/// @nodoc
abstract mixin class $ArtistsStateCopyWith<$Res>  {
  factory $ArtistsStateCopyWith(ArtistsState value, $Res Function(ArtistsState) _then) = _$ArtistsStateCopyWithImpl;
@useResult
$Res call({
 List<Artist> allArtists, String searchQuery, ArtistSortType sortType
});




}
/// @nodoc
class _$ArtistsStateCopyWithImpl<$Res>
    implements $ArtistsStateCopyWith<$Res> {
  _$ArtistsStateCopyWithImpl(this._self, this._then);

  final ArtistsState _self;
  final $Res Function(ArtistsState) _then;

/// Create a copy of ArtistsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? allArtists = null,Object? searchQuery = null,Object? sortType = null,}) {
  return _then(_self.copyWith(
allArtists: null == allArtists ? _self.allArtists : allArtists // ignore: cast_nullable_to_non_nullable
as List<Artist>,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,sortType: null == sortType ? _self.sortType : sortType // ignore: cast_nullable_to_non_nullable
as ArtistSortType,
  ));
}

}


/// Adds pattern-matching-related methods to [ArtistsState].
extension ArtistsStatePatterns on ArtistsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ArtistsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ArtistsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ArtistsState value)  $default,){
final _that = this;
switch (_that) {
case _ArtistsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ArtistsState value)?  $default,){
final _that = this;
switch (_that) {
case _ArtistsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Artist> allArtists,  String searchQuery,  ArtistSortType sortType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ArtistsState() when $default != null:
return $default(_that.allArtists,_that.searchQuery,_that.sortType);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Artist> allArtists,  String searchQuery,  ArtistSortType sortType)  $default,) {final _that = this;
switch (_that) {
case _ArtistsState():
return $default(_that.allArtists,_that.searchQuery,_that.sortType);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Artist> allArtists,  String searchQuery,  ArtistSortType sortType)?  $default,) {final _that = this;
switch (_that) {
case _ArtistsState() when $default != null:
return $default(_that.allArtists,_that.searchQuery,_that.sortType);case _:
  return null;

}
}

}

/// @nodoc


class _ArtistsState implements ArtistsState {
  const _ArtistsState({required final  List<Artist> allArtists, required this.searchQuery, required this.sortType}): _allArtists = allArtists;
  

 final  List<Artist> _allArtists;
@override List<Artist> get allArtists {
  if (_allArtists is EqualUnmodifiableListView) return _allArtists;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_allArtists);
}

@override final  String searchQuery;
@override final  ArtistSortType sortType;

/// Create a copy of ArtistsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ArtistsStateCopyWith<_ArtistsState> get copyWith => __$ArtistsStateCopyWithImpl<_ArtistsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ArtistsState&&const DeepCollectionEquality().equals(other._allArtists, _allArtists)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.sortType, sortType) || other.sortType == sortType));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_allArtists),searchQuery,sortType);

@override
String toString() {
  return 'ArtistsState(allArtists: $allArtists, searchQuery: $searchQuery, sortType: $sortType)';
}


}

/// @nodoc
abstract mixin class _$ArtistsStateCopyWith<$Res> implements $ArtistsStateCopyWith<$Res> {
  factory _$ArtistsStateCopyWith(_ArtistsState value, $Res Function(_ArtistsState) _then) = __$ArtistsStateCopyWithImpl;
@override @useResult
$Res call({
 List<Artist> allArtists, String searchQuery, ArtistSortType sortType
});




}
/// @nodoc
class __$ArtistsStateCopyWithImpl<$Res>
    implements _$ArtistsStateCopyWith<$Res> {
  __$ArtistsStateCopyWithImpl(this._self, this._then);

  final _ArtistsState _self;
  final $Res Function(_ArtistsState) _then;

/// Create a copy of ArtistsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? allArtists = null,Object? searchQuery = null,Object? sortType = null,}) {
  return _then(_ArtistsState(
allArtists: null == allArtists ? _self._allArtists : allArtists // ignore: cast_nullable_to_non_nullable
as List<Artist>,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,sortType: null == sortType ? _self.sortType : sortType // ignore: cast_nullable_to_non_nullable
as ArtistSortType,
  ));
}


}

// dart format on
