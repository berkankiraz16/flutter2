/// Basit sepet simülasyonu - ek paket kullanmadan state güncelleme.
class CartState {
  CartState._();
  static final CartState _instance = CartState._();
  static CartState get instance => _instance;

  int _count = 0;
  int get count => _count;

  void Function()? onCountChanged;

  void add() {
    _count++;
    onCountChanged?.call();
  }

  void clear() {
    _count = 0;
    onCountChanged?.call();
  }
}
