import 'package:barber/core/navigation/app_router.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/resources/color_manager.dart';
import '../../../../core/services/hive.dart';
import '../../models/user_info.dart';
import '../../repo/repo.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this._authRepo,this._hiveLocalStorage) : super(SignUpInitial());

  final HiveLocalStorage _hiveLocalStorage;
  final AuthRepo _authRepo;
  UserModel? userModel;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  String? gender;
  Map<String, dynamic>? selectedCity;
  final List<Map<String, dynamic>> cities = [
    {'id': 1, 'name': 'الرياض'},
    {'id': 2, 'name': 'جده'},
    {'id': 3, 'name': 'مكة المكرمة'},
    {'id': 4, 'name': 'تبوك'},
    {'id': 5, 'name': 'الدمام'},
  ];


  void changeGender(String? value){
    gender = value;
    emit(ChangeGender(value ??''));
  }

  void selectCity(Map<String, dynamic>? city) {
    if (city != null) {
      selectedCity = city;
      emit(CitySelected(city));
    }
  }

  void validateForm({required BuildContext context}) {
    if (selectedCity == null && gender == null) {
      Fluttertoast.showToast(
        msg: 'الرجاء اختيار المدينة والنوع.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: kRed,
        textColor: kWhite,
        fontSize: 14,
      );

    } else if (selectedCity == null) {
      Fluttertoast.showToast(
        msg: 'الرجاء اختيار المدينة.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: kRed,
        textColor: kWhite,
        fontSize: 14,
      );
    } else if (gender == null) {
      Fluttertoast.showToast(
        msg: 'الرجاء اختيار النوع.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: kRed,
        textColor: kWhite,
        fontSize: 14,
      );
    } else {
      signUP(context: context);
    }
  }

  /// API ****************************************************
  Future<void> signUP({required BuildContext context}) async {
    emit(SignUpLoading());
    final result = await _authRepo.postSignUP(
      userData: UserModel.toJson(
        name: nameController.text,
        cityId: selectedCity!['id'],
        gender: gender ??'',
        email: emailController.text,
      ),
    );

    result.fold((failureAndState) {
      final failure = failureAndState.$1;
      final state = failureAndState.$2;

      Fluttertoast.showToast(
        msg: "${failure.details} \nState: $state",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: kRed,
        textColor: kWhite,
        fontSize: 14,
      );
      emit(SignUpError());
    }, (res) {
      userModel = res;
      _hiveLocalStorage.delete('firstLogin');
      context.goNamed(homeView);
      emit(SignUpSuccess());
    });
  }
}
