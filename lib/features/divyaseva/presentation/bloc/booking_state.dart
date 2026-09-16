import 'package:equatable/equatable.dart';

import '../../domain/entities/divyaseva_entities.dart';

enum BookingStatus { initial, loading, ready, failure }

class BookingState extends Equatable {
  const BookingState({
    this.status = BookingStatus.initial,
    this.draft = const BookingDraft(),
    this.services = const [],
    this.variants = const [],
    this.samagriOptions = const [],
    this.muhuratWindows = const [],
    this.dateOptions = const [],
    this.startTimes = const [],
    this.languages = const [],
    this.traditions = const [],
    this.quote = const Quote(
      base: 0,
      samagri: 0,
      gst: 0,
      travel: 0,
      platform: 149,
      discount: 500,
      total: 0,
    ),
    this.error,
  });

  final BookingStatus status;
  final BookingDraft draft;
  final List<DivyaService> services;
  final List<ServiceVariant> variants;
  final List<SamagriOption> samagriOptions;
  final List<MuhuratWindow> muhuratWindows;
  final List<String> dateOptions;
  final List<String> startTimes;
  final List<String> languages;
  final List<String> traditions;
  final Quote quote;
  final String? error;

  static const _fallbackVariant = ServiceVariant(
    id: '',
    name: 'Standard',
    duration: '',
    price: 0,
    includes: '',
  );

  static const _fallbackSamagri = SamagriOption(
    id: '',
    name: '',
    description: '',
    price: 0,
  );

  DivyaService? get selectedService {
    if (services.isEmpty) return null;
    return services.firstWhere(
      (s) => s.id == draft.serviceId,
      orElse: () => services.first,
    );
  }

  ServiceVariant get variant {
    if (variants.isEmpty) return _fallbackVariant;
    return variants.firstWhere(
      (v) => v.id == draft.variantId,
      orElse: () => variants.first,
    );
  }

  SamagriOption get samagri {
    if (samagriOptions.isEmpty) return _fallbackSamagri;
    return samagriOptions.firstWhere(
      (s) => s.id == draft.samagriId,
      orElse: () => samagriOptions.length > 1 ? samagriOptions[1] : samagriOptions.first,
    );
  }

  BookingState copyWith({
    BookingStatus? status,
    BookingDraft? draft,
    List<DivyaService>? services,
    List<ServiceVariant>? variants,
    List<SamagriOption>? samagriOptions,
    List<MuhuratWindow>? muhuratWindows,
    List<String>? dateOptions,
    List<String>? startTimes,
    List<String>? languages,
    List<String>? traditions,
    Quote? quote,
    String? error,
  }) {
    return BookingState(
      status: status ?? this.status,
      draft: draft ?? this.draft,
      services: services ?? this.services,
      variants: variants ?? this.variants,
      samagriOptions: samagriOptions ?? this.samagriOptions,
      muhuratWindows: muhuratWindows ?? this.muhuratWindows,
      dateOptions: dateOptions ?? this.dateOptions,
      startTimes: startTimes ?? this.startTimes,
      languages: languages ?? this.languages,
      traditions: traditions ?? this.traditions,
      quote: quote ?? this.quote,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
    status,
    draft,
    services,
    variants,
    samagriOptions,
    muhuratWindows,
    dateOptions,
    startTimes,
    languages,
    traditions,
    quote,
    error,
  ];
}
