import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

/// API'den ürün ve banner verilerini çeker.
class ApiService {
  static const String baseUrl = 'https://wantapi.com';
  static const String productsEndpoint = '/products.php';
  static const String bannerUrl = '$baseUrl/assets/banner.png';

  /// Ürün listesini API'den getirir.
  static Future<List<Product>> fetchProducts() async {
    final uri = Uri.parse('$baseUrl$productsEndpoint');
    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Ürünler yüklenemedi: ${response.statusCode}');
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final status = json['status'] as String?;
    if (status != 'success') {
      throw Exception('API hatası: $status');
    }

    final data = json['data'] as List<dynamic>?;
    if (data == null) return [];

    return data
        .map((e) => Product.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// Banner görsel URL'i (eğitim amaçlı dokümandaki adres).
  static String get bannerImageUrl => bannerUrl;
}
