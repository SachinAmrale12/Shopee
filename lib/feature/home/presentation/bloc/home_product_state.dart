import 'package:equatable/equatable.dart';
import 'package:shopee/feature/home/domain/entities/home_product_entity.dart';

abstract class HomeProductBlocState extends Equatable {}

class HomeProductInitialState extends HomeProductBlocState {
  @override
  List<Object?> get props => [];
}

class HomeProductLoadingState extends HomeProductBlocState {
  @override
  List<Object?> get props => [];
}

class HomeProductSuccessState extends HomeProductBlocState {
  final List<ProductEntity> productList;
  HomeProductSuccessState(
    this.productList,
  );
  @override
  List<Object?> get props => [productList];
}

class HomeProductErrorState extends HomeProductBlocState {
  final String error;
  HomeProductErrorState(this.error);
  @override
  List<Object?> get props => [];
}
