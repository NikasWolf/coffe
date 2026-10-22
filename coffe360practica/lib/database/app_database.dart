import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'tables.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Coffees, BlogPosts, Users, Orders]) // <-- Добавили Orders
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // Метод для заполнения БД начальными данными
  Future<void> seedDatabase() async {
    // 1. Заполняем каталог кофе
    final coffeeCount = await coffees.count().getSingle();
    if (coffeeCount == 0) {
      await batch((batch) {
        batch.insertAll(coffees, [
          CoffeesCompanion.insert(name: 'Эспрессо', description: 'Классический крепкий кофе (30 мл).', price: 150, imageUrl: 'images/Espresso.png'),
          CoffeesCompanion.insert(name: 'Американо', description: 'Эспрессо с добавлением горячей воды (150 мл).', price: 180, imageUrl: 'images/AmericaNO.png'),
          CoffeesCompanion.insert(name: 'Капучино', description: 'Эспрессо, молоко (100 мл), пышная пенка (30 мл).', price: 220, imageUrl: 'images/Kapuchino.png'),
          CoffeesCompanion.insert(name: 'Латте', description: 'Эспрессо, молоко (150 мл), тонкий слой пенки.', price: 240, imageUrl: 'images/Latte.png'),
          CoffeesCompanion.insert(name: 'Раф', description: 'Эспрессо, сливки, ванильный сахар.', price: 260, imageUrl: 'images/Raft.png'),
          CoffeesCompanion.insert(name: 'Флэт Уайт', description: 'Двойной эспрессо и молоко с микропенкой.', price: 250, imageUrl: 'images/FletYait.png'),
          CoffeesCompanion.insert(name: 'Мокка', description: 'Эспрессо, шоколадный сироп, молоко и сливки.', price: 280, imageUrl: 'images/001.jpg'),
        ]);
      });
    }

    // 2. Заполняем блог
    final blogCount = await blogPosts.count().getSingle();
    if (blogCount == 0) {
      await batch((batch) {
        batch.insertAll(blogPosts, [
          BlogPostsCompanion.insert(title: 'Открытие новой обжарочной станции', date: '12 октября 2023', shortDescription: 'Теперь мы обжариваем зерна прямо у вас на глазах.', imageUrl: 'images/n01.png'),
          BlogPostsCompanion.insert(title: 'Новый сорт: Эфиопия Иргачефф', date: '05 октября 2023', shortDescription: 'В нашем меню появился легендарный сорт с нотками жасмина.', imageUrl: 'images/n02.png'),
          BlogPostsCompanion.insert(title: 'Рецепт идеального флэт уайта', date: '28 сентября 2023', shortDescription: 'Делюсь секретом, как нашим бариста удается добиться идеальной текстуры.', imageUrl: 'images/n03.png'),
          BlogPostsCompanion.insert(title: 'Встреча с бариста: Иван', date: '20 сентября 2023', shortDescription: 'Поговорили с победителем регионального чемпионата о латте-арте.', imageUrl: 'images/n04.png'),
          BlogPostsCompanion.insert(title: 'Переходим на экологичную посуду', date: '15 сентября 2023', shortDescription: 'Наши стаканчики теперь на 100% разлагаются. Забота о природе.', imageUrl: 'images/n05.png'),
          BlogPostsCompanion.insert(title: 'Дегустация: Колумбия Супремо', date: '01 сентября 2023', shortDescription: 'Приглашаем всех желающих на бесплатную дегустацию в эту пятницу.', imageUrl: 'images/n06.png'),
          BlogPostsCompanion.insert(title: 'Готовимся к зиме: согревающие напитки', date: '25 августа 2023', shortDescription: 'Скоро в меню появятся имбирный латте и пряный какао.', imageUrl: 'images/n07.png'),
          BlogPostsCompanion.insert(title: 'Секреты идеальной пенки', date: '18 августа 2023', shortDescription: 'Рассказываем, как взбить молоко до состояния облака.', imageUrl: 'images/n08.png'),
          BlogPostsCompanion.insert(title: 'Наш новый десерт: Тирамису', date: '10 августа 2023', shortDescription: 'Идеально сочетается с Эспрессо. Успейте попробовать!', imageUrl: 'images/n09.png'),
          BlogPostsCompanion.insert(title: 'Итоги месяца: 1000 чашек', date: '01 августа 2023', shortDescription: 'Мы продали 1000 чашек кофе за месяц. Спасибо, что выбираете нас!', imageUrl: 'images/n10.png'),
        ]);
      });
    }

    // 3. Создаем дефолтного админа
    final userCount = await users.count().getSingle();
    if (userCount == 0) {
      await into(users).insert(UsersCompanion.insert(
        login: 'admin',
        password: 'admin',
        name: 'Главный Администратор',
        isAdmin: const Value(true),
      ));
    }

    // 4. Генерируем тестовые заказы для статистики (если их нет)
    final orderCount = await orders.count().getSingle();
    if (orderCount == 0) {
      final today = DateTime.now();
      // Форматируем дату как YYYY-MM-DD
      String formatDate(int daysAgo) {
        final d = today.subtract(Duration(days: daysAgo));
        return '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
      }

      await batch((batch) {
        batch.insertAll(orders, [
          OrdersCompanion.insert(totalAmount: 450.0, date: formatDate(0)),
          OrdersCompanion.insert(totalAmount: 720.0, date: formatDate(1)),
          OrdersCompanion.insert(totalAmount: 150.0, date: formatDate(1)),
          OrdersCompanion.insert(totalAmount: 1200.0, date: formatDate(2)),
          OrdersCompanion.insert(totalAmount: 850.0, date: formatDate(3)),
          OrdersCompanion.insert(totalAmount: 300.0, date: formatDate(4)),
        ]);
      });
    }
  }
}

QueryExecutor _openConnection() {
  return driftDatabase(name: 'app_db');
}