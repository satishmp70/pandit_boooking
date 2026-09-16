import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/divyaseva_entities.dart';
import '../../domain/usecases/divyaseva_usecases.dart';
import 'async_status.dart';

class AccountState extends Equatable {
  const AccountState({
    this.status = AsyncStatus.initial,
    this.members = const [],
    this.supportCase,
    this.topics = const [],
    this.error,
  });

  final AsyncStatus status;
  final List<FamilyMember> members;
  final SupportCase? supportCase;
  final List<String> topics;
  final String? error;

  AccountState copyWith({
    AsyncStatus? status,
    List<FamilyMember>? members,
    SupportCase? supportCase,
    List<String>? topics,
    String? error,
  }) {
    return AccountState(
      status: status ?? this.status,
      members: members ?? this.members,
      supportCase: supportCase ?? this.supportCase,
      topics: topics ?? this.topics,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, members, supportCase, topics, error];
}

class AccountCubit extends Cubit<AccountState> {
  AccountCubit({
    required GetFamilyMembers getFamilyMembers,
    required GetSupportCase getSupportCase,
    required GetSupportTopics getSupportTopics,
  }) : _getFamilyMembers = getFamilyMembers,
       _getSupportCase = getSupportCase,
       _getSupportTopics = getSupportTopics,
       super(const AccountState()) {
    load();
  }

  final GetFamilyMembers _getFamilyMembers;
  final GetSupportCase _getSupportCase;
  final GetSupportTopics _getSupportTopics;

  Future<void> load() async {
    emit(state.copyWith(status: AsyncStatus.loading));
    try {
      final members = await _getFamilyMembers();
      final supportCase = await _getSupportCase();
      final topics = await _getSupportTopics();
      emit(
        state.copyWith(
          status: AsyncStatus.success,
          members: members,
          supportCase: supportCase,
          topics: topics,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: AsyncStatus.failure, error: error.toString()));
    }
  }
}
