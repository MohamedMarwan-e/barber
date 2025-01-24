import 'dart:async';
import 'package:barber/core/navigation/app_router.dart';
import 'package:barber/core/resources/color_manager.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import '../../repo/repo.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authRepo): super(AuthInitial());

  final AuthRepo _authRepo;
  final phoneController = TextEditingController();


  /// API ****************************************************
  Future<void> login({required BuildContext context}) async {
    emit(LoginLoading());
    final result = await _authRepo.postLogin(phoneController.text);

    result.fold((failureAndState) {
          final failure = failureAndState.$1;
          final state = failureAndState.$2;

          Fluttertoast.showToast(
            msg: "${failure.message} \nState: $state",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: kRed,
            textColor: kWhite,
            fontSize: 14,
          );
          emit(LoginError());
        }, (res) {
          Fluttertoast.showToast(
            msg: res,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: successGreen,
            textColor: kWhite,
            fontSize: 14,
          );
          context.pushNamed(otpView,extra: phoneController.text);
          emit(LoginSuccess());
    });
  }
}
