import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_appacademind/providers/products_provider.dart';
import 'package:shop_appacademind/widgets/product_item.dart';

class ProductsGrid extends StatelessWidget {

  final bool showFavs;
  ProductsGrid({required this.showFavs});



  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);
    final products = showFavs ? productsData.favoriteItems : productsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1 / 1.5,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: products[i],
        child: ProductItem(
          // products[i].id,
          // products[i].title,
          // products[i].imageUrl,
        ),
      ),
    );
  }
}