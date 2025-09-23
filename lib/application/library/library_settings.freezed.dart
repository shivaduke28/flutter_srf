// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'library_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LibrarySettings {

  String get libraryPath;

  List<String> get watchedDirectories;

  bool get autoImport;

  List<String> get supportedExtensions;

  DateTime? get lastScanDate;

  /// Create a copy of LibrarySettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LibrarySettingsCopyWith<LibrarySettings> get copyWith =>
      _$LibrarySettingsCopyWithImpl<LibrarySettings>(
          this as LibrarySettings, _$identity);

  /// Serializes this LibrarySettings to a JSON map.
  Map<String, dynamic> toJson();


  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is LibrarySettings &&
            (identical(other.libraryPath, libraryPath) ||
                other.libraryPath == libraryPath) &&
            const DeepCollectionEquality().equals(
                other.watchedDirectories, watchedDirectories) &&
            (identical(other.autoImport, autoImport) ||
                other.autoImport == autoImport) &&
            const DeepCollectionEquality().equals(
                other.supportedExtensions, supportedExtensions) &&
            (identical(other.lastScanDate, lastScanDate) ||
                other.lastScanDate == lastScanDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, libraryPath,
      const DeepCollectionEquality().hash(watchedDirectories), autoImport,
      const DeepCollectionEquality().hash(supportedExtensions), lastScanDate);

  @override
  String toString() {
    return 'LibrarySettings(libraryPath: $libraryPath, watchedDirectories: $watchedDirectories, autoImport: $autoImport, supportedExtensions: $supportedExtensions, lastScanDate: $lastScanDate)';
  }


}

/// @nodoc
abstract mixin class $LibrarySettingsCopyWith<$Res> {
  factory $LibrarySettingsCopyWith(LibrarySettings value,
      $Res Function(LibrarySettings) _then) = _$LibrarySettingsCopyWithImpl;

  @useResult
  $Res call({
    String libraryPath, List<String> watchedDirectories, bool autoImport, List<
        String> supportedExtensions, DateTime? lastScanDate
  });


}

/// @nodoc
class _$LibrarySettingsCopyWithImpl<$Res>
    implements $LibrarySettingsCopyWith<$Res> {
  _$LibrarySettingsCopyWithImpl(this._self, this._then);

  final LibrarySettings _self;
  final $Res Function(LibrarySettings) _then;

  /// Create a copy of LibrarySettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call(
      {Object? libraryPath = null, Object? watchedDirectories = null, Object? autoImport = null, Object? supportedExtensions = null, Object? lastScanDate = freezed,}) {
    return _then(_self.copyWith(
      libraryPath: null == libraryPath
          ? _self.libraryPath
          : libraryPath // ignore: cast_nullable_to_non_nullable
      as String,
      watchedDirectories: null == watchedDirectories
          ? _self.watchedDirectories
          : watchedDirectories // ignore: cast_nullable_to_non_nullable
      as List<String>,
      autoImport: null == autoImport
          ? _self.autoImport
          : autoImport // ignore: cast_nullable_to_non_nullable
      as bool,
      supportedExtensions: null == supportedExtensions
          ? _self.supportedExtensions
          : supportedExtensions // ignore: cast_nullable_to_non_nullable
      as List<String>,
      lastScanDate: freezed == lastScanDate
          ? _self.lastScanDate
          : lastScanDate // ignore: cast_nullable_to_non_nullable
      as DateTime?,
    ));
  }

}


/// Adds pattern-matching-related methods to [LibrarySettings].
extension LibrarySettingsPatterns on LibrarySettings {
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

  TResult Function( _LibrarySettings value)? $default,{required TResult orElse(),}){
  final _that = this;
  switch (_that) {
  case _LibrarySettings() when $default != null:
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

  @optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LibrarySettings value) $default,){
  final _that = this;
  switch (_that) {
  case _LibrarySettings():
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

  @optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LibrarySettings value)? $default,){
  final _that = this;
  switch (_that) {
  case _LibrarySettings() when $default != null:
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

  @optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String libraryPath, List<String> watchedDirectories, bool autoImport, List<String> supportedExtensions, DateTime? lastScanDate)? $default,{required TResult orElse(),}) {final _that = this;
  switch (_that) {
  case _LibrarySettings() when $default != null:
  return $default(_that.libraryPath,_that.watchedDirectories,_that.autoImport,_that.supportedExtensions,_that.lastScanDate);case _:
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

  @optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String libraryPath, List<String> watchedDirectories, bool autoImport, List<String> supportedExtensions, DateTime? lastScanDate) $default,) {final _that = this;
  switch (_that) {
  case _LibrarySettings():
  return $default(_that.libraryPath,_that.watchedDirectories,_that.autoImport,_that.supportedExtensions,_that.lastScanDate);}
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

  @optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String libraryPath, List<String> watchedDirectories, bool autoImport, List<String> supportedExtensions, DateTime? lastScanDate)? $default,) {final _that = this;
  switch (_that) {
  case _LibrarySettings() when $default != null:
  return $default(_that.libraryPath,_that.watchedDirectories,_that.autoImport,_that.supportedExtensions,_that.lastScanDate);case _:
  return null;

  }
  }

}

/// @nodoc
@JsonSerializable()
class _LibrarySettings implements LibrarySettings {
  const _LibrarySettings({required this.libraryPath, required final List<
      String> watchedDirectories, required this.autoImport, required final List<
      String> supportedExtensions, this.lastScanDate})
      : _watchedDirectories = watchedDirectories,
        _supportedExtensions = supportedExtensions;

  factory _LibrarySettings.fromJson(Map<String, dynamic> json) =>
      _$LibrarySettingsFromJson(json);

  @override final String libraryPath;
  final List<String> _watchedDirectories;

  @override List<String> get watchedDirectories {
    if (_watchedDirectories is EqualUnmodifiableListView)
      return _watchedDirectories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_watchedDirectories);
  }

  @override final bool autoImport;
  final List<String> _supportedExtensions;

  @override List<String> get supportedExtensions {
    if (_supportedExtensions is EqualUnmodifiableListView)
      return _supportedExtensions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_supportedExtensions);
  }

  @override final DateTime? lastScanDate;

  /// Create a copy of LibrarySettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LibrarySettingsCopyWith<_LibrarySettings> get copyWith =>
      __$LibrarySettingsCopyWithImpl<_LibrarySettings>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$LibrarySettingsToJson(this,);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _LibrarySettings &&
            (identical(other.libraryPath, libraryPath) ||
                other.libraryPath == libraryPath) &&
            const DeepCollectionEquality().equals(
                other._watchedDirectories, _watchedDirectories) &&
            (identical(other.autoImport, autoImport) ||
                other.autoImport == autoImport) &&
            const DeepCollectionEquality().equals(
                other._supportedExtensions, _supportedExtensions) &&
            (identical(other.lastScanDate, lastScanDate) ||
                other.lastScanDate == lastScanDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, libraryPath,
      const DeepCollectionEquality().hash(_watchedDirectories), autoImport,
      const DeepCollectionEquality().hash(_supportedExtensions), lastScanDate);

  @override
  String toString() {
    return 'LibrarySettings(libraryPath: $libraryPath, watchedDirectories: $watchedDirectories, autoImport: $autoImport, supportedExtensions: $supportedExtensions, lastScanDate: $lastScanDate)';
  }


}

/// @nodoc
abstract mixin class _$LibrarySettingsCopyWith<$Res>
    implements $LibrarySettingsCopyWith<$Res> {
  factory _$LibrarySettingsCopyWith(_LibrarySettings value,
      $Res Function(_LibrarySettings) _then) = __$LibrarySettingsCopyWithImpl;

  @override
  @useResult
  $Res call({
    String libraryPath, List<String> watchedDirectories, bool autoImport, List<
        String> supportedExtensions, DateTime? lastScanDate
  });


}

/// @nodoc
class __$LibrarySettingsCopyWithImpl<$Res>
    implements _$LibrarySettingsCopyWith<$Res> {
  __$LibrarySettingsCopyWithImpl(this._self, this._then);

  final _LibrarySettings _self;
  final $Res Function(_LibrarySettings) _then;

  /// Create a copy of LibrarySettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call(
      {Object? libraryPath = null, Object? watchedDirectories = null, Object? autoImport = null, Object? supportedExtensions = null, Object? lastScanDate = freezed,}) {
    return _then(_LibrarySettings(
      libraryPath: null == libraryPath
          ? _self.libraryPath
          : libraryPath // ignore: cast_nullable_to_non_nullable
      as String,
      watchedDirectories: null == watchedDirectories
          ? _self._watchedDirectories
          : watchedDirectories // ignore: cast_nullable_to_non_nullable
      as List<String>,
      autoImport: null == autoImport
          ? _self.autoImport
          : autoImport // ignore: cast_nullable_to_non_nullable
      as bool,
      supportedExtensions: null == supportedExtensions
          ? _self._supportedExtensions
          : supportedExtensions // ignore: cast_nullable_to_non_nullable
      as List<String>,
      lastScanDate: freezed == lastScanDate
          ? _self.lastScanDate
          : lastScanDate // ignore: cast_nullable_to_non_nullable
      as DateTime?,
    ));
  }


}

// dart format on
