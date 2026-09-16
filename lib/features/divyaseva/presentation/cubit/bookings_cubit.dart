import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/divyaseva_entities.dart';
import '../../domain/usecases/divyaseva_usecases.dart';
import 'async_status.dart';

class BookingsState extends Equatable {
  const BookingsState({
    this.status = AsyncStatus.initial,
    this.bookings = const [],
    this.filter = 'Upcoming',
    this.selectedId,
    this.error,
  });

  final AsyncStatus status;
  final List<DivyaBooking> bookings;
  final String filter;
  final String? selectedId;
  final String? error;

  DivyaBooking? get selected {
    if (bookings.isEmpty) return null;
    if (selectedId == null) return bookings.first;
    return bookings.firstWhere(
      (booking) => booking.id == selectedId,
      orElse: () => bookings.first,
    );
  }

  BookingsState copyWith({
    AsyncStatus? status,
    List<DivyaBooking>? bookings,
    String? filter,
    String? selectedId,
    String? error,
  }) {
    return BookingsState(
      status: status ?? this.status,
      bookings: bookings ?? this.bookings,
      filter: filter ?? this.filter,
      selectedId: selectedId ?? this.selectedId,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, bookings, filter, selectedId, error];
}

class BookingsCubit extends Cubit<BookingsState> {
  BookingsCubit({required GetBookings getBookings})
    : _getBookings = getBookings,
      super(const BookingsState()) {
    load();
  }

  final GetBookings _getBookings;

  Future<void> load() async {
    emit(state.copyWith(status: AsyncStatus.loading));
    try {
      final bookings = await _getBookings();
      emit(state.copyWith(status: AsyncStatus.success, bookings: bookings));
    } catch (error) {
      emit(state.copyWith(status: AsyncStatus.failure, error: error.toString()));
    }
  }

  void selectFilter(String filter) => emit(state.copyWith(filter: filter));

  void select(String bookingId) => emit(state.copyWith(selectedId: bookingId));
}
