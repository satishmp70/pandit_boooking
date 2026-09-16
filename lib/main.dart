import 'package:flutter/material.dart';

import 'app.dart';
import 'core/di/injection_container.dart' as di;

void main() {
  di.init();
  runApp(const DivyaSevaApp());
}
