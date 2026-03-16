import 'package:flutter/material.dart';
import '../state/cart_state.dart';

/// Sepet ekranı - eklenen ürünlerin listesi gösterilir.
class CartScreen extends StatelessWidget {
  final VoidCallback? onClear;

  const CartScreen({
    super.key,
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final cart = CartState.instance;
    final items = cart.items;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sepet'),
        actions: [
          if (items.isNotEmpty)
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
      body: items.isEmpty
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
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: items.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final product = items[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor:
                        Theme.of(context).colorScheme.surfaceContainerHighest,
                    backgroundImage: NetworkImage(product.image),
                    onBackgroundImageError: (_, __) {},
                    child: product.image.isEmpty
                        ? const Icon(Icons.image_not_supported)
                        : null,
                  ),
                  title: Text(product.name),
                  subtitle: Text(product.price),
                );
              },
            ),
    );
  }
}
