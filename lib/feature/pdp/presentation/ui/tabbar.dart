import 'package:flutter/material.dart';
import 'package:shopee/common/colors/colors.dart';
import 'package:shopee/feature/home/domain/entities/home_product_entity.dart';
import 'package:shopee/feature/home/presentation/ui/home_page.dart';

class TabbarView extends StatefulWidget {
  ProductEntity product;
  TabbarView(this.product, {super.key});
  @override
  TabbarViewState createState() => TabbarViewState();
}

class TabbarViewState extends State<TabbarView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            height: 45,
            margin: const EdgeInsets.only(left: 5, right: 5),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
              borderRadius: BorderRadius.circular(
                20.0,
              ),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  20.0,
                ),
                color: buttonColor,
              ),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              labelStyle: const TextStyle(
                fontFamily: 'Ubuntu',
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
              tabs: const [
                Tab(
                  text: 'Features',
                ),
                Tab(
                  text: 'Description',
                ),
              ],
            ),
          ),
          // tab bar view here
          Container(
            height: MediaQuery.of(context).size.height / 3,
            child: TabBarView(
              controller: _tabController,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white.withOpacity(0.7),
                        ),
                        margin: const EdgeInsets.only(
                            left: 5, right: 5, top: 15, bottom: 5),
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Brand',
                              style: TextStyle(
                                  fontFamily: 'Ubuntu',
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              widget.product.brand ?? '',
                              style: const TextStyle(
                                  fontFamily: 'Ubuntu',
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Title',
                              style: TextStyle(
                                  fontFamily: 'Ubuntu',
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              widget.product.title ?? '',
                              style: const TextStyle(
                                  fontFamily: 'Ubuntu',
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Price',
                              style: TextStyle(
                                  fontFamily: 'Ubuntu',
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: [
                                Text(
                                  ((widget.product.price ?? 0) /
                                              (1 -
                                                  ((widget.product
                                                              .discountPercentage ??
                                                          0.0) /
                                                      100)) ??
                                          0)
                                      .toInt()
                                      .toString(),
                                  style: const TextStyle(
                                    fontFamily: 'Ubuntu',
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  '\$${(widget.product.price ?? 0).toString()}',
                                  style: const TextStyle(
                                      fontFamily: 'Ubuntu',
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Total Discount',
                              style: TextStyle(
                                  fontFamily: 'Ubuntu',
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${(widget.product.discountPercentage ?? 0.0).toString()}%',
                              style: const TextStyle(
                                  fontFamily: 'Ubuntu',
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ))
                  ],
                ),
                // second tab bar view widget
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white.withOpacity(0.7),
                      ),
                      margin: const EdgeInsets.only(
                          left: 5, right: 5, top: 15, bottom: 5),
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Container(
                            width: 150,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: NetworkImage(
                                    widget.product.thumbnail ?? ''),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              widget.product.description ?? '',
                              style: const TextStyle(
                                  fontFamily: 'Ubuntu',
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
