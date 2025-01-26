import 'package:dartz/dartz.dart';

import '../../../core/utils/failure.dart';
import '../models/salon_details.dart';

abstract class SalonServiceRepo {
  Future<Either<(Failure, String), SalonDetailsModel>> getSalonsDetails(String id);


}