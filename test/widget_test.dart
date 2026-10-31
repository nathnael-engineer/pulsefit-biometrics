import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pulsefit_biometrics/main.dart';

void main() {
  testWidgets('Renders cardiogram dashboard', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: PulseFitApp()));
    await tester.pumpAndSettle();

    expect(find.text('PulseFit Biometrics (120 FPS)'), findsOneWidget);
    expect(find.text('HEART RATE'), findsOneWidget);
    expect(find.text('BLE: 250 pkt/s'), findsOneWidget);
  });
}