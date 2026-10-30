import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:coffe360practica/viewmodels/auth_viewmodel.dart'; // Замени на свое имя пакета
import 'package:coffe360practica/views/auth_screen.dart';         // Замени на свое имя пакета

// Создаем фейковую ViewModel для тестов
class MockAuthViewModel extends ChangeNotifier implements AuthViewModel {
  bool _isLoggedIn = false;
  String? _mockError;

  @override
  bool get isLoggedIn => _isLoggedIn;

  void setError(String? error) {
    _mockError = error;
    notifyListeners();
  }

  @override
  Future<String?> login(String login, String password) async {
    await Future.delayed(const Duration(milliseconds: 100)); // Имитация задержки
    if (login == "admin" && password == "123") {
      _isLoggedIn = true;
      notifyListeners();
      return null;
    }
    return "Неверный логин или пароль";
  }

  @override
  Future<String?> register(String name, String login, String password) async {
    await Future.delayed(const Duration(milliseconds: 100));
    if (name.isNotEmpty) {
      _isLoggedIn = true;
      notifyListeners();
      return null;
    }
    return "Ошибка регистрации";
  }
  
  // Заглушки для остальных методов интерфейса (если они есть)
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  group('Тестирование экрана авторизации (AuthScreen)', () {
    
    // Тест 1: Проверка отображения элементов
    testWidgets('Отображение полей ввода и кнопки "Войти"', (WidgetTester tester) async {
      final mockVM = MockAuthViewModel();
      
      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider<AuthViewModel>.value(
            value: mockVM,
            child: const AuthScreen(),
          ),
        ),
      );

      // Проверяем наличие полей и кнопок
      expect(find.byType(TextField), findsNWidgets(2)); // Логин и Пароль
      expect(find.text('Вход в систему'), findsOneWidget);
      expect(find.text('Войти'), findsOneWidget);
      expect(find.text('Нет аккаунта? Зарегистрироваться'), findsOneWidget);
    });

    // Тест 2: Переключение на режим регистрации
    testWidgets('Переключение между входом и регистрацией', (WidgetTester tester) async {
      final mockVM = MockAuthViewModel();
      
      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider<AuthViewModel>.value(
            value: mockVM,
            child: const AuthScreen(),
          ),
        ),
      );

      // Нажимаем на кнопку переключения
      await tester.tap(find.text('Нет аккаунта? Зарегистрироваться'));
      await tester.pumpAndSettle(); // Ждем обновления UI

      // Теперь должно быть 3 поля (Имя, Логин, Пароль) и кнопка "Зарегистрироваться"
      expect(find.byType(TextField), findsNWidgets(3));
      expect(find.text('Регистрация'), findsOneWidget);
      expect(find.text('Зарегистрироваться'), findsOneWidget);
    });

    // Тест 3: Валидация пустых полей
    testWidgets('Проверка ошибки при пустых полях', (WidgetTester tester) async {
      final mockVM = MockAuthViewModel();
      
      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider<AuthViewModel>.value(
            value: mockVM,
            child: const AuthScreen(),
          ),
        ),
      );

      // Нажимаем "Войти", ничего не вводя
      await tester.tap(find.text('Войти'));
      await tester.pump(); // Обновляем состояние

      // Ожидаем появление текста ошибки
      expect(find.text('Заполните все поля'), findsOneWidget);
    });

    // Тест 4: Успешный вход
    testWidgets('Успешный вход с корректными данными', (WidgetTester tester) async {
      final mockVM = MockAuthViewModel();
      
      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider<AuthViewModel>.value(
            value: mockVM,
            child: const AuthScreen(),
          ),
        ),
      );

      // Вводим данные в поля (по индексу: 0 - логин, 1 - пароль)
      await tester.enterText(find.byType(TextField).at(0), 'admin');
      await tester.enterText(find.byType(TextField).at(1), '123');
      
      // Нажимаем "Войти"
      await tester.tap(find.text('Войти'));
      await tester.pumpAndSettle(); // Ждем завершения асинхронного запроса

      // Проверяем, что ViewModel перешла в состояние "залогинен"
      expect(mockVM.isLoggedIn, isTrue);
      // И ошибки на экране нет
      expect(find.text('Заполните все поля'), findsNothing);
    });
  });
}