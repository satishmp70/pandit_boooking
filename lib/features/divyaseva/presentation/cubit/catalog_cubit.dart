import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/divyaseva_entities.dart';
import '../../domain/usecases/divyaseva_usecases.dart';
import 'async_status.dart';

class CatalogState extends Equatable {
  const CatalogState({
    this.status = AsyncStatus.initial,
    this.services = const [],
    this.category = 'Home & property',
    this.error,
  });

  final AsyncStatus status;
  final List<DivyaService> services;
  final String category;
  final String? error;

  List<DivyaService> get visible =>
      services.where((service) => service.category == category).toList();

  CatalogState copyWith({
    AsyncStatus? status,
    List<DivyaService>? services,
    String? category,
    String? error,
  }) {
    return CatalogState(
      status: status ?? this.status,
      services: services ?? this.services,
      category: category ?? this.category,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, services, category, error];
}

class CatalogCubit extends Cubit<CatalogState> {
  CatalogCubit({required GetServices getServices})
    : _getServices = getServices,
      super(const CatalogState()) {
    load();
  }

  final GetServices _getServices;

  Future<void> load() async {
    emit(state.copyWith(status: AsyncStatus.loading));
    try {
      final services = await _getServices();
      emit(state.copyWith(status: AsyncStatus.success, services: services));
    } catch (error) {
      emit(state.copyWith(status: AsyncStatus.failure, error: error.toString()));
    }
  }

  void selectCategory(String category) => emit(state.copyWith(category: category));
}
