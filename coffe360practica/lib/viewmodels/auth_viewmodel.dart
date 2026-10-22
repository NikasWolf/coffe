import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import '../database/app_database.dart';
import '../repositories/user_repository.dart';

class AuthViewModel extends ChangeNotifier {
  final UserRepository _repository;
  User? _currentUser;

  AuthViewModel(this._repository);

  User? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;
  bool get isAdmin => _currentUser?.isAdmin ?? false;

  // Вход
  Future<String?> login(String login, String password) async {
    final user = await _repository.login(login, password);
    if (user != null) {
      _currentUser = user;
      notifyListeners();
      return null; // Успех, ошибки нет
    }
    return 'Неверный логин или пароль'; // Ошибка
  }

  
    // Регистрация с автоматическим входом
  Future<String?> register(String name, String login, String password) async {
    try {
      final taken = await _repository.isLoginTaken(login);
      if (taken) {
        return 'Этот логин уже занят';
      }

      final newUser = UsersCompanion.insert(
        login: login,
        password: password,
        name: name,
        isAdmin: const Value(false),
      );
      
      // Создаем пользователя и получаем его обратно
      final createdUser = await _repository.register(newUser);
      
      // МАГИЯ: Сразу делаем его текущим пользователем
      _currentUser = createdUser;
      notifyListeners(); // Сообщаем приложению, что мы вошли

      return null; // Успех
    } catch (e) {
      return 'Ошибка при регистрации: $e';
    }
  }
  
  // Выход
  void logout() {
    _currentUser = null;
    notifyListeners();
  }
  
  // Обновление данных профиля
  Future<void> updateProfile(User updatedUser) async {
    await _repository.updateUser(updatedUser);
    _currentUser = updatedUser;
    notifyListeners();
  }
}