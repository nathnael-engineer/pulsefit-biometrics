import 'dart:typed_data';

class BiometricRingBuffer {
  final Float64List _buffer;
  final int capacity;
  int _head = 0;
  int _count = 0;

  BiometricRingBuffer({this.capacity = 500}) : _buffer = Float64List(capacity);

  void push(double value) {
    _buffer[_head] = value;
    _head = (_head + 1) % capacity;
    if (_count < capacity) _count++;
  }

  List<double> toList() {
    final result = <double>[];
    for (int i = 0; i < _count; i++) {
      final idx = (_head - _count + i + capacity) % capacity;
      result.add(_buffer[idx]);
    }
    return result;
  }
}