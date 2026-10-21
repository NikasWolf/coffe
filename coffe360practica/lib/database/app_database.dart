import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'tables.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Coffees, BlogPosts])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // Метод для заполнения БД начальными данными
      Future<void> seedDatabase() async {
    final coffeeCount = await coffees.count().getSingle();
    if (coffeeCount == 0) {
      await batch((batch) {
        batch.insertAll(coffees, [
          CoffeesCompanion.insert(name: 'Эспрессо', description: 'Классический крепкий кофе (30 мл).', price: 150, imageUrl: 'https://images.unsplash.com/photo-1510707577719-ae7c14805e3a?q=80&w=200&auto=format&fit=crop'),
          CoffeesCompanion.insert(name: 'Американо', description: 'Эспрессо с добавлением горячей воды (150 мл).', price: 180, imageUrl: 'https://images.unsplash.com/photo-1551030173-122aabc4489c?q=80&w=200&auto=format&fit=crop'),
          CoffeesCompanion.insert(name: 'Капучино', description: 'Эспрессо, молоко (100 мл), пышная пенка (30 мл).', price: 220, imageUrl: 'https://images.unsplash.com/photo-1534778101976-62847782c213?q=80&w=200&auto=format&fit=crop'),
          CoffeesCompanion.insert(name: 'Латте', description: 'Эспрессо, молоко (150 мл), тонкий слой пенки.', price: 240, imageUrl: 'https://images.unsplash.com/photo-1570968915860-54d5c301fa9f?q=80&w=200&auto=format&fit=crop'),
          CoffeesCompanion.insert(name: 'Раф', description: 'Эспрессо, сливки, ванильный сахар.', price: 260, imageUrl: 'https://images.unsplash.com/photo-1557006021-b85faa2bc5e2?q=80&w=200&auto=format&fit=crop'),
          CoffeesCompanion.insert(name: 'Флэт Уайт', description: 'Двойной эспрессо и молоко с микропенкой.', price: 250, imageUrl: 'https://images.unsplash.com/photo-1572442388796-11668a67e53d?q=80&w=200&auto=format&fit=crop'),
          CoffeesCompanion.insert(name: 'Мокка', description: 'Эспрессо, шоколадный сироп, молоко и сливки.', price: 280, imageUrl: 'https://images.unsplash.com/photo-1578314675249-a6910f80cc4e?q=80&w=200&auto=format&fit=crop'),
        ]);
      });
    }

    final blogCount = await blogPosts.count().getSingle();
    if (blogCount == 0) {
      await batch((batch) {
        batch.insertAll(blogPosts, [
          BlogPostsCompanion.insert(title: 'Открытие новой обжарочной станции', date: '12 октября 2023', shortDescription: 'Теперь мы обжариваем зерна прямо у вас на глазах.', imageUrl: 'https://images.unsplash.com/photo-1611162617474-5b21e879e113?q=80&w=200&auto=format&fit=crop'),
          BlogPostsCompanion.insert(title: 'Новый сорт: Эфиопия Иргачефф', date: '05 октября 2023', shortDescription: 'В нашем меню появился легендарный сорт с нотками жасмина.', imageUrl: 'https://images.unsplash.com/photo-1559525839-b184a4d698c7?q=80&w=200&auto=format&fit=crop'),
          BlogPostsCompanion.insert(title: 'Рецепт идеального флэт уайта', date: '28 сентября 2023', shortDescription: 'Делюсь секретом, как нашим бариста удается добиться идеальной текстуры.', imageUrl: 'https://images.unsplash.com/photo-1572442388796-11668a67e53d?q=80&w=200&auto=format&fit=crop'),
          BlogPostsCompanion.insert(title: 'Встреча с бариста: Иван', date: '20 сентября 2023', shortDescription: 'Поговорили с победителем регионального чемпионата о латте-арте.', imageUrl: 'https://images.unsplash.com/photo-1596952954288-16862d37405b?q=80&w=200&auto=format&fit=crop'),
          BlogPostsCompanion.insert(title: 'Переходим на экологичную посуду', date: '15 сентября 2023', shortDescription: 'Наши стаканчики теперь на 100% разлагаются. Забота о природе.', imageUrl: 'https://images.unsplash.com/photo-1530968033775-2c92736b131e?q=80&w=200&auto=format&fit=crop'),
          BlogPostsCompanion.insert(title: 'Дегустация: Колумбия Супремо', date: '01 сентября 2023', shortDescription: 'Приглашаем всех желающих на бесплатную дегустацию в эту пятницу.', imageUrl: 'https://images.unsplash.com/photo-1511920170033-f8396924c348?q=80&w=200&auto=format&fit=crop'),
          BlogPostsCompanion.insert(title: 'Готовимся к зиме: согревающие напитки', date: '25 августа 2023', shortDescription: 'Скоро в меню появятся имбирный латте и пряный какао.', imageUrl: 'https://images.unsplash.com/photo-1544787219-7f47ccb76574?q=80&w=200&auto=format&fit=crop'),
          BlogPostsCompanion.insert(title: 'Секреты идеальной пенки', date: '18 августа 2023', shortDescription: 'Рассказываем, как взбить молоко до состояния облака.', imageUrl: 'https://images.unsplash.com/photo-1570968915860-54d5c301fa9f?q=80&w=200&auto=format&fit=crop'),
          BlogPostsCompanion.insert(title: 'Наш новый десерт: Тирамису', date: '10 августа 2023', shortDescription: 'Идеально сочетается с Эспрессо. Успейте попробовать!', imageUrl: 'https://images.unsplash.com/photo-1571115177098-24ec42ed204d?q=80&w=200&auto=format&fit=crop'),
          BlogPostsCompanion.insert(title: 'Итоги месяца: 1000 чашек', date: '01 августа 2023', shortDescription: 'Мы продали 1000 чашек кофе за месяц. Спасибо, что выбираете нас!', imageUrl: 'https://images.unsplash.com/photo-1497935586351-b67a49e012bf?q=80&w=200&auto=format&fit=crop'),
        ]);
      });
    }
  }
}

QueryExecutor _openConnection() {
  return driftDatabase(name: 'app_db');
}