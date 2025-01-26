part of 'sign_up_cubit.dart';

sealed class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

final class SignUpInitial extends SignUpState {}

final class ChangeGender extends SignUpState {
  const ChangeGender(this.value);
  final String value;
  @override
  List<Object> get props => [value];
}

class CitySelected extends SignUpState {
  final Map<String, dynamic> city;

  const CitySelected(this.city);

  @override
  List<Object> get props => [city];
}

final class SignUpLoading extends SignUpState {}

final class SignUpSuccess extends SignUpState {}

final class SignUpError extends SignUpState {}

final class SignOutLoading extends SignUpState {}

final class SignOutSuccess extends SignUpState {}

final class SignOutError extends SignUpState {}