import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_appacademind/providers/badge.dart';
import 'package:shop_appacademind/providers/cart.dart';
import 'package:shop_appacademind/screens/cart_screen.dart';

// import 'package:shop_appacademind/providers/products_provider.dart';
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

  @override
  Widget build(BuildContext context) {
    // final productsProvider = Provider.of<ProductsProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Shop_Academind: $_showOnlyFavorites',
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
              icon: Icon(
                Icons.more_vert,
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
      body: ProductsGrid(
        showFavs: _showOnlyFavorites,
      ),
    );
  }
}
