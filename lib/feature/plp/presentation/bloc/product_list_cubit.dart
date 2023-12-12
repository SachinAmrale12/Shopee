import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopee/feature/plp/presentation/bloc/product_list_state.dart';
import '../../domain/repositories/plp_repository.dart';

class ProductListCubit extends Cubit<ProductListBlocState> {
  PLPRepository? plpRepositiry;
  ProductListCubit(this.plpRepositiry, super.initialState);

  getProductList() async {
    emit(ProductListLoadingState());
    var response = await plpRepositiry?.getProductList();
    response?.fold((l) => emit(ProductListErrorState(l.message)),
        (r) => emit(ProductListSuccessState(r)));
  }
}
