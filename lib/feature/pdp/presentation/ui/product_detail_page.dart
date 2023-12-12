import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shopee/common/colors/colors.dart';
import 'package:shopee/feature/home/domain/entities/home_product_entity.dart';
import 'package:shopee/feature/home/presentation/ui/carousel_slider.dart';
import 'package:shopee/feature/pdp/presentation/bloc/product_details_cubit.dart';
import 'package:shopee/feature/pdp/presentation/bloc/product_details_state.dart';
import 'package:shopee/feature/pdp/presentation/ui/tabbar.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late ProductEntity productDetails;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAnalytics.instance.setCurrentScreen(
      screenName: 'ProductDetailPage',
      screenClassOverride: 'ProductDetailPage',
    );
  }

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)?.settings.arguments as int;
    BlocProvider.of<ProductDetailCubit>(context).getProductDetail(productId);

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
          'Product Detail',
          style: TextStyle(
              fontFamily: 'Ubuntu',
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<ProductDetailCubit, ProductDetailBlocState>(
          builder: (context, state) {
            if (state is ProductDetailLoadingState) {
              return const Center(
                child: CircularProgressIndicator(
                  color: buttonColor,
                ),
              );
            }
            if (state is ProductDetailSuccessState) {
              productDetails = state.productDetail.first;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 20),
                    Carousel(productDetails?.images ?? ['']),
                    const SizedBox(height: 10),
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white.withOpacity(0.7),
                        ),
                        margin: const EdgeInsets.only(
                            left: 10, right: 10, top: 5, bottom: 5),
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              productDetails?.title ?? '',
                              style: const TextStyle(
                                  fontFamily: 'Ubuntu',
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              '\$ ${(productDetails?.price ?? 0).toString()}',
                              style: const TextStyle(
                                  fontFamily: 'Ubuntu',
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        )),
                    const SizedBox(height: 10),
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white.withOpacity(0.7),
                        ),
                        margin: const EdgeInsets.only(
                            left: 10, right: 10, top: 5, bottom: 5),
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              productDetails?.description ?? '',
                              style: const TextStyle(
                                  fontFamily: 'Ubuntu',
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        )),
                    const SizedBox(height: 10),
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white.withOpacity(0.7),
                        ),
                        margin: const EdgeInsets.only(
                            left: 10, right: 10, top: 5, bottom: 5),
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              (productDetails?.rating ?? 0.0).toString(),
                              style: const TextStyle(
                                  fontFamily: 'Ubuntu',
                                  fontSize: 25,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 20),
                            RatingBarIndicator(
                              rating: productDetails?.rating ?? 0.0,
                              itemBuilder: (context, index) => const Icon(
                                Icons.star,
                                color: buttonColor,
                              ),
                              itemCount: 5,
                              itemSize: 35.0,
                              direction: Axis.horizontal,
                            ),
                          ],
                        )),
                    const SizedBox(height: 5),
                    TabbarView(productDetails!)
                  ],
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
