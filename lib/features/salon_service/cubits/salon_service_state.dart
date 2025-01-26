part of 'salon_service_cubit.dart';

sealed class SalonServiceState extends Equatable {
  const SalonServiceState();

  @override
  List<Object> get props => [];
}

final class SalonServiceInitial extends SalonServiceState {}
final class SalonDetailsLoading extends SalonServiceState {}
final class SalonDetailsError extends SalonServiceState {
  const SalonDetailsError({required this.error});
  final String error;
  @override
  List<Object> get props => [error];

}
final class SalonDetailsSuccess extends SalonServiceState {}
