import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem(
      {required this.id,
      required this.title,
      required this.price,
      required this.quantity});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _itemsCart = {};

  Map<String, CartItem> get itemsCart {
    return {..._itemsCart};
  }

  int get itemCartCount{
    return _itemsCart.length;
  }

  double get totalAmount{
    double total = 0.0;
    _itemsCart.forEach((key, cartItem) {
      total = cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItemCart(
    String productId,
    double price,
    String title,
  ) {
    if (_itemsCart.containsKey(productId)) {
      _itemsCart.update(
        productId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity + 1,
        ),
      );
    } else {
      _itemsCart.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }
  void removeItem(String productId){
    _itemsCart.remove(productId);
    notifyListeners();
  }

  void clear() {
    _itemsCart = {};
    notifyListeners();
  }
}

