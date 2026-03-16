import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/api_service.dart';
import '../state/cart_state.dart';
import '../widgets/product_card.dart';
import 'cart_screen.dart';

/// Ana sayfa: Banner + arama + GridView ürün listesi.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product> _products = [];
  List<Product> _filteredProducts = [];
  bool _loading = true;
  String? _error;
  final TextEditingController _searchController = TextEditingController();
  int _cartCount = 0;

  @override
  void initState() {
    super.initState();
    _cartCount = CartState.instance.count;
    CartState.instance.onCountChanged = () {
      if (mounted) setState(() => _cartCount = CartState.instance.count);
    };
    _loadProducts();
    _searchController.addListener(_applyFilter);
  }

  @override
  void dispose() {
    _searchController.removeListener(_applyFilter);
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadProducts() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final list = await ApiService.fetchProducts();
      setState(() {
        _products = list;
        _applyFilter();
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  void _applyFilter() {
    final query = _searchController.text.trim().toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredProducts = List.from(_products);
      } else {
        _filteredProducts = _products
            .where((p) =>
                p.name.toLowerCase().contains(query) ||
                p.tagline.toLowerCase().contains(query) ||
                p.description.toLowerCase().contains(query))
            .toList();
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mini Katalog'),
        actions: [
          IconButton(
            icon: Badge(
              label: Text('$_cartCount'),
              isLabelVisible: _cartCount > 0,
              child: const Icon(Icons.shopping_cart_outlined),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (context) => CartScreen(
                    itemCount: CartState.instance.count,
                    onClear: () => setState(() => _cartCount = CartState.instance.count),
                  ),
                ),
              ).then((_) => setState(() => _cartCount = CartState.instance.count));
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadProducts,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: _BannerSection(
                imageUrl: ApiService.bannerImageUrl,
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Ürün ara...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                  ),
                ),
              ),
            ),
            if (_loading)
              const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              )
            else if (_error != null)
              SliverFillRemaining(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Veri yüklenemedi',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _error!,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(height: 16),
                        FilledButton.icon(
                          onPressed: _loadProducts,
                          icon: const Icon(Icons.refresh),
                          label: const Text('Tekrar Dene'),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            else if (_filteredProducts.isEmpty)
              const SliverFillRemaining(
                child: Center(child: Text('Ürün bulunamadı')),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.72,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final product = _filteredProducts[index];
                      return ProductCard(product: product);
                    },
                    childCount: _filteredProducts.length,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _BannerSection extends StatelessWidget {
  final String imageUrl;

  const _BannerSection({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: AspectRatio(
          aspectRatio: 2.5,
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              child: const Center(
                child: Icon(Icons.image_not_supported, size: 48),
              ),
            ),
            loadingBuilder: (_, child, progress) {
              if (progress == null) return child;
              return Container(
                color: Theme.of(context).colorScheme.surfaceContainerLow,
                child: const Center(child: CircularProgressIndicator()),
              );
            },
          ),
        ),
      ),
    );
  }
}
