import 'dart:async';

import 'package:barber/core/navigation/app_router.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/services/hive.dart';
import '../../repo/repo.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit(this._authRepo,this._hiveLocalStorage) : super(OtpInitial());

  final AuthRepo _authRepo;
  final HiveLocalStorage _hiveLocalStorage;
  final pinCodeController = TextEditingController();
  int timerCount = 60;
  bool isResendEnabled = false;
  late Timer timer;

  @override
  Future<void> close() async {
    pinCodeController.dispose();
    await super.close();
  }

  void startTimer() {
    emit(OTPTimerRunning(timerCount, isResendEnabled));
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timerCount > 0) {
        timerCount--;
        emit(OTPTimerRunning(timerCount, isResendEnabled));
      } else {
        isResendEnabled = true;
        emit(ResendOTPEnabled());
        timer.cancel();
      }
    });
  }

  void resendOTP() {
    timerCount = 60;
    isResendEnabled = false;
    emit(OTPTimerRunning(timerCount, isResendEnabled));
    startTimer();
  }

  /// API ****************************************************
  Future<void> otp({required String phone,required BuildContext context}) async {
    emit(OtpLoading());
    final result = await _authRepo.postOTP(
        phone : phone,
        code: pinCodeController.text
    );

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
      emit(OtpError());
    }, (res) {
      _hiveLocalStorage.put(apiToken, '${res['data']['token']}');
      _hiveLocalStorage.put('firstLogin', '${res['data']['first_login']}');
      if(res['data']['first_login'] == true){
        context.pushReplacement(signUpView);
      }else{
        context.goNamed(homeView);
      }
      Fluttertoast.showToast(
        msg: res['message'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: successGreen,
        textColor: kWhite,
        fontSize: 14,
      );
      emit(OtpSuccess());
    });
  }

}
