import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/salon_details.dart';
import '../repo/repo.dart';

part 'salon_service_state.dart';

class SalonServiceCubit extends Cubit<SalonServiceState> {
  SalonServiceCubit(this._salonServiceRepo) : super(SalonServiceInitial());
  final SalonServiceRepo _salonServiceRepo;

  late PageController pageController;
  SalonDetailsModel? salonDetailsModel;

  /// API ********************************************

  Future<void> fetchSalonsDetails(String id) async {
    emit(SalonDetailsLoading());
    final result = await _salonServiceRepo.getSalonsDetails(id);

    result.fold((failureAndState) {
      final failure = failureAndState.$1;
      final state = failureAndState.$2;

      emit(SalonDetailsError(error: '${failure.message} \nState: $state'));
    }, (res) {
      salonDetailsModel = res;
      emit(SalonDetailsSuccess());
    });
  }

}
