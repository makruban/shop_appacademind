import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_appacademind/providers/badge.dart';
import 'package:shop_appacademind/providers/cart.dart';
import 'package:shop_appacademind/providers/product.dart';
import 'package:shop_appacademind/screens/cart_screen.dart';
import '../widgets/app_drawer.dart';
import 'package:shop_appacademind/widgets/products_grid.dart';

enum FilterOption {
  Favorite,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorites = false;
  var _selectOneFavorites = false;

  @override
  Widget build(BuildContext context) {
    // final productsProvider = Provider.of<ProductsProvider>(context, listen: false);
    final product = Provider.of<Product>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Alster.ua',
        ),
        actions: [
          PopupMenuButton(
              onSelected: (FilterOption selectedValue) {
                setState(() {
                  if (selectedValue == FilterOption.Favorite) {
                    _showOnlyFavorites = true;
                  } else {
                    _showOnlyFavorites = false;
                  }
                });
              },
              icon: Icon(product.isFavorite ? Icons.favorite :
                Icons.favorite_border,
              ),
              itemBuilder: (_) => [
                    PopupMenuItem(
                      child: Text('Only Favorites'),
                      value: FilterOption.Favorite,
                    ),
                    PopupMenuItem(
                      child: Text('Show All'),
                      value: FilterOption.All,
                    ),
                  ]),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              child: ch,
              value: cart.itemCartCount.toString(),
            ),
            child: IconButton(onPressed: (){
              Navigator.of(context).pushNamed(CartScreen.routeName);
            },

              icon: Icon(Icons.shopping_cart),
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: ProductsGrid(
        showFavs: _showOnlyFavorites,
      ),
    );
  }
}
