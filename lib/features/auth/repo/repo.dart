import 'package:dartz/dartz.dart';

import '../../../core/utils/failure.dart';
import '../models/user_info.dart';

abstract class AuthRepo {
  Future<Either<(Failure, String), String>> postLogin(String phone);
  Future<Either<(Failure, String), Map>> postOTP({required String phone,required String code});

  Future<Either<(Failure, String), UserModel>> postSignUP({required Map<String, dynamic> userData});
  Future<Either<(Failure, String), String>> getSignOut();

}