import 'package:barber/features/auth/repo/repo.dart';
import 'package:dartz/dartz.dart';

import '../../../core/resources/endpoint_constants.dart';
import '../../../core/services/api/api_services.dart';
import '../../../core/utils/failure.dart';
import '../models/user_info.dart';

class AuthRepoImpl implements AuthRepo {
  final ApiServices apiServices;

  AuthRepoImpl(this.apiServices);

  @override
  Future<Either<(Failure, String), String>> postLogin(String phone) async {
    Map response = { };
    try{
      response = await apiServices.post(
          endPoint: loginEndP,
          data: {
            'phone': phone,
            'device_id': '11111111',
            'token_firebase': 'mam',
          }
      );
      return Right(response['message']);

    }catch(e){
      String errorMessage = 'Unknown error';
      if ( response.containsKey('msg')) {
        errorMessage = response['msg'];
      }
      return Left((Failure.handleError(e), errorMessage));
    }
  }


  @override
  Future<Either<(Failure, String), Map>> postOTP({required String phone,required String code}) async {
    try{
      final response = await apiServices.post(
          endPoint: otpEndP,
          data: {
            'phone': phone,
            'code': code,
          }
      );
      return Right(response);

    }catch(e){
      final failure = Failure.handleError(e);
      String errorMessage = 'An error occurred.';
      if (failure.details is Map && failure.details['message'] is String) {
        errorMessage = failure.details['message']!;
      }
      return Left((failure, errorMessage));
    }
  }

  @override
  Future<Either<(Failure, String), UserModel>> postSignUP({required Map<String, dynamic> userData}) async {
    try{
      final response = await apiServices.post(
          endPoint: signUpEndP,
          data: userData
      );
      UserModel userModel = UserModel.fromJson(response['data']);

      return Right(userModel);

    }catch(e){

      final failure = Failure.handleError(e);
      String errorMessage = 'An error occurred.';
      if (failure.details is Map && failure.details['message'] is String) {
        errorMessage = failure.details['message']!;
      }
      return Left((failure, errorMessage));
    }
  }

  @override
  Future<Either<(Failure, String), String>> getSignOut() async{
    try{
      final response = await apiServices.get(
          endPoint: signOutEndP,
      );
      return Right(response['message']);

    }catch(e){

      final failure = Failure.handleError(e);
      String errorMessage = 'An error occurred.';
      if (failure.details is Map && failure.details['message'] is String) {
        errorMessage = failure.details['message']!;
      }
      return Left((failure, errorMessage));
    }
  }
}
