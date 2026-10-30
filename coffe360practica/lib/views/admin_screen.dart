import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/catalog_viewmodel.dart';
import '../viewmodels/blog_viewmodel.dart';
import '../database/app_database.dart';
import '../widgets/coffee_dialog.dart';
import '../widgets/blog_dialog.dart';
import '../repositories/order_repository.dart';
import 'stats_screen.dart';

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
          actions: [
            IconButton(
              icon: const Icon(Icons.analytics, color: Colors.amber),
              tooltip: 'Статистика',
              onPressed: () async {
                final orderRepo = context.read<OrderRepository>();
                final orders = await orderRepo.getAllOrders();
                if (context.mounted) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => StatsScreen(orders: orders)),
                  );
                }
              },
            ),
          ],
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
                onPressed: () async {
                  // Открываем диалог для ДОБАВЛЕНИЯ (передаем null)
                  final result = await showDialog<Map<String, dynamic>>(
                    context: context,
                    builder: (context) => const CoffeeDialog(),
                  );
                  if (result != null && context.mounted) {
                    // Сохраняем в БД через ViewModel
                    context.read<CatalogViewModel>().addCoffee(
                      CoffeesCompanion.insert(
                        name: result['name'],
                        description: result['description'],
                        price: result['price'],
                        imageUrl: result['imageUrl'],
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.add),
                label: const Text('Добавить'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black),
              )
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
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
                              onPressed: () async {
                                // Открываем диалог для РЕДАКТИРОВАНИЯ (передаем текущий объект)
                                final result = await showDialog<Map<String, dynamic>>(
                                  context: context,
                                  builder: (context) => CoffeeDialog(existingCoffee: coffee),
                                );
                                if (result != null && context.mounted) {
                                  context.read<CatalogViewModel>().updateCoffee(
                                    Coffee(
                                      id: coffee.id, // Сохраняем старый ID
                                      name: result['name'],
                                      description: result['description'],
                                      price: result['price'],
                                      imageUrl: result['imageUrl'],
                                    ),
                                  );
                                }
                              }
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.redAccent), 
                              onPressed: () => catalogVM.deleteCoffee(coffee.id),
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
                onPressed: () async {
                  // Открываем диалог для ДОБАВЛЕНИЯ
                  final result = await showDialog<Map<String, dynamic>>(
                    context: context,
                    builder: (context) => const BlogDialog(),
                  );
                  if (result != null && context.mounted) {
                    context.read<BlogViewModel>().addPost(
                      BlogPostsCompanion.insert(
                        title: result['title'],
                        date: result['date'],
                        shortDescription: result['shortDescription'],
                        imageUrl: result['imageUrl'],
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.add),
                label: const Text('Написать'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black),
              )
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
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
                              onPressed: () async {
                                // Открываем диалог для РЕДАКТИРОВАНИЯ
                                final result = await showDialog<Map<String, dynamic>>(
                                  context: context,
                                  builder: (context) => BlogDialog(existingPost: post),
                                );
                                if (result != null && context.mounted) {
                                  context.read<BlogViewModel>().updatePost(
                                    BlogPost(
                                      id: post.id,
                                      title: result['title'],
                                      date: result['date'],
                                      shortDescription: result['shortDescription'],
                                      imageUrl: result['imageUrl'],
                                    ),
                                  );
                                }
                              }
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