import 'package:drift/drift.dart';

// Таблица для кофе
class Coffees extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get description => text()();
  RealColumn get price => real()();
  TextColumn get imageUrl => text()();
}

// Таблица для новостей блога
class BlogPosts extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 200)();
  TextColumn get date => text()();
  TextColumn get shortDescription => text()();
  TextColumn get imageUrl => text()();
}

//Таблица для аккаунтов
class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get login => text().withLength(min: 3, max: 50)();
  TextColumn get password => text()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  BoolColumn get isAdmin => boolean().withDefault(const Constant(false))();
  TextColumn get address => text().nullable()();
}

class Orders extends Table {
  IntColumn get id => integer().autoIncrement()();
  RealColumn get totalAmount => real()();
  TextColumn get date => text()(); // Будем хранить дату в виде строки "YYYY-MM-DD"
}

