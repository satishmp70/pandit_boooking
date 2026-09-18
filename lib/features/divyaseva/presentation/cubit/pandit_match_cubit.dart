import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/divyaseva_entities.dart';
import '../../domain/usecases/divyaseva_usecases.dart';
import 'async_status.dart';

class PanditMatchState extends Equatable {
  const PanditMatchState({
    this.status = AsyncStatus.initial,
    this.pandits = const [],
    this.error,
  });

  final AsyncStatus status;
  final List<Pandit> pandits;
  final String? error;

  PanditMatchState copyWith({
    AsyncStatus? status,
    List<Pandit>? pandits,
    String? error,
  }) {
    return PanditMatchState(
      status: status ?? this.status,
      pandits: pandits ?? this.pandits,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, pandits, error];
}

class PanditMatchCubit extends Cubit<PanditMatchState> {
  PanditMatchCubit({required GetMatchedPandits getMatchedPandits})
    : _getMatchedPandits = getMatchedPandits,
      super(const PanditMatchState());

  final GetMatchedPandits _getMatchedPandits;

  Future<void> findPandits() async {
    emit(state.copyWith(status: AsyncStatus.loading));
    try {
      final pandits = await _getMatchedPandits();
      emit(state.copyWith(status: AsyncStatus.success, pandits: pandits));
    } catch (error) {
      emit(
        state.copyWith(status: AsyncStatus.failure, error: error.toString()),
      );
    }
  }
}
