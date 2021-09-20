import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shop_appacademind/providers/product.dart';
import 'package:http/http.dart' as http;

class ProductsProvider with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://alster.ua/image/cache/catalog/1-ZHENSKOE/1-Verhnjaja-odezhda/Puhoviki/ZLLY/2020/ZL20556/seriy/genskaja-kurtka-zima-zilanliya-20556-seriy-3650-1380x1860.webp',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://alster.ua/image/cache/catalog/1-ZHENSKOE/1-Verhnjaja-odezhda/Puhoviki/Clasna/2020/755/bordo/zimnij-dlinnyj-s-poyasom-bordo-2-1380x1860.webp',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://alster.ua/image/cache/catalog/1-ZHENSKOE/1-Verhnjaja-odezhda/Puhoviki/SnowOwl/2021/21A200/zhenskaya-zimnyaya-dvustoronnyaya-kurtka-s-kapjushonom-s-602-Snow%20Owl-7-1380x1860.webp',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://alster.ua/image/cache/catalog/1-ZHENSKOE/1-Verhnjaja-odezhda/Puhoviki/Clasna/2020/802/zhenskij-zimnij-puhovik-s-kapyushonom-802-1-1380x1860.webp',
    ),
    Product(
      id: 'p5',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://alster.ua/image/cache/catalog/1-ZHENSKOE/1-Verhnjaja-odezhda/Puhoviki/Clasna/2020/802/zhenskij-zimnij-puhovik-s-kapyushonom-802-1-1380x1860.webp',
    ),
    Product(
      id: 'p6',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://alster.ua/image/cache/catalog/1-ZHENSKOE/1-Verhnjaja-odezhda/Puhoviki/Clasna/2020/802/zhenskij-zimnij-puhovik-s-kapyushonom-802-1-1380x1860.webp',
    ),
    Product(
      id: 'p7',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://alster.ua/image/cache/catalog/1-ZHENSKOE/1-Verhnjaja-odezhda/Puhoviki/Clasna/2020/802/zhenskij-zimnij-puhovik-s-kapyushonom-802-1-1380x1860.webp',
    ),
    Product(
      id: 'p8',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://alster.ua/image/cache/catalog/1-ZHENSKOE/1-Verhnjaja-odezhda/Puhoviki/Clasna/2020/802/zhenskij-zimnij-puhovik-s-kapyushonom-802-1-1380x1860.webp',
    ),
  ];

  // List<Product> _listFavoriteItems = {};

  List<Product> get items {
    // if (_showFavoritesOnly){
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._items];
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  // void showFavoritesOnly(){
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }
  //
  // void showAll(){
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }
  List<Product> get favoriteItems {
    List<Product> listFavoriteItems =
        _items.where((prodItem) => prodItem.isFavorite).toList();
    return listFavoriteItems;
  }

  void addProduct(Product product) {
    final url = Uri.parse('https://shop-academind-default-rtdb.firebaseio.com/products.json');
    http.post(url, body: json.encode(
      {
        'title': product.title,
        'description': product.description,
        'imageUrl': product.imageUrl,
        'price': product.price,
        'isFavorite': product.isFavorite,
      },
    )).then((response) {
      print(json.decode(response.body)['title']);
      final newProduct = Product(
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        id: json.decode(response.body)['name'],
      );
      _items.add(newProduct);

      notifyListeners();
    });
  }

  void updateProduct(String id, Product newProduct){
    final prodIndex = _items.indexWhere((element) => element.id == id);
    if(prodIndex >= 0) {
      _items[prodIndex] = newProduct;
    } else {
      print('...');
    }
    notifyListeners();
  }

  void deleteProduct(String id){
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void getFavoriteCount() {
    notifyListeners();
  }
}
