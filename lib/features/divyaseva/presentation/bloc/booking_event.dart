import 'package:equatable/equatable.dart';

sealed class BookingEvent extends Equatable {
  const BookingEvent();

  @override
  List<Object?> get props => [];
}

class BookingStarted extends BookingEvent {
  const BookingStarted();
}

class BookingServiceSelected extends BookingEvent {
  const BookingServiceSelected(this.serviceId);

  final String serviceId;

  @override
  List<Object?> get props => [serviceId];
}

class BookingVariantSelected extends BookingEvent {
  const BookingVariantSelected(this.variantId);

  final String variantId;

  @override
  List<Object?> get props => [variantId];
}

class BookingSamagriSelected extends BookingEvent {
  const BookingSamagriSelected(this.samagriId);

  final String samagriId;

  @override
  List<Object?> get props => [samagriId];
}

class BookingDateSelected extends BookingEvent {
  const BookingDateSelected(this.date);

  final String date;

  @override
  List<Object?> get props => [date];
}

class BookingSlotSelected extends BookingEvent {
  const BookingSlotSelected(this.slot);

  final String slot;

  @override
  List<Object?> get props => [slot];
}

class BookingMuhuratSelected extends BookingEvent {
  const BookingMuhuratSelected(this.muhurat);

  final String muhurat;

  @override
  List<Object?> get props => [muhurat];
}

class BookingLanguageSelected extends BookingEvent {
  const BookingLanguageSelected(this.language);

  final String language;

  @override
  List<Object?> get props => [language];
}

class BookingTraditionSelected extends BookingEvent {
  const BookingTraditionSelected(this.tradition);

  final String tradition;

  @override
  List<Object?> get props => [tradition];
}

class BookingPeopleChanged extends BookingEvent {
  const BookingPeopleChanged(this.people);

  final String people;

  @override
  List<Object?> get props => [people];
}

class BookingPanditSelected extends BookingEvent {
  const BookingPanditSelected(this.panditName);

  final String panditName;

  @override
  List<Object?> get props => [panditName];
}
