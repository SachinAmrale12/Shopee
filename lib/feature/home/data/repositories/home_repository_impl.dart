import 'package:dartz/dartz.dart';
import 'package:shopee/common/utils/base_failure.dart';
import 'package:shopee/feature/home/domain/entities/home_product_entity.dart';
import 'package:shopee/feature/home/domain/repositories/home_repository.dart';
import '../datasource/home_data_source_remote.dart';
import '../model/product_response_model.dart';
import 'dart:async';

class HomeRepositoryImpl implements HomeRepository {
  HomeDataSource? homeDataSource;

  HomeRepositoryImpl([HomeDataSource? homeDataSource]) {
    this.homeDataSource = homeDataSource ?? HomeDataSourceImpl();
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProduct() async {
    final remoteData = await homeDataSource!.getHomeResponseData();
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
