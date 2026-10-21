import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/cart_viewmodel.dart';
import 'receipt_dialog.dart';
import '../database/app_database.dart';
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
              ...cart.cartItems.map((item) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(item.name, style: const TextStyle(color: Colors.white)),
                  Text('${item.price.toInt()} ₽', style: const TextStyle(color: Colors.amber)),
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
                    child: _buildField('Номер карты', _cardController),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 1,
                    child: _buildField('CVV', _cvvController, obscure: true),
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
          onPressed: () {
            // Простая проверка на заполнение полей
            if (_cardController.text.length < 16 || _cvvController.text.length < 3 || _addressController.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Пожалуйста, заполните все данные карты и адреса!'), backgroundColor: Colors.redAccent),
              );
              return;
            }

            // Создаем копию товаров для чека, так как корзина сейчас очистится
            final orderItems = List<Coffee>.from(cart.cartItems);
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

  Widget _buildField(String label, TextEditingController controller, {bool obscure = false}) {
    return TextField(
      controller: controller,
      obscureText: obscure,
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