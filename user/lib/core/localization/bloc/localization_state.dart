part of 'localization_bloc.dart';

@freezed
abstract class LocalizationState with _$LocalizationState {
  const factory LocalizationState({
    required Locale locale,
    required ThemeData themeData,
  }) = _LocalizationState;
}
