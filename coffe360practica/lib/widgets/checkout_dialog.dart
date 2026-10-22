import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart'; // Нужен для форматтеров
import '../viewmodels/cart_viewmodel.dart';
import '../database/app_database.dart';
import 'receipt_dialog.dart';
import '../repositories/order_repository.dart';

class CheckoutDialog extends StatefulWidget {
  const CheckoutDialog({super.key});

  @override
  State<CheckoutDialog> createState() => _CheckoutDialogState();
}

class _CheckoutDialogState extends State<CheckoutDialog> {
  final _cardController = TextEditingController();
  final _cvvController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  void dispose() {
    _cardController.dispose();
    _cvvController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartViewModel>();

    return AlertDialog(
      backgroundColor: const Color(0xFF3E2723),
      title: const Text('Оформление заказа', style: TextStyle(color: Colors.amber)),
      content: SizedBox(
        width: 500,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Список товаров
              const Text('Ваш заказ:', style: TextStyle(color: Colors.white70, fontSize: 16)),
              const SizedBox(height: 8),
              ...cart.cartItems.entries.map((entry) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${entry.key.name} x${entry.value}', style: const TextStyle(color: Colors.white)),
                  Text('${(entry.key.price * entry.value).toInt()} ₽', style: const TextStyle(color: Colors.amber)),
                ],
              )),
              const Divider(color: Colors.white24, height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Итого:', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  Text('${cart.totalPrice.toInt()} ₽', style: const TextStyle(color: Colors.amber, fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 24),
              
              // Поля оплаты
              const Text('Данные карты:', style: TextStyle(color: Colors.white70, fontSize: 16)),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: _buildField(
                      'Номер карты', 
                      _cardController,
                      inputFormatters: [CardNumberInputFormatter()], // Авто-пробелы
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 1,
                    child: _buildField(
                      'CVV', 
                      _cvvController, 
                      obscure: true,
                      inputFormatters: [ // Только цифры, макс 3
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(3),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Поля доставки
              const Text('Адрес доставки:', style: TextStyle(color: Colors.white70, fontSize: 16)),
              const SizedBox(height: 8),
              _buildField('Улица, дом, квартира', _addressController),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Отмена', style: TextStyle(color: Colors.white54)),
        ),
        ElevatedButton(
          onPressed: () async {
            // Убираем пробелы, чтобы проверить реальное количество цифр
            final rawCardNumber = _cardController.text.replaceAll(' ', '');

            if (rawCardNumber.length < 16 || _cvvController.text.length < 3 || _addressController.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Пожалуйста, проверьте номер карты (16 цифр), CVV (3 цифры) и адрес!'), backgroundColor: Colors.redAccent),
              );
              return;
            }

            final orderRepo = context.read<OrderRepository>();
            await orderRepo.addOrder(cart.totalPrice);

            // Создаем копию товаров для чека (теперь это Map!)
            final orderItems = Map<Coffee, int>.from(cart.cartItems);
            final total = cart.totalPrice;
            final address = _addressController.text;

            // Очищаем корзину
            cart.clearCart();

            // Закрываем окно оформления и открываем чек
            Navigator.pop(context); 
            showDialog(
              context: context,
              builder: (context) => ReceiptDialog(
                items: orderItems,
                total: total,
                address: address,
              ),
            );
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black),
          child: const Text('Оплатить'),
        ),
      ],
    );
  }

  // Метод теперь принимает форматтеры
  Widget _buildField(String label, TextEditingController controller, {bool obscure = false, List<TextInputFormatter>? inputFormatters}) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      inputFormatters: inputFormatters, // Передаем форматтеры
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.black.withValues(alpha: 0.2),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
      ),
    );
  }
}

// Класс для форматирования номера карты (пробелы каждые 4 цифры)
class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text.replaceAll(RegExp(r'\D'), ''); // Оставляем только цифры
    if (text.length > 16) text = text.substring(0, 16); // Максимум 16 цифр
    
    final buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      if (i > 0 && i % 4 == 0) buffer.write(' '); // Ставим пробел каждые 4 цифры
      buffer.write(text[i]);
    }
    final string = buffer.toString();
    
    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(offset: string.length), // Курсор в конец
    );
  }
}