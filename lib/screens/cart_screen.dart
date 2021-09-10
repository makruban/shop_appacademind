import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_appacademind/providers/cart.dart' show Cart;
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const String routeName = '/card-screen';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Cart',
        ),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(15.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                  // SizedBox(
                  //   width: 10,
                  // ),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\$${cart.totalAmount}',
                      style: TextStyle(
                        color:
                            Theme.of(context).primaryTextTheme.headline6!.color,
                      ),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'ORDER NOW',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cart.itemsCart.length,
              itemBuilder: (ctx, i) => CartItem(
                id: cart.itemsCart.values.toList()[i].id,
                title: cart.itemsCart.values.toList()[i].title,
                price: cart.itemsCart.values.toList()[i].price,
                quantity: cart.itemsCart.values.toList()[i].quantity,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
