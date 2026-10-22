import 'package:flutter/material.dart';
import '../database/app_database.dart';

class ReceiptDialog extends StatelessWidget {
  // МЕНЯЕМ ТИП С List НА Map
  final Map<Coffee, int> items; 
  final double total;
  final String address;

  const ReceiptDialog({
    super.key,
    required this.items,
    required this.total,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    // Генерируем случайный номер чека для красоты
    final receiptNumber = DateTime.now().millisecondsSinceEpoch.toString().substring(7);
    final date = DateTime.now().toLocal().toString().split('.')[0];

    return AlertDialog(
      backgroundColor: const Color(0xFFE8E8E8), // Цвет бумаги
      title: const Icon(Icons.check_circle, color: Colors.green, size: 48), // Галочка успеха
      content: SingleChildScrollView(  
        child: Container(
          width: 300,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 10, offset: const Offset(0, 5)),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('КОФЕЙНЯ "ЗЕРНО"', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
              const SizedBox(height: 4),
              const Text('г. Москва, ул. Кофейная, д. 1', style: TextStyle(fontSize: 12, color: Colors.black54)),
              const SizedBox(height: 8),
              const Text('========================================', style: TextStyle(color: Colors.black54, letterSpacing: -1)),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('ЧЕК №$receiptNumber', style: const TextStyle(fontSize: 12, color: Colors.black)),
                  Text(date, style: const TextStyle(fontSize: 12, color: Colors.black)),
                ],
              ),
              const SizedBox(height: 8),
              const Text('----------------------------------------', style: TextStyle(color: Colors.black54, letterSpacing: -1)),
              const SizedBox(height: 8),
              
              // ОБНОВЛЕННЫЙ СПИСОК ТОВАРОВ (через .entries)
              ...items.entries.map((entry) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        '${entry.key.name} x${entry.value}', // Выводим название и количество
                        style: const TextStyle(fontSize: 14, color: Colors.black),
                      ),
                    ),
                    Text(
                      '${(entry.key.price * entry.value).toInt()} ₽', // Считаем общую цену за этот товар
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ],
                ),
              )),
              
              const SizedBox(height: 8),
              const Text('----------------------------------------', style: TextStyle(color: Colors.black54, letterSpacing: -1)),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('ИТОГО:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
                  Text('${total.toInt()} ₽', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
                ],
              ),
              const SizedBox(height: 16),
              const Text('========================================', style: TextStyle(color: Colors.black54, letterSpacing: -1)),
              const SizedBox(height: 8),
              const Text('Адрес доставки:', style: TextStyle(fontSize: 12, color: Colors.black54)),
              Text(address, style: const TextStyle(fontSize: 12, color: Colors.black), textAlign: TextAlign.center),
              const SizedBox(height: 16),
              const Text('СПАСИБО ЗА ПОКУПКУ!', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black)),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black),
          child: const Text('Закрыть'),
        ),
      ],
    );
  }
}