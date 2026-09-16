import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/divyaseva_entities.dart';
import '../../domain/usecases/divyaseva_usecases.dart';
import 'async_status.dart';

class TrackingState extends Equatable {
  const TrackingState({
    this.status = AsyncStatus.initial,
    this.steps = const [],
    this.error,
  });

  final AsyncStatus status;
  final List<BookingStep> steps;
  final String? error;

  TrackingState copyWith({
    AsyncStatus? status,
    List<BookingStep>? steps,
    String? error,
  }) {
    return TrackingState(
      status: status ?? this.status,
      steps: steps ?? this.steps,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, steps, error];
}

class TrackingCubit extends Cubit<TrackingState> {
  TrackingCubit({required GetTrackingSteps getTrackingSteps})
    : _getTrackingSteps = getTrackingSteps,
      super(const TrackingState()) {
    load();
  }

  final GetTrackingSteps _getTrackingSteps;

  Future<void> load() async {
    emit(state.copyWith(status: AsyncStatus.loading));
    try {
      final steps = await _getTrackingSteps();
      emit(state.copyWith(status: AsyncStatus.success, steps: steps));
    } catch (error) {
      emit(state.copyWith(status: AsyncStatus.failure, error: error.toString()));
    }
  }
}
