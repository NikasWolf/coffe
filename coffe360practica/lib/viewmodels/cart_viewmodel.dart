import 'package:flutter/foundation.dart';
import '../database/app_database.dart';

class CartViewModel extends ChangeNotifier {
  // Теперь используем Map: Кофе -> Количество
  final Map<Coffee, int> _cartItems = {};

  Map<Coffee, int> get cartItems => _cartItems;

  // Считаем общую сумму с учетом количества
  double get totalPrice {
    double total = 0;
    _cartItems.forEach((coffee, quantity) {
      total += coffee.price * quantity;
    });
    return total;
  }

  // Получить количество конкретного напитка
  int getQuantity(Coffee coffee) {
    return _cartItems[coffee] ?? 0;
  }

  void addToCart(Coffee coffee) {
    if (_cartItems.containsKey(coffee)) {
      _cartItems[coffee] = _cartItems[coffee]! + 1;
    } else {
      _cartItems[coffee] = 1;
    }
    notifyListeners();
  }

  // Удалить одну штуку (если останется 0, удаляем совсем)
  void removeOneFromCart(Coffee coffee) {
    if (_cartItems.containsKey(coffee)) {
      if (_cartItems[coffee]! > 1) {
        _cartItems[coffee] = _cartItems[coffee]! - 1;
      } else {
        _cartItems.remove(coffee);
      }
      notifyListeners();
    }
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}