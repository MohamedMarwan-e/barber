import 'package:dartz/dartz.dart';

import '../../../core/resources/endpoint_constants.dart';
import '../../../core/services/api/api_services.dart';
import '../../../core/utils/failure.dart';
import '../models/salon_details.dart';
import 'repo.dart';

class SalonServiceRepoImpl implements SalonServiceRepo {
  SalonServiceRepoImpl(this.apiServices);
  final ApiServices apiServices;

  @override
  Future<Either<(Failure, String), SalonDetailsModel>> getSalonsDetails(String id) async {
    try{
     final response = await apiServices.get(
          endPoint: '$salonDetailsEndP/$id',
      );
     SalonDetailsModel salonDetailsModel = SalonDetailsModel.fromJson(response['data']);
     return Right(salonDetailsModel);

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
