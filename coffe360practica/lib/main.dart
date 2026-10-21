import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'database/app_database.dart';
import 'repositories/coffee_repository.dart';
import 'repositories/blog_repository.dart'; // Обязательно добавь
import 'viewmodels/cart_viewmodel.dart';
import 'viewmodels/layout_viewmodel.dart';
import 'viewmodels/catalog_viewmodel.dart';
import 'viewmodels/blog_viewmodel.dart';
import 'views/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Создаем БД и заполняем её данными при первом запуске
  final database = AppDatabase();
  await database.seedDatabase(); 

  // 2. Создаем репозитории
  final coffeeRepository = CoffeeRepository(database);
  final blogRepository = BlogRepository(database);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartViewModel()),
        ChangeNotifierProvider(create: (context) => LayoutViewModel()),
        ChangeNotifierProvider(create: (context) => CatalogViewModel(coffeeRepository)),
        ChangeNotifierProvider(create: (context) => BlogViewModel(blogRepository)), // Передаем репозиторий сюда
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
      home: const HomeScreen(),
    );
  }
}