import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/salons.dart';
import '../repo/repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._homeRepo) : super(HomeInitial());
  final HomeRepo _homeRepo;

  final GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  int _currentPage = 1;
  bool isFetching = false;
  List<SalonsModel> salonsList = [];

  Future<void> fetchSalons({bool isRefresh = false}) async {
    if (isFetching) return;

    if (isRefresh) {
      _currentPage = 1;
      salonsList.clear();
      emit(HomeInitial());
    } else {
      emit(PaginationLoading());
    }

    isFetching = true;

    final result = await _homeRepo.getSalons(_currentPage);

    result.fold((failureAndState) {
      final failure = failureAndState.$1;
      final state = failureAndState.$2;

      emit(PaginationError(error: '${failure.message} \nState: $state'));
    }, (res) {
      if (res.isEmpty && !isRefresh) {
        emit(PaginationEnd(salonsList));
      } else {
        salonsList.addAll(res);
        _currentPage++;
        emit(PaginationSuccess(salonsList));
      }
    });

    isFetching = false;
  }
}