import 'package:flutter/material.dart';
import 'package:shopee/feature/home/domain/entities/home_product_entity.dart';
import 'home_page.dart';

class HorizontalListItem extends StatelessWidget {
  List<ProductEntity> products;
  String category;
  var viewAllCallBack = () {};
  HorizontalListItem(this.products, this.category, this.viewAllCallBack,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.7),
          borderRadius: BorderRadius.circular(10)),
      height: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    category.toUpperCase(),
                    style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Ubuntu',
                        fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: viewAllCallBack,
                    child: const Text(
                      'view all',
                      style: TextStyle(
                          fontFamily: 'Ubuntu',
                          color: Colors.black,
                          fontWeight: FontWeight.normal),
                    ),
                  )
                ]),
          ),
          Expanded(
            flex: 1,
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, item) {
                return ProductItem(
                    products[item].thumbnail, products[item].title);
              },
              scrollDirection: Axis.horizontal,
            ),
          ),
        ],
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  String? imageUrl;
  String? productName;
  ProductItem(this.imageUrl, this.productName, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 3,
      child: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        margin: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                flex: 1,
                child: Image.network(imageUrl ?? '', fit: BoxFit.fill)),
            SizedBox(
              height: 30,
              child: Text(
                productName ?? '',
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 12,
                    fontFamily: 'Ubuntu',
                    fontWeight: FontWeight.normal),
              ),
            )
          ],
        ),
      ),
    );
  }
}
