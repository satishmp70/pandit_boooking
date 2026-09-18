import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/divyaseva_entities.dart';
import '../../domain/usecases/divyaseva_usecases.dart';
import 'async_status.dart';

class BookingDetailState extends Equatable {
  const BookingDetailState({
    this.status = AsyncStatus.initial,
    this.steps = const [],
    this.checklist = const [],
    this.error,
  });

  final AsyncStatus status;
  final List<BookingStep> steps;
  final List<PrepItem> checklist;
  final String? error;

  int get readyCount => checklist.where((item) => item.done).length;

  BookingDetailState copyWith({
    AsyncStatus? status,
    List<BookingStep>? steps,
    List<PrepItem>? checklist,
    String? error,
  }) {
    return BookingDetailState(
      status: status ?? this.status,
      steps: steps ?? this.steps,
      checklist: checklist ?? this.checklist,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, steps, checklist, error];
}

class BookingDetailCubit extends Cubit<BookingDetailState> {
  BookingDetailCubit({
    required GetBookingSteps getBookingSteps,
    required GetPreparationChecklist getPreparationChecklist,
  }) : _getBookingSteps = getBookingSteps,
       _getPreparationChecklist = getPreparationChecklist,
       super(const BookingDetailState()) {
    load();
  }

  final GetBookingSteps _getBookingSteps;
  final GetPreparationChecklist _getPreparationChecklist;

  Future<void> load() async {
    emit(state.copyWith(status: AsyncStatus.loading));
    try {
      final steps = await _getBookingSteps();
      final checklist = await _getPreparationChecklist();
      emit(
        state.copyWith(
          status: AsyncStatus.success,
          steps: steps,
          checklist: checklist,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(status: AsyncStatus.failure, error: error.toString()),
      );
    }
  }

  void toggleChecklistItem(int index) {
    if (index < 0 || index >= state.checklist.length) return;
    final updated = [...state.checklist];
    updated[index] = PrepItem(
      label: updated[index].label,
      done: !updated[index].done,
    );
    emit(state.copyWith(checklist: updated));
  }
}
