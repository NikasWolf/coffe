import '../database/app_database.dart';

class OrderRepository {
  final AppDatabase _db;
  OrderRepository(this._db);

  // Сохранить новый заказ
  Future<int> addOrder(double totalAmount) async {
    final now = DateTime.now();
    final dateStr = '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
    return await _db.into(_db.orders).insert(
      OrdersCompanion.insert(totalAmount: totalAmount, date: dateStr),
    );
  }

  // Получить все заказы (для подсчета статистики)
  Future<List<Order>> getAllOrders() {
    return _db.select(_db.orders).get();
  }
}