import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/divyaseva_entities.dart';
import '../../domain/usecases/divyaseva_usecases.dart';
import 'async_status.dart';

class PartnerState extends Equatable {
  const PartnerState({
    this.status = AsyncStatus.initial,
    this.dashboard,
    this.error,
  });

  final AsyncStatus status;
  final PartnerDashboard? dashboard;
  final String? error;

  PartnerState copyWith({
    AsyncStatus? status,
    PartnerDashboard? dashboard,
    String? error,
  }) {
    return PartnerState(
      status: status ?? this.status,
      dashboard: dashboard ?? this.dashboard,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, dashboard, error];
}

class PartnerCubit extends Cubit<PartnerState> {
  PartnerCubit({required GetPartnerDashboard getPartnerDashboard})
    : _getPartnerDashboard = getPartnerDashboard,
      super(const PartnerState()) {
    load();
  }

  final GetPartnerDashboard _getPartnerDashboard;

  Future<void> load() async {
    emit(state.copyWith(status: AsyncStatus.loading));
    try {
      final dashboard = await _getPartnerDashboard();
      emit(state.copyWith(status: AsyncStatus.success, dashboard: dashboard));
    } catch (error) {
      emit(
        state.copyWith(status: AsyncStatus.failure, error: error.toString()),
      );
    }
  }
}
