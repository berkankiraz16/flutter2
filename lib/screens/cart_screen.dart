import 'package:flutter/material.dart';
import '../state/cart_state.dart';

/// Sepet ekranı (simülasyon) - proje çıktısı gereksinimi.
class CartScreen extends StatelessWidget {
  final int itemCount;
  final VoidCallback? onClear;

  const CartScreen({
    super.key,
    required this.itemCount,
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sepet'),
        actions: [
          if (itemCount > 0)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () {
                CartState.instance.clear();
                onClear?.call();
                if (context.mounted) Navigator.pop(context);
              },
            ),
        ],
      ),
      body: itemCount == 0
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined, size: 80),
                  SizedBox(height: 16),
                  Text('Sepetiniz boş'),
                ],
              ),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.shopping_cart, size: 80),
                  const SizedBox(height: 16),
                  Text(
                    '$itemCount ürün (simülasyon)',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Bu proje eğitim amaçlıdır.\nGerçek ödeme altyapısı yoktur.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
    );
  }
}
