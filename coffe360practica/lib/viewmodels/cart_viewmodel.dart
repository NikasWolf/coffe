import 'package:flutter/foundation.dart';
import '../database/app_database.dart'; // <-- Импортируем модель из базы

class CartViewModel extends ChangeNotifier {
  final List<Coffee> _cartItems = []; // Теперь это Coffee из Drift

  List<Coffee> get cartItems => _cartItems;

  double get totalPrice {
    return _cartItems.fold(0, (sum, item) => sum + item.price);
  }

  void addToCart(Coffee coffee) {
    _cartItems.add(coffee);
    notifyListeners();
  }

  void removeFromCart(Coffee coffee) {
    _cartItems.remove(coffee);
    notifyListeners();
  }
}