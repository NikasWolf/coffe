import 'package:drift/drift.dart';
import '../database/app_database.dart';

class UserRepository {
  final AppDatabase _db;
  UserRepository(this._db);

  Future<User?> login(String login, String password) async {
    final query = _db.select(_db.users)
      ..where((t) => t.login.equals(login) & t.password.equals(password))
      ..limit(1); // <-- Берем только одного пользователя, даже если есть дубликаты
    return await query.getSingleOrNull();
  }

  Future<bool> isLoginTaken(String login) async {
    final query = _db.select(_db.users)..where((t) => t.login.equals(login));
    final results = await query.get(); // Просто получаем список (даже если там 2 записи)
    return results.isNotEmpty;         // Если список не пустой - логин занят
  }

  Future<User> register(UsersCompanion user) async {
    final id = await _db.into(_db.users).insert(user);
    // Находим только что созданного пользователя по ID и возвращаем
    return await (_db.select(_db.users)..where((t) => t.id.equals(id))).getSingle();
  }
  Future<bool> updateUser(User user) async {
    return await _db.update(_db.users).replace(user);
  }
}