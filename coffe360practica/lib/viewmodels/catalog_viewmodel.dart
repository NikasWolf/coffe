import 'package:flutter/foundation.dart';
import '../database/app_database.dart';
import '../repositories/coffee_repository.dart';

class CatalogViewModel extends ChangeNotifier {
  final CoffeeRepository _repository;
  List<Coffee> _coffees = [];

  CatalogViewModel(this._repository) {
    // Подписываемся на поток данных из БД
    _repository.watchAllCoffees().listen((coffeeList) {
      _coffees = coffeeList;
      notifyListeners(); 
    });
  }

  List<Coffee> get coffees => _coffees;

  Future<void> addCoffee(CoffeesCompanion coffee) async {
    await _repository.addCoffee(coffee);
  }

  Future<void> deleteCoffee(int id) async {
    await _repository.deleteCoffee(id);
  }
}