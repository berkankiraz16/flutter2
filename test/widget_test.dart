// Mini Katalog uygulaması - basit widget testi.

import 'package:flutter_test/flutter_test.dart';

import 'package:mini_katalog/main.dart';

void main() {
  testWidgets('Uygulama açılır ve Mini Katalog başlığı görünür', (WidgetTester tester) async {
    await tester.pumpWidget(const MiniKatalogApp());
    expect(find.text('Mini Katalog'), findsOneWidget);
    
  });
}
