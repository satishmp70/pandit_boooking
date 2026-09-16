import 'package:equatable/equatable.dart';

class ServiceVariant extends Equatable {
  const ServiceVariant({
    required this.id,
    required this.name,
    required this.duration,
    required this.price,
    required this.includes,
  });

  final String id;
  final String name;
  final String duration;
  final int price;
  final String includes;

  @override
  List<Object?> get props => [id, name, duration, price, includes];
}

class SamagriOption extends Equatable {
  const SamagriOption({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
  });

  final String id;
  final String name;
  final String description;
  final int price;

  @override
  List<Object?> get props => [id, name, description, price];
}

class DivyaService extends Equatable {
  const DivyaService({
    required this.id,
    required this.name,
    required this.devanagari,
    required this.description,
    required this.fromPrice,
    required this.duration,
    required this.category,
    required this.variants,
    required this.panditsNearby,
    required this.rating,
    required this.completed,
    this.available = true,
  });

  final String id;
  final String name;
  final String devanagari;
  final String description;
  final int fromPrice;
  final String duration;
  final String category;
  final List<ServiceVariant> variants;
  final int panditsNearby;
  final double rating;
  final int completed;
  final bool available;

  @override
  List<Object?> get props => [id, name, fromPrice, category, available];
}

class Pandit extends Equatable {
  const Pandit({
    required this.initials,
    required this.name,
    required this.experience,
    required this.area,
    required this.distanceKm,
    required this.price,
    required this.languages,
    required this.onTime,
    required this.completed,
    required this.rating,
    required this.noShows,
    required this.reliability,
  });

  final String initials;
  final String name;
  final String experience;
  final String area;
  final double distanceKm;
  final int price;
  final String languages;
  final int onTime;
  final int completed;
  final double rating;
  final int noShows;
  final String reliability;

  @override
  List<Object?> get props => [name, price];
}

class MuhuratWindow extends Equatable {
  const MuhuratWindow({
    required this.name,
    required this.range,
    required this.availability,
    required this.recommended,
  });

  final String name;
  final String range;
  final String availability;
  final bool recommended;

  @override
  List<Object?> get props => [name, range, recommended];
}

class Quote extends Equatable {
  const Quote({
    required this.base,
    required this.samagri,
    required this.gst,
    required this.travel,
    required this.platform,
    required this.discount,
    required this.total,
  });

  final int base;
  final int samagri;
  final int gst;
  final int travel;
  final int platform;
  final int discount;
  final int total;

  @override
  List<Object?> get props => [base, samagri, gst, travel, platform, discount, total];
}

class BookingDraft extends Equatable {
  const BookingDraft({
    this.serviceId = 'griha-pravesh',
    this.variantId = 'std',
    this.samagriId = 'kit',
    this.date = 'Sat 12 Sep',
    this.slot = '08:30 \u2013 11:00',
    this.muhurat = 'Amrit Kaal',
    this.language = 'Marathi',
    this.tradition = 'Maharashtrian',
    this.people = '8 \u2013 12',
    this.panditName = 'Suresh Joshi',
  });

  final String serviceId;
  final String variantId;
  final String samagriId;
  final String date;
  final String slot;
  final String muhurat;
  final String language;
  final String tradition;
  final String people;
  final String panditName;

  BookingDraft copyWith({
    String? serviceId,
    String? variantId,
    String? samagriId,
    String? date,
    String? slot,
    String? muhurat,
    String? language,
    String? tradition,
    String? people,
    String? panditName,
  }) {
    return BookingDraft(
      serviceId: serviceId ?? this.serviceId,
      variantId: variantId ?? this.variantId,
      samagriId: samagriId ?? this.samagriId,
      date: date ?? this.date,
      slot: slot ?? this.slot,
      muhurat: muhurat ?? this.muhurat,
      language: language ?? this.language,
      tradition: tradition ?? this.tradition,
      people: people ?? this.people,
      panditName: panditName ?? this.panditName,
    );
  }

  @override
  List<Object?> get props => [
    serviceId,
    variantId,
    samagriId,
    date,
    slot,
    muhurat,
    language,
    tradition,
    people,
    panditName,
  ];
}

enum StepState { done, now, idle }

class BookingStep extends Equatable {
  const BookingStep({required this.title, required this.subtitle, required this.state});

  final String title;
  final String subtitle;
  final StepState state;

  @override
  List<Object?> get props => [title, subtitle, state];
}

class DivyaBooking extends Equatable {
  const DivyaBooking({
    required this.id,
    required this.service,
    required this.when,
    required this.pandit,
    required this.status,
    required this.pillTone,
  });

  final String id;
  final String service;
  final String when;
  final String pandit;
  final String status;
  final String pillTone;

  @override
  List<Object?> get props => [id, service, when, pandit, status];
}

class PrepItem extends Equatable {
  const PrepItem({required this.label, required this.done});

  final String label;
  final bool done;

  @override
  List<Object?> get props => [label, done];
}

class FamilyMember extends Equatable {
  const FamilyMember({
    required this.initials,
    required this.name,
    required this.role,
    required this.subtitle,
  });

  final String initials;
  final String name;
  final String role;
  final String subtitle;

  @override
  List<Object?> get props => [name, role];
}

class SupportCase extends Equatable {
  const SupportCase({
    required this.title,
    required this.reference,
    required this.status,
    required this.responseBy,
    required this.outcome,
  });

  final String title;
  final String reference;
  final String status;
  final String responseBy;
  final String outcome;

  @override
  List<Object?> get props => [title, reference];
}

class PartnerJob extends Equatable {
  const PartnerJob({
    required this.title,
    required this.detail,
    required this.badge,
    required this.badgeTone,
  });

  final String title;
  final String detail;
  final String badge;
  final String badgeTone;

  @override
  List<Object?> get props => [title, detail, badge];
}

class PartnerDashboard extends Equatable {
  const PartnerDashboard({
    required this.jobsToday,
    required this.weekEarnings,
    required this.onTime,
    required this.jobs,
  });

  final int jobsToday;
  final String weekEarnings;
  final int onTime;
  final List<PartnerJob> jobs;

  @override
  List<Object?> get props => [jobsToday, weekEarnings, onTime, jobs];
}
