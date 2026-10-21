import '../database/app_database.dart';

class BlogRepository {
  final AppDatabase _db;

  BlogRepository(this._db);

  Stream<List<BlogPost>> watchAllPosts() {
    return _db.select(_db.blogPosts).watch();
  }

  Future<int> deletePost(int id) {
    return (_db.delete(_db.blogPosts)..where((t) => t.id.equals(id))).go();
  }
}