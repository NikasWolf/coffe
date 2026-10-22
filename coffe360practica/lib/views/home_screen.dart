import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/app_module.dart';
import '../viewmodels/layout_viewmodel.dart';
import '../viewmodels/auth_viewmodel.dart'; // <-- ДОБАВИЛИ ИМПОРТ
import '../widgets/blog_module.dart';
import '../widgets/catalog_module.dart';
import '../widgets/cart_module.dart';
import '../widgets/account_dialog.dart'; 
import 'admin_screen.dart'; 

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget _buildModuleWidget(AppModuleType type) {
    switch (type) {
      case AppModuleType.blog: return const BlogModule();
      case AppModuleType.catalog: return const CatalogModule();
      case AppModuleType.cart: return const CartModule();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2D1B14),
      body: Column(
        children: [
          // ВЕРХНЯЯ ПАНЕЛЬ ПРИЛОЖЕНИЯ
          Container(
            height: 60,
            color: const Color(0xFF1A110D),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const Icon(Icons.coffee, color: Colors.amber, size: 24),
                const SizedBox(width: 12),
                const Text(
                  'Кофейня "Зерно"',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 32),
                
                // КНОПКИ ВКЛЮЧЕНИЯ/ВЫКЛЮЧЕНИЯ МОДУЛЕЙ
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Consumer<LayoutViewModel>(
                      builder: (context, layoutVM, child) {
                        return Row(
                          children: AppModuleType.values.map((type) {
                            final isActive = layoutVM.isModuleActive(type);
                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: FilterChip(
                                label: Text(type.title),
                                selected: isActive,
                                onSelected: (val) => layoutVM.toggleModule(type),
                                selectedColor: Colors.amber,
                                backgroundColor: Colors.white.withValues(alpha: 0.1),
                                labelStyle: TextStyle(
                                  color: isActive ? Colors.black : Colors.white70,
                                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                                ),
                                checkmarkColor: Colors.black,
                                side: BorderSide(color: isActive ? Colors.amber : Colors.white24),
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ),
                ),

                // КНОПКИ АККАУНТА И АДМИНА (Справа) - ОБЕРНУТЫ В CONSUMER
                Consumer<AuthViewModel>(
                  builder: (context, auth, child) {
                    return Row(
                      children: [
                        // Имя текущего пользователя
                        if (auth.currentUser != null)
                          Text(
                            auth.currentUser!.name, 
                            style: const TextStyle(color: Colors.white70, fontSize: 14),
                          ),
                        const SizedBox(width: 16),

                        // Кнопка аккаунта (открывает диалоговое окно, доступна всем)
                        IconButton(
                          icon: const Icon(Icons.account_circle, color: Colors.white70, size: 28),
                          tooltip: 'Аккаунт',
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => const AccountDialog(),
                            );
                          },
                        ),
                        
                        // Кнопка перехода в админку (ТОЛЬКО ДЛЯ АДМИНА)
                        if (auth.isAdmin) ...[
                          const SizedBox(width: 8),
                          IconButton(
                            icon: const Icon(Icons.admin_panel_settings, color: Colors.amber, size: 28),
                            tooltip: 'Панель администратора',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const AdminScreen()),
                              );
                            },
                          ),
                        ],
                      ],
                    );
                  },
                ),
              ],
            ),
          ),

          // ОБЛАСТЬ МОДУЛЕЙ (без изменений)
          Expanded(
            child: Consumer<LayoutViewModel>(
              builder: (context, layoutVM, child) {
                if (layoutVM.activeModules.isEmpty) {
                  return const Center(
                    child: Text(
                      'Все модули скрыты. Включите их кнопками сверху.',
                      style: TextStyle(color: Colors.white54, fontSize: 18),
                    ),
                  );
                }

                return ReorderableListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: layoutVM.activeModules.length,
                  onReorderItem: (oldIndex, newIndex) {
                    layoutVM.reorderModules(oldIndex, newIndex);
                  },
                  itemBuilder: (context, index) {
                    final module = layoutVM.activeModules[index];
                    final double width = MediaQuery.of(context).size.width / layoutVM.activeModules.length;

                    return Container(
                      key: ValueKey(module),
                      width: width,
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(color: Colors.black.withValues(alpha: 0.3), width: 2),
                        ),
                      ),
                      child: Column(
                        children: [
                          ReorderableDragStartListener(
                            index: index,
                            child: Container(
                              height: 30,
                              width: double.infinity,
                              color: const Color(0xFF4E342E),
                              child: const Center(
                                child: Icon(Icons.drag_handle, size: 20, color: Colors.white54),
                              ),
                            ),
                          ),
                          Expanded(
                            child: _buildModuleWidget(module),
                          ),
                        ],
                      ),
                    );
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