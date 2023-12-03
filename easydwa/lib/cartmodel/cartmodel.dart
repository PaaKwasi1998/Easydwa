import 'package:flutter/material.dart';

class CartModel with ChangeNotifier {
  Map<Item, int> _itemsInCart = {};

  Map<Item, int> get itemsInCart => _itemsInCart;

  int get itemCount => _itemsInCart.values.fold(0, (previousValue, element) => previousValue + element);

  Iterable<Item> get fruitsInCart => _itemsInCart.keys;

  void addItem(Item item) {
    if (!_itemsInCart.containsKey(item)) {
      _itemsInCart[item] = 1;
    } else {
      _itemsInCart[item] = _itemsInCart[item]! + 1;
    }
    notifyListeners();
  }

  void removeItem(Item item) {
    if (_itemsInCart.containsKey(item) && _itemsInCart[item]! > 1) {
      _itemsInCart[item] = _itemsInCart[item]! - 1;
    } else {
      _itemsInCart.remove(item);
    }
    notifyListeners();
  }


void setItemQuantity(Item item, int quantity) {
  _itemsInCart[item] = quantity;
  notifyListeners();
}
}

class Item {
  final String name;
  final String imagePath;
  final double price;

  Item({required this.name, required this.imagePath, required this.price});

  @override
  bool operator ==(Object other) => 
    other is Item && other.name == name;

  @override
  int get hashCode => name.hashCode;
}