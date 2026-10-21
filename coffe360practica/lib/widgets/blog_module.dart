import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/blog_viewmodel.dart';
import 'blog_card.dart';

class BlogModule extends StatelessWidget {
  const BlogModule({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Новости кофейни', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Expanded(
            child: Consumer<BlogViewModel>(
              builder: (context, blogVM, child) {
                return ListView.builder(
                  itemCount: blogVM.posts.length,
                  itemBuilder: (context, index) {
                    return BlogCard(post: blogVM.posts[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}