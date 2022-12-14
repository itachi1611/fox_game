import 'package:flutter/material.dart';

@immutable
class MVector {
  final int x;
  final int y;

  const MVector(this.x, this.y);

  static const zero = MVector(0, 0);

  MVector operator +(MVector other) => MVector(x + other.x, y + other.y);

  MVector operator -(MVector other) => MVector(x - other.x, y - other.y);

  MVector operator *(MVector other) => MVector(x * other.x, y * other.y);

  bool operator <(MVector other) => x < other.x || y < other.y;

  bool operator >=(MVector other) => x >= other.x || y >= other.y;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is MVector && x == other.x && y == other.y;
  }

  @override
  int get hashCode => Object.hash(x, y);

  @override
  String toString() => '$x,$y';
}
