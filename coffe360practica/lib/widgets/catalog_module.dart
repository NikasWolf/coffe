import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/cart_viewmodel.dart';
import '../viewmodels/catalog_viewmodel.dart';
import 'coffee_card.dart';

class CatalogModule extends StatelessWidget {
  const CatalogModule({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Меню каталога', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Expanded(
            child: Consumer<CatalogViewModel>(
              builder: (context, catalogVM, child) {
                return ListView.builder(
                  itemCount: catalogVM.coffees.length,
                  itemBuilder: (context, index) {
                    final coffee = catalogVM.coffees[index];
                    return CoffeeCard(
                      coffee: coffee,
                      onAdd: () => context.read<CartViewModel>().addToCart(coffee),
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