import 'dart:math';

import 'package:flutter/material.dart';

Color getRandomColor() {
  final random = Random();
  final colorIndex = random.nextInt(Colors.primaries.length);
  return Colors.primaries[colorIndex];
}
