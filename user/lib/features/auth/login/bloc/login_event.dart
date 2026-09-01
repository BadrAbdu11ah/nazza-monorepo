part of 'login_bloc.dart';

@freezed
class LoginEvent with _$LoginEvent {
  const factory LoginEvent.sendOtp(String phone) = _SendOtp;
  const factory LoginEvent.verifyOtp(String phone, String code) = _VerifyOtp;
  const factory LoginEvent.loginWithGoogle() = _LoginWithGoogle;
  const factory LoginEvent.reset() = _Reset;
}
