import 'package:flutter_test/flutter_test.dart';
import 'package:pulsefit_biometrics/telemetry/ring_buffer.dart';

void main() {
  group('BiometricRingBuffer Tests', () {
    test('Pushes and wraps around circular buffer without overflow', () {
      final buffer = BiometricRingBuffer(capacity: 3);
      buffer.push(10.0);
      buffer.push(20.0);
      buffer.push(30.0);
      buffer.push(40.0);

      expect(buffer.toList(), equals([20.0, 30.0, 40.0]));
      expect(buffer.toList().length, equals(3));
    });
  });
}