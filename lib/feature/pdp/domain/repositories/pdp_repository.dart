import 'package:dartz/dartz.dart';
import '../../../../common/utils/base_failure.dart';
import '../../../home/domain/entities/home_product_entity.dart';

abstract class PdpRepository {
  Future<Either<Failure, ProductEntity>> getProductDetail(int productId);
}
