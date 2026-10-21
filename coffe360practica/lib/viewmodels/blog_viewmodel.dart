import 'package:flutter/foundation.dart';
import '../database/app_database.dart';
import '../repositories/blog_repository.dart';

class BlogViewModel extends ChangeNotifier {
  final BlogRepository _repository;
  List<BlogPost> _posts = [];

  BlogViewModel(this._repository) {
    _repository.watchAllPosts().listen((postList) {
      _posts = postList;
      notifyListeners();
    });
  }

  List<BlogPost> get posts => _posts;

  Future<void> addPost(BlogPostsCompanion post) async {
    await _repository.addPost(post);
  }

  Future<void> updatePost(BlogPost post) async {
    await _repository.updatePost(post);
  }

  Future<void> deletePost(int id) async {
    await _repository.deletePost(id);
  }
}