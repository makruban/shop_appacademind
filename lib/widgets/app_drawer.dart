import 'package:flutter/material.dart';
import '../screens/orders_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text(
              'Hello Friend!',),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text(
          'В каталог',
          ),
            onTap: (){
              Navigator.of(context).pushReplacementNamed('/');
            },

          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text(
              'Заказы',
            ),
            onTap: (){
              Navigator.of(context).pushReplacementNamed(OrdersScreen.routeName);
            },

          ),
        ],
      ),
    );
  }
}