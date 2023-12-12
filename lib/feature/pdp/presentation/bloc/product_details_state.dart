import 'package:equatable/equatable.dart';
import '../../../home/domain/entities/home_product_entity.dart';

abstract class ProductDetailBlocState extends Equatable {}

class ProductDetailInitialState extends ProductDetailBlocState {
  @override
  List<Object?> get props => [];
}

class ProductDetailLoadingState extends ProductDetailBlocState {
  @override
  List<Object?> get props => [];
}

class ProductDetailSuccessState extends ProductDetailBlocState {
  final List<ProductEntity> productDetail;
  ProductDetailSuccessState(
    this.productDetail,
  );
  @override
  List<Object?> get props => [productDetail];
}

class ProductDetailErrorState extends ProductDetailBlocState {
  final String error;
  ProductDetailErrorState(this.error);
  @override
  List<Object?> get props => [];
}
