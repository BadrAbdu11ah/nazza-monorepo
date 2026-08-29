part of 'localization_bloc.dart';

@freezed
class LocalizationEvent with _$LocalizationEvent {
  const factory LocalizationEvent.loadSavedLocalization() =
      _LoadSavedLocalization;
  const factory LocalizationEvent.changeLocalization(String langCode) =
      _ChangeLocalization;
}
