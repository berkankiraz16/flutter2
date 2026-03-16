/// Ürün modeli - API'den gelen JSON yapısına uygun.
class Product {
  final int id;
  final String name;
  final String tagline;
  final String description;
  final String price;
  final String currency;
  final String image;
  final Map<String, String> specs;

  const Product({
    required this.id,
    required this.name,
    required this.tagline,
    required this.description,
    required this.price,
    required this.currency,
    required this.image,
    required this.specs,
  });

  /// JSON'dan Product oluşturur (fromJson).
  factory Product.fromJson(Map<String, dynamic> json) {
    final specsRaw = json['specs'] as Map<String, dynamic>? ?? {};
    final specs = <String, String>{};
    for (final e in specsRaw.entries) {
      specs[e.key] = e.value?.toString() ?? '';
    }
    return Product(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      tagline: json['tagline'] as String? ?? '',
      description: json['description'] as String? ?? '',
      price: json['price'] as String? ?? '',
      currency: json['currency'] as String? ?? '',
      image: json['image'] as String? ?? '',
      specs: specs,
    );
  }

  /// Product'ı JSON'a çevirir (toJson).
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'tagline': tagline,
      'description': description,
      'price': price,
      'currency': currency,
      'image': image,
      'specs': specs,
    };
  }
}
