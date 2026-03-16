# Mini Katalog Uygulaması

Flutter ile geliştirilmiş, eğitim amaçlı **Mini Katalog** mobil uygulaması. API'den ürün verisi çeker, GridView ile listeler, ürün detay sayfası ve sepet simülasyonu sunar.

## Özellikler

- **Ana sayfa**: Banner görseli (wantapi.com), arama kutusu, GridView ürün kartları
- **Ürün listesi**: API'den (`https://wantapi.com/products.php`) gelen ürünler, arama ve filtreleme
- **Ürün detay**: Route Arguments ile ürün bilgisi, fiyat, açıklama, özellikler (specs), sepete ekleme
- **Sepet**: Sepet simülasyonu, basit state güncelleme (ek paket kullanılmadan)
- **Navigasyon**: Navigator.push / pop, sayfalar arası geçiş

## Kullanılan Flutter sürümü

- Flutter SDK: 3.x (ortam: `sdk: '>=3.0.0 <4.0.0'`)

## Bağımlılıklar

- `flutter` (SDK)
- `http: ^1.2.0` (API istekleri için)

## Çalıştırma adımları

1. Bu projeyi klonlayın veya indirin.
2. Proje klasörüne gidin: `cd Flutter_Mobile_Katalog` (veya proje dizininiz).
3. Bağımlılıkları yükleyin: `flutter pub get`
4. Android emülatörü açın (Android Studio → AVD Manager) veya fiziksel cihazı bağlayın.
5. Uygulamayı çalıştırın: `flutter run`

Android Studio ile açmak için: **File → Open** ile `flutter2` klasörünü seçin, ardından bir cihaz/emülatör seçip Run ile çalıştırın.

## Proje yapısı

```
lib/
├── main.dart                 # Uygulama girişi, tema
├── models/
│   └── product.dart         # Ürün modeli (fromJson / toJson)
├── services/
│   └── api_service.dart     # API istekleri (ürünler, banner URL)
├── state/
│   └── cart_state.dart      # Sepet simülasyonu state
├── screens/
│   ├── home_screen.dart     # Ana sayfa (banner, arama, grid)
│   ├── product_detail_screen.dart  # Ürün detay
│   └── cart_screen.dart     # Sepet ekranı
└── widgets/
    └── product_card.dart    # GridView ürün kartı
```

## Veri kaynakları (demolar)

- **Banner**: https://wantapi.com/assets/banner.png  
- **Ürünler**: https://wantapi.com/products.php  



