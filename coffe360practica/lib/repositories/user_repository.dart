import 'package:drift/drift.dart';
import '../database/app_database.dart';

class UserRepository {
  final AppDatabase _db;
  UserRepository(this._db);

  Future<User?> login(String login, String password) async {
    final query = _db.select(_db.users)
      ..where((t) => t.login.equals(login) & t.password.equals(password))
      ..limit(1); 
    return await query.getSingleOrNull();
  }

  Future<bool> isLoginTaken(String login) async {
    final query = _db.select(_db.users)..where((t) => t.login.equals(login));
    final results = await query.get();
    return results.isNotEmpty;         
  }

  Future<User> register(UsersCompanion user) async {
    final id = await _db.into(_db.users).insert(user);
    return await (_db.select(_db.users)..where((t) => t.id.equals(id))).getSingle();
  }
  Future<bool> updateUser(User user) async {
    return await _db.update(_db.users).replace(user);
  }
}