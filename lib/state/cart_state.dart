import '../models/product.dart';

/// Basit sepet simülasyonu - ek paket kullanmadan state güncelleme.
class CartState {
  CartState._();
  static final CartState _instance = CartState._();
  static CartState get instance => _instance;

  final List<Product> _items = [];

  /// Sepetteki ürünlerin değiştirilemeyen kopyası.
  List<Product> get items => List.unmodifiable(_items);

  /// Sepetteki toplam ürün sayısı.
  int get count => _items.length;

  void Function()? onCountChanged;

  /// Ürünü sepete ekler.
  void add(Product product) {
    _items.add(product);
    onCountChanged?.call();
  }

  /// Tüm sepeti temizler.
  void clear() {
    _items.clear();
    onCountChanged?.call();
  }
}
