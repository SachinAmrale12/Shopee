import 'package:dartz/dartz.dart';
import 'package:shopee/common/utils/base_failure.dart';
import 'package:shopee/feature/home/domain/entities/home_product_entity.dart';
import 'package:shopee/feature/pdp/data/datasource/pdp_data_source_impl.dart';
import 'package:shopee/feature/pdp/data/model/product_detail_response_model.dart';
import 'package:shopee/feature/pdp/domain/repositories/pdp_repository.dart';

import '../../../home/data/model/product_response_model.dart';

class PdpRepositoryImpl extends PdpRepository {
  PdpDataSource? pdpDataSource;

  PdpRepositoryImpl([PdpDataSource? pdpDataSource]) {
    this.pdpDataSource = pdpDataSource ?? PdpDataSourceImpl();
  }

  @override
  Future<Either<Failure, ProductEntity>> getProductDetail(int productId) async {
    final remoteData = await pdpDataSource!.getProductResponseData(productId);
    final ProductEntity remoteProductEntity = toProductEntity(remoteData);
    return Right(remoteProductEntity);
  }

  ProductEntity toProductEntity(
      ProductDetailResponseModel productResponseModel) {
    return ProductEntity(
        id: productResponseModel.id,
        description: productResponseModel.description,
        title: productResponseModel.title,
        brand: productResponseModel.brand,
        category: productResponseModel.category,
        discountPercentage: productResponseModel.discountPercentage,
        price: productResponseModel.price,
        rating: productResponseModel.rating,
        thumbnail: productResponseModel.thumbnail,
        images: productResponseModel.images,
        stock: productResponseModel.stock);
  }
}
