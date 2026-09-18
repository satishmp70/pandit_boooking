import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'app.dart';
import 'core/di/injection_container.dart' as di;

void main() {
  di.init();
  usePathUrlStrategy();
  runApp(const DivyaSevaApp());
}
