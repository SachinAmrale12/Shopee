import 'package:flutter/material.dart';
import 'package:shopee/feature/home/domain/entities/home_product_entity.dart';

import '../../../../common/utils/analytics.dart';
import '../../../home/presentation/ui/home_page.dart';

class ProductListItem extends StatelessWidget {
  ProductEntity? product;
  ProductListItem(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Analytics.logEvent(
            'product_tile_clicked', {'productId': product?.id ?? 1});
        Navigator.pushNamed(context, 'pdp', arguments: product?.id ?? 1);
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(5),
        width: MediaQuery.of(context).size.width / 2,
        height: (MediaQuery.of(context).size.width / 2) * 1.5,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white.withOpacity(0.7)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(5),
                child:
                    Image.network(product?.thumbnail ?? '', fit: BoxFit.fill),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              product?.title ?? '',
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontFamily: 'Ubuntu',
                  fontSize: 12,
                  color: Colors.black,
                  fontWeight: FontWeight.normal),
            ),
            const SizedBox(height: 10),
            Text(
              '\$${(product?.price ?? 0).toString()}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontFamily: 'Ubuntu',
                  fontSize: 12,
                  color: Colors.black,
                  fontWeight: FontWeight.normal),
            )
          ],
        ),
      ),
    );
  }
}
