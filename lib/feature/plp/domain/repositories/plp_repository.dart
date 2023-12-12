import '../../../../common/utils/base_failure.dart';
import 'package:dartz/dartz.dart';
import '../../../home/domain/entities/home_product_entity.dart';

abstract class PLPRepository {
  Future<Either<Failure, List<ProductEntity>>> getProductList();
}
