import 'package:equatable/equatable.dart';
import '../../../home/domain/entities/home_product_entity.dart';

abstract class ProductListBlocState extends Equatable {}

class ProductListInitialState extends ProductListBlocState {
  @override
  List<Object?> get props => [];
}

class ProductListLoadingState extends ProductListBlocState {
  @override
  List<Object?> get props => [];
}

class ProductListSuccessState extends ProductListBlocState {
  final List<ProductEntity> productList;
  ProductListSuccessState(
    this.productList,
  );
  @override
  List<Object?> get props => [productList];
}

class ProductListErrorState extends ProductListBlocState {
  final String error;
  ProductListErrorState(this.error);
  @override
  List<Object?> get props => [];
}
