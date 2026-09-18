import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'app.dart';
import 'core/di/injection_container.dart' as di;
import 'features/auth/data/session_store.dart';
import 'features/divyaseva/data/booking_draft_store.dart';

void main() {
  di.init(
    sessionStore: SharedPreferencesSessionStore(),
    draftStore: SharedPreferencesBookingDraftStore(),
  );
  usePathUrlStrategy();
  runApp(const DivyaSevaApp());
}
