// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'localization_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LocalizationEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocalizationEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LocalizationEvent()';
}


}

/// @nodoc
class $LocalizationEventCopyWith<$Res>  {
$LocalizationEventCopyWith(LocalizationEvent _, $Res Function(LocalizationEvent) __);
}


/// Adds pattern-matching-related methods to [LocalizationEvent].
extension LocalizationEventPatterns on LocalizationEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _LoadSavedLocalization value)?  loadSavedLocalization,TResult Function( _ChangeLocalization value)?  changeLocalization,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoadSavedLocalization() when loadSavedLocalization != null:
return loadSavedLocalization(_that);case _ChangeLocalization() when changeLocalization != null:
return changeLocalization(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _LoadSavedLocalization value)  loadSavedLocalization,required TResult Function( _ChangeLocalization value)  changeLocalization,}){
final _that = this;
switch (_that) {
case _LoadSavedLocalization():
return loadSavedLocalization(_that);case _ChangeLocalization():
return changeLocalization(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _LoadSavedLocalization value)?  loadSavedLocalization,TResult? Function( _ChangeLocalization value)?  changeLocalization,}){
final _that = this;
switch (_that) {
case _LoadSavedLocalization() when loadSavedLocalization != null:
return loadSavedLocalization(_that);case _ChangeLocalization() when changeLocalization != null:
return changeLocalization(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loadSavedLocalization,TResult Function( String langCode)?  changeLocalization,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoadSavedLocalization() when loadSavedLocalization != null:
return loadSavedLocalization();case _ChangeLocalization() when changeLocalization != null:
return changeLocalization(_that.langCode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loadSavedLocalization,required TResult Function( String langCode)  changeLocalization,}) {final _that = this;
switch (_that) {
case _LoadSavedLocalization():
return loadSavedLocalization();case _ChangeLocalization():
return changeLocalization(_that.langCode);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loadSavedLocalization,TResult? Function( String langCode)?  changeLocalization,}) {final _that = this;
switch (_that) {
case _LoadSavedLocalization() when loadSavedLocalization != null:
return loadSavedLocalization();case _ChangeLocalization() when changeLocalization != null:
return changeLocalization(_that.langCode);case _:
  return null;

}
}

}

/// @nodoc


class _LoadSavedLocalization implements LocalizationEvent {
  const _LoadSavedLocalization();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadSavedLocalization);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LocalizationEvent.loadSavedLocalization()';
}


}




/// @nodoc


class _ChangeLocalization implements LocalizationEvent {
  const _ChangeLocalization(this.langCode);
  

 final  String langCode;

/// Create a copy of LocalizationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChangeLocalizationCopyWith<_ChangeLocalization> get copyWith => __$ChangeLocalizationCopyWithImpl<_ChangeLocalization>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChangeLocalization&&(identical(other.langCode, langCode) || other.langCode == langCode));
}


@override
int get hashCode => Object.hash(runtimeType,langCode);

@override
String toString() {
  return 'LocalizationEvent.changeLocalization(langCode: $langCode)';
}


}

/// @nodoc
abstract mixin class _$ChangeLocalizationCopyWith<$Res> implements $LocalizationEventCopyWith<$Res> {
  factory _$ChangeLocalizationCopyWith(_ChangeLocalization value, $Res Function(_ChangeLocalization) _then) = __$ChangeLocalizationCopyWithImpl;
@useResult
$Res call({
 String langCode
});




}
/// @nodoc
class __$ChangeLocalizationCopyWithImpl<$Res>
    implements _$ChangeLocalizationCopyWith<$Res> {
  __$ChangeLocalizationCopyWithImpl(this._self, this._then);

  final _ChangeLocalization _self;
  final $Res Function(_ChangeLocalization) _then;

/// Create a copy of LocalizationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? langCode = null,}) {
  return _then(_ChangeLocalization(
null == langCode ? _self.langCode : langCode // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$LocalizationState {

 Locale get locale; ThemeData get themeData;
/// Create a copy of LocalizationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocalizationStateCopyWith<LocalizationState> get copyWith => _$LocalizationStateCopyWithImpl<LocalizationState>(this as LocalizationState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocalizationState&&(identical(other.locale, locale) || other.locale == locale)&&(identical(other.themeData, themeData) || other.themeData == themeData));
}


@override
int get hashCode => Object.hash(runtimeType,locale,themeData);

@override
String toString() {
  return 'LocalizationState(locale: $locale, themeData: $themeData)';
}


}

/// @nodoc
abstract mixin class $LocalizationStateCopyWith<$Res>  {
  factory $LocalizationStateCopyWith(LocalizationState value, $Res Function(LocalizationState) _then) = _$LocalizationStateCopyWithImpl;
@useResult
$Res call({
 Locale locale, ThemeData themeData
});




}
/// @nodoc
class _$LocalizationStateCopyWithImpl<$Res>
    implements $LocalizationStateCopyWith<$Res> {
  _$LocalizationStateCopyWithImpl(this._self, this._then);

  final LocalizationState _self;
  final $Res Function(LocalizationState) _then;

/// Create a copy of LocalizationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? locale = null,Object? themeData = null,}) {
  return _then(_self.copyWith(
locale: null == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as Locale,themeData: null == themeData ? _self.themeData : themeData // ignore: cast_nullable_to_non_nullable
as ThemeData,
  ));
}

}


/// Adds pattern-matching-related methods to [LocalizationState].
extension LocalizationStatePatterns on LocalizationState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LocalizationState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LocalizationState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LocalizationState value)  $default,){
final _that = this;
switch (_that) {
case _LocalizationState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LocalizationState value)?  $default,){
final _that = this;
switch (_that) {
case _LocalizationState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Locale locale,  ThemeData themeData)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LocalizationState() when $default != null:
return $default(_that.locale,_that.themeData);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Locale locale,  ThemeData themeData)  $default,) {final _that = this;
switch (_that) {
case _LocalizationState():
return $default(_that.locale,_that.themeData);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Locale locale,  ThemeData themeData)?  $default,) {final _that = this;
switch (_that) {
case _LocalizationState() when $default != null:
return $default(_that.locale,_that.themeData);case _:
  return null;

}
}

}

/// @nodoc


class _LocalizationState implements LocalizationState {
  const _LocalizationState({required this.locale, required this.themeData});
  

@override final  Locale locale;
@override final  ThemeData themeData;

/// Create a copy of LocalizationState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LocalizationStateCopyWith<_LocalizationState> get copyWith => __$LocalizationStateCopyWithImpl<_LocalizationState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LocalizationState&&(identical(other.locale, locale) || other.locale == locale)&&(identical(other.themeData, themeData) || other.themeData == themeData));
}


@override
int get hashCode => Object.hash(runtimeType,locale,themeData);

@override
String toString() {
  return 'LocalizationState(locale: $locale, themeData: $themeData)';
}


}

/// @nodoc
abstract mixin class _$LocalizationStateCopyWith<$Res> implements $LocalizationStateCopyWith<$Res> {
  factory _$LocalizationStateCopyWith(_LocalizationState value, $Res Function(_LocalizationState) _then) = __$LocalizationStateCopyWithImpl;
@override @useResult
$Res call({
 Locale locale, ThemeData themeData
});




}
/// @nodoc
class __$LocalizationStateCopyWithImpl<$Res>
    implements _$LocalizationStateCopyWith<$Res> {
  __$LocalizationStateCopyWithImpl(this._self, this._then);

  final _LocalizationState _self;
  final $Res Function(_LocalizationState) _then;

/// Create a copy of LocalizationState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? locale = null,Object? themeData = null,}) {
  return _then(_LocalizationState(
locale: null == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as Locale,themeData: null == themeData ? _self.themeData : themeData // ignore: cast_nullable_to_non_nullable
as ThemeData,
  ));
}


}

// dart format on
