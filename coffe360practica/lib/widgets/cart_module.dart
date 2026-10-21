import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/cart_viewmodel.dart';
import 'checkout_dialog.dart';

class CartModule extends StatelessWidget {
  const CartModule({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF3E2723),
      padding: const EdgeInsets.all(16),
      child: Consumer<CartViewModel>(
        builder: (context, cart, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Корзина', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Expanded(
                child: cart.cartItems.isEmpty
                    ? const Center(child: Text('Корзина пуста', style: TextStyle(color: Colors.white54)))
                    : ListView.builder(
                        itemCount: cart.cartItems.length,
                        itemBuilder: (context, index) {
                          final item = cart.cartItems[index];
                          return ListTile(
                            title: Text(item.name, style: const TextStyle(color: Colors.white)),
                            trailing: Text('${item.price.toInt()} ₽', style: const TextStyle(color: Colors.amber)),
                          );
                        },
                      ),
              ),
              const Divider(color: Colors.white24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Итого:', style: TextStyle(color: Colors.white, fontSize: 18)),
                  Text('${cart.totalPrice.toInt()} ₽', style: const TextStyle(color: Colors.amber, fontSize: 22, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  // А в кнопке замени onPressed:
onPressed: cart.cartItems.isEmpty ? null : () {
  showDialog(
    context: context,
    builder: (context) => const CheckoutDialog(),
  );
},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Оформить заказ'),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}