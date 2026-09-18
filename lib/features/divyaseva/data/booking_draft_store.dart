import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../domain/entities/divyaseva_entities.dart';

abstract interface class BookingDraftStore {
  Future<BookingDraft?> read();

  Future<void> write(BookingDraft draft);

  Future<void> clear();
}

class MemoryBookingDraftStore implements BookingDraftStore {
  BookingDraft? _draft;

  @override
  Future<BookingDraft?> read() async => _draft;

  @override
  Future<void> write(BookingDraft draft) async => _draft = draft;

  @override
  Future<void> clear() async => _draft = null;
}

class SharedPreferencesBookingDraftStore implements BookingDraftStore {
  static const _key = 'booking.draft';

  @override
  Future<BookingDraft?> read() async {
    final preferences = await SharedPreferences.getInstance();
    final raw = preferences.getString(_key);
    if (raw == null) return null;
    final json = jsonDecode(raw) as Map<String, Object?>;
    return BookingDraft(
      serviceId: json['serviceId'] as String? ?? 'griha-pravesh',
      variantId: json['variantId'] as String? ?? 'std',
      samagriId: json['samagriId'] as String? ?? 'kit',
      date: json['date'] as String? ?? 'Sat 12 Sep',
      slot: json['slot'] as String? ?? '08:30 – 11:00',
      muhurat: json['muhurat'] as String? ?? 'Amrit Kaal',
      language: json['language'] as String? ?? 'Marathi',
      tradition: json['tradition'] as String? ?? 'Maharashtrian',
      people: json['people'] as String? ?? '8 – 12',
      panditName: json['panditName'] as String? ?? 'Suresh Joshi',
    );
  }

  @override
  Future<void> write(BookingDraft draft) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(
      _key,
      jsonEncode({
        'serviceId': draft.serviceId,
        'variantId': draft.variantId,
        'samagriId': draft.samagriId,
        'date': draft.date,
        'slot': draft.slot,
        'muhurat': draft.muhurat,
        'language': draft.language,
        'tradition': draft.tradition,
        'people': draft.people,
        'panditName': draft.panditName,
      }),
    );
  }

  @override
  Future<void> clear() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.remove(_key);
  }
}
