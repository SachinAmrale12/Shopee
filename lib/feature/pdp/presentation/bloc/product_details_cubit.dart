import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopee/feature/pdp/domain/repositories/pdp_repository.dart';
import 'package:shopee/feature/pdp/presentation/bloc/product_details_state.dart';

class ProductDetailCubit extends Cubit<ProductDetailBlocState> {
  PdpRepository? pdpRepositiry;
  ProductDetailCubit(this.pdpRepositiry, super.initialState);

  getProductDetail(int productId) async {
    emit(ProductDetailLoadingState());
    var response = await pdpRepositiry?.getProductDetail(productId);
    response?.fold((l) => emit(ProductDetailErrorState(l.message)),
        (r) => emit(ProductDetailSuccessState([r])));
  }
}
