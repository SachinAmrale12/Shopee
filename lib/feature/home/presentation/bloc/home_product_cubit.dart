import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopee/feature/home/presentation/bloc/home_product_state.dart';
import '../../domain/repositories/home_repository.dart';

class HomeProductCubit extends Cubit<HomeProductBlocState> {
  HomeRepository? homeRepositiry;

  HomeProductCubit(this.homeRepositiry, super.initialState);

  getProducts() async {
    emit(HomeProductLoadingState());
    var response = await homeRepositiry?.getProduct();
    response?.fold((l) => emit(HomeProductErrorState(l.message)),
        (r) => emit(HomeProductSuccessState(r)));
  }
}
