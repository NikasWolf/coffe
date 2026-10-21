import 'package:flutter/material.dart';
import '../database/app_database.dart'; // Берем модель из базы
import 'dart:io';

class CoffeeCard extends StatelessWidget {
  final Coffee coffee;
  final VoidCallback onAdd;

  const CoffeeCard({super.key, required this.coffee, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF4E342E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
            // Используем Image.network для загрузки из интернета
            // Вместо старого child: Image.network(...) вставляем это:
child: coffee.imageUrl.startsWith('http')
    ? Image.network(
        coffee.imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => const Center(child: Icon(Icons.coffee, size: 48, color: Colors.brown)),
      )
    : File(coffee.imageUrl).existsSync() // Проверяем, существует ли файл по пути
        ? Image.file(
            File(coffee.imageUrl),
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => const Center(child: Icon(Icons.coffee, size: 48, color: Colors.brown)),
          )
        : const Center(child: Icon(Icons.coffee, size: 48, color: Colors.brown)), // Заглушка, если файла нет
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  coffee.name,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 4),
                Text(
                  coffee.description,
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${coffee.price.toInt()} ₽',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.amber),
                    ),
                    ElevatedButton(
                      onPressed: onAdd,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        foregroundColor: Colors.black,
                      ),
                      child: const Text('В корзину'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}