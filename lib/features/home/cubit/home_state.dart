part of 'home_cubit.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class PaginationLoading extends HomeState {}

final class PaginationSuccess extends HomeState {
  final List<SalonsModel> items;
  const PaginationSuccess(this.items);

  @override
  List<Object> get props => [items];
}

final class PaginationEnd extends HomeState {
  final List<SalonsModel> items;

  const PaginationEnd(this.items);

  @override
  List<Object> get props => [items];
}

final class PaginationError extends HomeState {
  final String error;

  const PaginationError({required this.error});

  @override
  List<Object> get props => [error];
}