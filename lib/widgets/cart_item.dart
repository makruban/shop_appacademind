import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  final String id;
  final double price;
  final int quantity;
  final String title;

  CartItem

      ({

    required

    this

        .
    id

    ,

    required

    this

        .
    price

    ,

    required

    this

        .
    title

    ,

    required

    this

        .
    quantity

    ,

  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: 4,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ListTile(
          leading: CircleAvatar(child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: FittedBox(
              child: Text(
                  '\$${price}'),
            ),
          ),
          ),
          title: Text(title),
          subtitle: Text('Total: \$${price * quantity}',),
          trailing: Text('$quantity x'),
        ),
      ),
    );
  }
}
