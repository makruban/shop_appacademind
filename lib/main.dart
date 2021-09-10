import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_appacademind/screens/cart_screen.dart';
import 'package:shop_appacademind/screens/product_detail_screen.dart';
import 'package:shop_appacademind/screens/products_overview_screen.dart';
import '../providers/products_provider.dart';
import '../providers/cart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
        create: (ctx) => ProductsProvider(),),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          accentColor: Colors.deepOrange,
          primarySwatch: Colors.purple,
          fontFamily: 'Lato',
        ),
        home: ProductsOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          CartScreen.routeName : (ctx) => CartScreen(),
        },
      ),
    );

  }
}
