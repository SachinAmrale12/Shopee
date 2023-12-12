import 'dart:convert';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shopee/common/colors/colors.dart';
import 'package:shopee/common/utils/analytics.dart';
import 'package:shopee/feature/home/domain/entities/home_product_entity.dart';
import 'package:shopee/feature/home/presentation/bloc/home_product_cubit.dart';
import 'package:shopee/feature/home/presentation/bloc/home_product_state.dart';
import 'package:shopee/feature/home/presentation/ui/carousel_slider.dart';
import 'package:shopee/feature/home/presentation/ui/horizontal_list_item.dart';
import '../../../../common/utils/authentication.dart';
import '../../../../common/utils/custom_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<ProductEntity> allProductList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAnalytics.instance.setCurrentScreen(
      screenName: 'HomePage',
      screenClassOverride: 'HomePage',
    );
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<HomeProductCubit>(context).getProducts();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeBackgroundColor,
        leading: Builder(builder: (context) {
          return GestureDetector(
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: const Icon(
              Icons.menu,
              color: Colors.black,
            ),
          );
        }),
        title: const Text(
          'Home',
          style: TextStyle(
              fontFamily: 'Ubuntu',
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
      ),
      drawer: Drawer(
        child: Container(
          color: themeBackgroundColor,
          child: SafeArea(
              child: ListView(children: <Widget>[
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.black),
              title: const Text(
                'Settings',
                style: TextStyle(
                    fontFamily: 'Ubuntu',
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.black),
              title: const Text(
                'Logout',
                style: TextStyle(
                    fontFamily: 'Ubuntu',
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                var dialog = CustomAlertDialog(
                    title: "Logout",
                    message: "Are you sure, do you want to logout?",
                    onPostivePressed: () async {
                      Analytics.logEvent('logout_clicked', null);
                      await Authentication.signOut(context: context);
                      Navigator.popUntil(context, ModalRoute.withName('login'));
                    },
                    onNegativePressed: () {
                      Navigator.pop(context);
                    },
                    positiveBtnText: 'Yes',
                    negativeBtnText: 'No');
                showDialog(
                    context: context,
                    builder: (BuildContext context) => dialog);
              },
            ),
          ])),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<HomeProductCubit, HomeProductBlocState>(
          builder: (context, state) {
            if (state is HomeProductLoadingState) {
              return const Center(
                child: CircularProgressIndicator(
                  color: buttonColor,
                ),
              );
            }
            if (state is HomeProductSuccessState) {
              allProductList = state.productList;
              var tempDictionary = <String, List<ProductEntity>>{};
              for (ProductEntity item in allProductList) {
                tempDictionary.update(
                    item.category ?? '', (value) => value..add(item),
                    ifAbsent: () => [item]);
              }
              var keysList = tempDictionary.keys.toList();
              final curoselImages = <String>[];
              for (var i = 0; i < 3; i++) {
                curoselImages.add(allProductList[i].thumbnail ?? '');
              }
              return SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Carousel(curoselImages),
                    Container(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return HorizontalListItem(
                              tempDictionary[keysList?[index]]
                                  as List<ProductEntity>,
                              keysList?[index] ?? '', () {
                            Analytics.logEvent('view_all_button_clicked', null);
                            Navigator.of(context).pushNamed('plp');
                          });
                        },
                        itemCount: keysList?.length ?? 1,
                      ),
                    ),
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
