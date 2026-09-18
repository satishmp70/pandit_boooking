import 'package:shared_preferences/shared_preferences.dart';

import '../domain/entities/divya_session.dart';

abstract interface class SessionStore {
  Future<DivyaSession?> read();

  Future<void> write(DivyaSession session);

  Future<void> clear();
}

class MemorySessionStore implements SessionStore {
  DivyaSession? _session;

  @override
  Future<DivyaSession?> read() async => _session;

  @override
  Future<void> write(DivyaSession session) async => _session = session;

  @override
  Future<void> clear() async => _session = null;
}

class SharedPreferencesSessionStore implements SessionStore {
  static const _phoneKey = 'auth.phone';
  static const _verifiedKey = 'auth.verified';

  @override
  Future<DivyaSession?> read() async {
    final preferences = await SharedPreferences.getInstance();
    final phone = preferences.getString(_phoneKey);
    if (phone == null || preferences.getBool(_verifiedKey) != true) return null;
    return DivyaSession(phone: phone, verified: true);
  }

  @override
  Future<void> write(DivyaSession session) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_phoneKey, session.phone);
    await preferences.setBool(_verifiedKey, session.verified);
  }

  @override
  Future<void> clear() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.remove(_phoneKey);
    await preferences.remove(_verifiedKey);
  }
}
