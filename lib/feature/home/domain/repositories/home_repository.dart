import '../../../../common/utils/base_failure.dart';
import '../entities/home_product_entity.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<ProductEntity>>> getProduct();
}
