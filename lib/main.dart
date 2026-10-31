import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'telemetry/ecg_custom_painter.dart';
import 'telemetry/ring_buffer.dart';

void main() {
  runApp(const ProviderScope(child: PulseFitApp()));
}

class PulseFitApp extends StatelessWidget {
  const PulseFitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PulseFit Biometrics',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF09090B),
      ),
      home: const BiometricsDashboard(),
    );
  }
}

class BiometricsDashboard extends StatefulWidget {
  const BiometricsDashboard({super.key});

  @override
  State<BiometricsDashboard> createState() => _BiometricsDashboardState();
}

class _BiometricsDashboardState extends State<BiometricsDashboard> {
  final BiometricRingBuffer _buffer = BiometricRingBuffer(capacity: 200);
  Timer? _timer;
  int _currentBpm = 72;

  @override
  void initState() {
    super.initState();
    _startSimulatedIngestion();
  }

  void _startSimulatedIngestion() {
    double t = 0;
    _timer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      t += 0.1;
      double val = math.sin(t) * 0.2;
      if ((t % (math.pi * 2)) < 0.3) {
        val += math.sin(t * 10) * 0.9;
      }
      _buffer.push(val);
      setState(() {
        _currentBpm = 70 + (math.sin(t * 0.2) * 6).toInt();
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PulseFit Biometrics (120 FPS)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF09090B),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('HEART RATE', style: TextStyle(color: Colors.white54, fontSize: 11, letterSpacing: 1.5)),
                    const SizedBox(height: 4),
                    Text('$_currentBpm BPM', style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF10B981))),
                  ],
                ),
                const Chip(
                  label: Text('BLE: 250 pkt/s', style: TextStyle(fontSize: 11, color: Color(0xFF10B981))),
                  backgroundColor: Color(0xFF18181B),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF18181B),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white12),
              ),
              child: CustomPaint(
                painter: EcgWaveformPainter(dataPoints: _buffer.toList()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}