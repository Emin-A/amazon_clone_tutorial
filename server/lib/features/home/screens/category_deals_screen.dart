import 'package:amazon_clone_tutorial/features/home/services/home_services.dart';
import 'package:amazon_clone_tutorial/features/product_details/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import '../../../common/widgets/loader.dart';
import '../../../models/product.dart';
// ignore: unused_import
import 'dart:convert';
import 'package:amazon_clone_tutorial/constants/global_variables.dart';
// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
// ignore: unused_import
import '../../../constants/error_handling.dart';
// ignore: unused_import
import '../../../constants/utils.dart';
// ignore: unused_import
import 'package:amazon_clone_tutorial/providers/user_provider.dart';
// ignore: unused_import
import 'package:provider/provider.dart';
// ignore: unused_import
import 'package:http/http.dart' as http;

class CategoryDealsScreen extends StatefulWidget {
  static const String routeName = '/category-deals';
  final String category;
  const CategoryDealsScreen({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  State<CategoryDealsScreen> createState() => _CategoryDealsScreenState();
}

class _CategoryDealsScreenState extends State<CategoryDealsScreen> {
  List<Product>? productList;
  final HomeServices homeServices = HomeServices();

  @override
  void initState() {
    super.initState();
    // ignore: unused_element
    fetchCategoryProducts() async {
      productList = await homeServices.fetchCategoryProducts(
        context: context,
        category: widget.category,
      );
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_typing_uninitialized_variables
    var product;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Text(
            widget.category,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: productList == null
          ? const Loader()
          : Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Keep shopping for ${widget.category}',
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(
                  height: 170,
                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(left: 15),
                    itemCount: productList!.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 1.4,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      final product = productList![index];
                      // ignore: prefer_const_constructors
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, ProductDetailScreen.routeName,
                              arguments: product);
                        },
                        child: Column(
                          children: [
                            SizedBox(
                              height: 130,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black12,
                                    width: 0.5,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Image.network(
                                    product.images[0],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(left: 0, top: 5, right: 15),
                  child: Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
    );
  }
}
