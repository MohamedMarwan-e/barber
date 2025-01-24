part of 'otp_cubit.dart';

sealed class OtpState extends Equatable {
  const OtpState();
  @override
  List<Object> get props => [];
}

final class OtpInitial extends OtpState {}

final class OTPTimerRunning extends OtpState {
  final int timerCount;
  final bool isResendEnabled;

  const OTPTimerRunning(this.timerCount, this.isResendEnabled);

  @override
  List<Object> get props => [timerCount, isResendEnabled];
}

final class ResendOTPEnabled extends OtpState {}

final class OtpLoading extends OtpState {}
final class OtpSuccess extends OtpState {}
final class OtpError extends OtpState {}