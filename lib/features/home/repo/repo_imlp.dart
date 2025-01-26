import 'package:dartz/dartz.dart';

import '../../../core/resources/endpoint_constants.dart';
import '../../../core/services/api/api_services.dart';
import '../../../core/utils/failure.dart';
import '../models/salons.dart';
import 'repo.dart';

class HomeRepoImpl implements HomeRepo {
  HomeRepoImpl(this.apiServices);
  final ApiServices apiServices;

  @override
  Future<Either<(Failure, String), List<SalonsModel>>> getSalons(int page) async {
    try{
     final response = await apiServices.get(
          endPoint: salonsEndP,
          parameters: {
            'page': page,
          }
      );

     final dynamic list = response['data']['data'];
     final List<SalonsModel> salonsList = (list as List).map((item) => SalonsModel.fromJson(
         item as Map<String, dynamic>)).toList();

      return Right(salonsList);

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
