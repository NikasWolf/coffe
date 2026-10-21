
import '../database/app_database.dart';

class CoffeeRepository {
  final AppDatabase _db;

  CoffeeRepository(this._db);

  // Получить все кофе (в виде реактивного потока)
  Stream<List<Coffee>> watchAllCoffees() {
    return _db.select(_db.coffees).watch();
  }

  // Добавить кофе
  Future<int> addCoffee(CoffeesCompanion coffee) {
    return _db.into(_db.coffees).insert(coffee);
  }

  // Обновить кофе
  Future<bool> updateCoffee(Coffee coffee) {
    return _db.update(_db.coffees).replace(coffee);
  }

  // Удалить кофе
  Future<int> deleteCoffee(int id) {
    return (_db.delete(_db.coffees)..where((t) => t.id.equals(id))).go();
  }
}