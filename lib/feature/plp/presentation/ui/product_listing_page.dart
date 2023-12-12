import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopee/common/colors/colors.dart';
import 'package:shopee/feature/home/domain/entities/home_product_entity.dart';
import 'package:shopee/feature/home/presentation/ui/home_page.dart';
import 'package:shopee/feature/plp/presentation/bloc/product_list_cubit.dart';
import 'package:shopee/feature/plp/presentation/bloc/product_list_state.dart';
import 'package:shopee/feature/plp/presentation/ui/plp_list_item.dart';

class ProductListingPage extends StatelessWidget {
  const ProductListingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProductListCubit>(context).getProductList();
    FirebaseAnalytics.instance.setCurrentScreen(
      screenName: 'ProductListingPage',
      screenClassOverride: 'ProductListingPage',
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeBackgroundColor,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: const Text(
          'Product List',
          style: TextStyle(
            fontFamily: 'Ubuntu',
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(child: BlocBuilder<ProductListCubit, ProductListBlocState>(
          builder: (context, state) {
        if (state is ProductListLoadingState) {
          return const Center(
            child: CircularProgressIndicator(
              color: buttonColor,
            ),
          );
        }
        if (state is ProductListSuccessState) {
          return GridView.count(
            crossAxisCount: 2,
            children: List.generate(
              state.productList.length,
              (index) {
                return ProductListItem(state.productList[index]);
              },
            ),
          );
        }
        return Container();
      })),
    );
  }
}
