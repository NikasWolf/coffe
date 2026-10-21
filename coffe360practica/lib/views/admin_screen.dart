import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/catalog_viewmodel.dart';
import '../viewmodels/blog_viewmodel.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFF2D1B14),
        appBar: AppBar(
          backgroundColor: const Color(0xFF1A110D),
          title: const Text('Панель администратора', style: TextStyle(color: Colors.amber)),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          bottom: const TabBar(
            indicatorColor: Colors.amber,
            labelColor: Colors.amber,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(text: 'Управление каталогом', icon: Icon(Icons.coffee)),
              Tab(text: 'Управление блогом', icon: Icon(Icons.article)),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _AdminCatalogTab(),
            _AdminBlogTab(),
          ],
        ),
      ),
    );
  }
}

class _AdminCatalogTab extends StatelessWidget {
  const _AdminCatalogTab();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Товары в каталоге', style: TextStyle(color: Colors.white, fontSize: 20)),
              ElevatedButton.icon(
                onPressed: () { /* TODO: Добавить кофе */ },
                icon: const Icon(Icons.add),
                label: const Text('Добавить'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black),
              )
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            // Читаем данные из CatalogViewModel
            child: Consumer<CatalogViewModel>(
              builder: (context, catalogVM, child) {
                return ListView.builder(
                  itemCount: catalogVM.coffees.length,
                  itemBuilder: (context, index) {
                    final coffee = catalogVM.coffees[index];
                    return Card(
                      color: const Color(0xFF3E2723),
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        title: Text(coffee.name, style: const TextStyle(color: Colors.white)),
                        subtitle: Text('${coffee.price.toInt()} ₽', style: const TextStyle(color: Colors.amber)),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blueAccent), 
                              onPressed: () { /* TODO: Редактировать */ }
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.redAccent), 
                              onPressed: () => catalogVM.deleteCoffee(coffee.id), // Рабочее удаление!
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class _AdminBlogTab extends StatelessWidget {
  const _AdminBlogTab();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Новости блога', style: TextStyle(color: Colors.white, fontSize: 20)),
              ElevatedButton.icon(
                onPressed: () { /* TODO: Добавить новость */ },
                icon: const Icon(Icons.add),
                label: const Text('Написать'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black),
              )
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            // Читаем данные из BlogViewModel
            child: Consumer<BlogViewModel>(
              builder: (context, blogVM, child) {
                return ListView.builder(
                  itemCount: blogVM.posts.length,
                  itemBuilder: (context, index) {
                    final post = blogVM.posts[index];
                    return Card(
                      color: const Color(0xFF3E2723),
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        title: Text(post.title, style: const TextStyle(color: Colors.white)),
                        subtitle: Text(post.date, style: const TextStyle(color: Colors.amber)),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blueAccent), 
                              onPressed: () { /* TODO: Редактировать */ }
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.redAccent), 
                              onPressed: () => blogVM.deletePost(post.id),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}