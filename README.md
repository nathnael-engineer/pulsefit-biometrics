# PulseFit Biometrics 🫀

120FPS Continuous Cardiogram Rendering with Bluetooth LE GATT Telemetry.

## Architecture

- **Rendering**: CustomPainter GPU Skia / Impeller pipeline running at solid 120 FPS.
- **Buffer**: Zero-allocation circular ring buffer for 250 pkt/s biometric ingestion.
- **Backend**: FastAPI WebSocket server streaming timeseries data to TimescaleDB.

## Running Tests

```bash
# Unit & Widget tests
flutter test

# Integration test
flutter test integration_test/cardiogram_stream_test.dart
```

## Building Native Release APK

```bash
flutter pub get
flutter build apk --release
```
