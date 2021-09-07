import 'package:flutter/material.dart';
import 'package:shop_appacademind/screens/products_overview_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        accentColor: Colors.deepOrange,
        primarySwatch: Colors.purple,
        fontFamily: 'Lato',
      ),
      home: ProductsOverviewScreen(),
    );
  }
}
