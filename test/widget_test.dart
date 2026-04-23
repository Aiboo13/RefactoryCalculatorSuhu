// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:tugas_minggu_3_konvensi_suhu/main.dart';

void main() {
  testWidgets('Menampilkan komponen utama konversi suhu', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const KonversiSuhuApp());

    expect(find.text('Konversi Suhu'), findsOneWidget);
    expect(find.text('Masukkan Nilai Suhu'), findsOneWidget);
    expect(find.text('HITUNG'), findsOneWidget);
  });
}
