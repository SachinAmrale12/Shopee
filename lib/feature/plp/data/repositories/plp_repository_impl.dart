import 'package:dartz/dartz.dart';
import 'package:shopee/feature/plp/data/datasource/plp_data_source_remote.dart';
import 'package:shopee/feature/plp/domain/repositories/plp_repository.dart';
import '../../../../common/utils/base_failure.dart';
import '../../../home/data/model/product_response_model.dart';
import '../../../home/domain/entities/home_product_entity.dart';

class PLPRepositoryImpl implements PLPRepository {
  PLPDataSource? plpDataSource;

  PLPRepositoryImpl([PLPDataSource? plpDataSource]) {
    this.plpDataSource = plpDataSource ?? PLPDataSourceImpl();
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProductList() async {
    final remoteData = await plpDataSource!.getPLPResponseData();
    final List<ProductEntity> remoteProductEntity =
        List.from(remoteData.products.map((e) => toProductEntity(e)));
    return Right(remoteProductEntity);
  }

  ProductEntity toProductEntity(Product homeResponseModel) {
    return ProductEntity(
        id: homeResponseModel.id,
        description: homeResponseModel.description,
        title: homeResponseModel.title,
        brand: homeResponseModel.brand,
        category: homeResponseModel.category,
        discountPercentage: homeResponseModel.discountPercentage,
        price: homeResponseModel.price,
        rating: homeResponseModel.rating,
        thumbnail: homeResponseModel.thumbnail,
        images: homeResponseModel.images,
        stock: homeResponseModel.stock);
  }
}
