import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/booking_draft_store.dart';
import '../../domain/entities/divyaseva_entities.dart';
import '../../domain/usecases/divyaseva_usecases.dart';
import 'booking_event.dart';
import 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc({
    required GetServices getServices,
    required GetVariants getVariants,
    required GetSamagriOptions getSamagriOptions,
    required GetMuhuratWindows getMuhuratWindows,
    required GetDateOptions getDateOptions,
    required GetStartTimes getStartTimes,
    required GetLanguages getLanguages,
    required GetTraditions getTraditions,
    required BuildQuote buildQuote,
    required BookingDraftStore draftStore,
  }) : _getServices = getServices,
       _getVariants = getVariants,
       _getSamagriOptions = getSamagriOptions,
       _getMuhuratWindows = getMuhuratWindows,
       _getDateOptions = getDateOptions,
       _getStartTimes = getStartTimes,
       _getLanguages = getLanguages,
       _getTraditions = getTraditions,
       _buildQuote = buildQuote,
       _draftStore = draftStore,
       super(const BookingState()) {
    on<BookingStarted>(_onStarted);
    on<BookingServiceSelected>(_onServiceSelected);
    on<BookingVariantSelected>(
      (e, emit) => _apply(emit, state.draft.copyWith(variantId: e.variantId)),
    );
    on<BookingSamagriSelected>(
      (e, emit) => _apply(emit, state.draft.copyWith(samagriId: e.samagriId)),
    );
    on<BookingDateSelected>(
      (e, emit) => _apply(emit, state.draft.copyWith(date: e.date)),
    );
    on<BookingSlotSelected>(
      (e, emit) => _apply(emit, state.draft.copyWith(slot: e.slot)),
    );
    on<BookingMuhuratSelected>(
      (e, emit) => _apply(emit, state.draft.copyWith(muhurat: e.muhurat)),
    );
    on<BookingLanguageSelected>(
      (e, emit) => _apply(emit, state.draft.copyWith(language: e.language)),
    );
    on<BookingTraditionSelected>(
      (e, emit) => _apply(emit, state.draft.copyWith(tradition: e.tradition)),
    );
    on<BookingPeopleChanged>(
      (e, emit) => _apply(emit, state.draft.copyWith(people: e.people)),
    );
    on<BookingPanditSelected>(
      (e, emit) => _apply(emit, state.draft.copyWith(panditName: e.panditName)),
    );
  }

  final GetServices _getServices;
  final GetVariants _getVariants;
  final GetSamagriOptions _getSamagriOptions;
  final GetMuhuratWindows _getMuhuratWindows;
  final GetDateOptions _getDateOptions;
  final GetStartTimes _getStartTimes;
  final GetLanguages _getLanguages;
  final GetTraditions _getTraditions;
  final BuildQuote _buildQuote;
  final BookingDraftStore _draftStore;

  Future<void> _onStarted(
    BookingStarted event,
    Emitter<BookingState> emit,
  ) async {
    emit(state.copyWith(status: BookingStatus.loading));
    try {
      final savedDraft = await _draftStore.read();
      if (savedDraft != null) emit(state.copyWith(draft: savedDraft));
      final services = await _getServices();
      final serviceId = services.any((s) => s.id == state.draft.serviceId)
          ? state.draft.serviceId
          : (services.isNotEmpty ? services.first.id : state.draft.serviceId);
      final variants = await _getVariants(serviceId);
      final samagri = await _getSamagriOptions();
      final muhurat = await _getMuhuratWindows();
      final dates = await _getDateOptions();
      final times = await _getStartTimes();
      final languages = await _getLanguages();
      final traditions = await _getTraditions();
      final next = state.copyWith(
        status: BookingStatus.ready,
        draft: state.draft.copyWith(serviceId: serviceId),
        services: services,
        variants: variants,
        samagriOptions: samagri,
        muhuratWindows: muhurat,
        dateOptions: dates,
        startTimes: times,
        languages: languages,
        traditions: traditions,
      );
      emit(
        next.copyWith(
          quote: _buildQuote(variant: next.variant, samagri: next.samagri),
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(status: BookingStatus.failure, error: error.toString()),
      );
    }
  }

  Future<void> _onServiceSelected(
    BookingServiceSelected event,
    Emitter<BookingState> emit,
  ) async {
    final draft = state.draft.copyWith(
      serviceId: event.serviceId,
      variantId: 'std',
    );
    try {
      final variants = await _getVariants(event.serviceId);
      final next = state.copyWith(draft: draft, variants: variants);
      emit(
        next.copyWith(
          quote: _buildQuote(variant: next.variant, samagri: next.samagri),
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(status: BookingStatus.failure, error: error.toString()),
      );
    }
  }

  void _apply(Emitter<BookingState> emit, BookingDraft draft) {
    final next = state.copyWith(draft: draft);
    emit(
      next.copyWith(
        quote: _buildQuote(variant: next.variant, samagri: next.samagri),
      ),
    );
    unawaited(_draftStore.write(draft));
  }
}
