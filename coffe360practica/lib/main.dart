import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'database/app_database.dart';
import 'repositories/coffee_repository.dart';
import 'repositories/blog_repository.dart';
import 'repositories/user_repository.dart'; // Новый
import 'viewmodels/cart_viewmodel.dart';
import 'viewmodels/layout_viewmodel.dart';
import 'viewmodels/catalog_viewmodel.dart';
import 'viewmodels/blog_viewmodel.dart';
import 'viewmodels/auth_viewmodel.dart'; // Новый
import 'views/home_screen.dart';
import 'views/auth_screen.dart'; // Новый
import 'repositories/order_repository.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = AppDatabase();
  await database.seedDatabase(); 

  // 1. Создаем репозитории
  final coffeeRepository = CoffeeRepository(database);
  final blogRepository = BlogRepository(database);
  final userRepository = UserRepository(database);
  final orderRepository = OrderRepository(database); // <-- ВОТ ЗДЕСЬ СОЗДАЛИ

  runApp(
    MultiProvider(
      providers: [
        // Сначала передаем готовый репозиторий (через Provider.value)
        Provider.value(value: orderRepository), // <-- ВОТ СЮДА ДОБАВЬ

        // Затем передаем ViewModels
        ChangeNotifierProvider(create: (context) => CartViewModel()),
        ChangeNotifierProvider(create: (context) => LayoutViewModel()),
        ChangeNotifierProvider(create: (context) => CatalogViewModel(coffeeRepository)),
        ChangeNotifierProvider(create: (context) => BlogViewModel(blogRepository)),
        ChangeNotifierProvider(create: (context) => AuthViewModel(userRepository)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coffee App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF2D1B14),
        useMaterial3: true,
      ),
      // Слушаем AuthViewModel: если вошел - HomeScreen, иначе - AuthScreen
      home: Consumer<AuthViewModel>(
        builder: (context, auth, child) {
          if (auth.isLoggedIn) {
            return const HomeScreen();
          }
          return const AuthScreen();
        },
      ),
    );
  }
}