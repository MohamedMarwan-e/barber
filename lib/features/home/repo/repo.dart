import 'package:dartz/dartz.dart';

import '../../../core/utils/failure.dart';
import '../models/salons.dart';

abstract class HomeRepo {
  Future<Either<(Failure, String), List<SalonsModel>>> getSalons(int page);


}