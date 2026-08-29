import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_user/core/constant/app_theme.dart';
import 'package:frontend_user/core/services/app_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/material.dart';

part 'localization_event.dart';
part 'localization_state.dart';
part 'localization_bloc.freezed.dart';

class LocalizationBloc extends Bloc<LocalizationEvent, LocalizationState> {
  final AppService _appService = AppService();
  LocalizationBloc()
    : super(
        LocalizationState(locale: const Locale('en'), themeData: themeEnglish),
      ) {
    on<_LoadSavedLocalization>(
      (event, emit) => _onLoadSavedLocalization(event, emit),
    );
    on<_ChangeLocalization>(
      (event, emit) => _onChangeLocalization(event, emit),
    );
  }

  void _onLoadSavedLocalization(
    _LoadSavedLocalization event,
    Emitter<LocalizationState> emit,
  ) {
    final String? sharedPrefLang = _appService.sharedPreferences.getString(
      "lang",
    );

    if (sharedPrefLang == "ar") {
      emit(
        LocalizationState(locale: const Locale("ar"), themeData: themeArabic),
      );
    } else if (sharedPrefLang == "en") {
      emit(
        LocalizationState(locale: const Locale("en"), themeData: themeEnglish),
      );
    } else {
      final String deviceLang =
          WidgetsBinding.instance.platformDispatcher.locale.languageCode;
      if (deviceLang == "ar") {
        emit(
          LocalizationState(locale: const Locale("ar"), themeData: themeArabic),
        );
      } else {
        emit(
          LocalizationState(
            locale: const Locale("en"),
            themeData: themeEnglish,
          ),
        );
      }
    }
  }

  void _onChangeLocalization(
    _ChangeLocalization event,
    Emitter<LocalizationState> emit,
  ) {
    final locale = Locale(event.langCode);
    _appService.sharedPreferences.setString("lang", event.langCode);
    _appService.sharedPreferences.setString("step", "0");

    emit(
      LocalizationState(
        locale: locale,
        themeData: event.langCode == "ar" ? themeArabic : themeEnglish,
      ),
    );
  }
}
