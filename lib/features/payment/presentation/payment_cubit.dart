import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/payment_repository.dart';

enum PaymentFlowStatus { idle, processing, success, failure }

class PaymentState {
  const PaymentState({this.status = PaymentFlowStatus.idle, this.message});

  final PaymentFlowStatus status;
  final String? message;
}

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit(this._repository) : super(const PaymentState());

  final PaymentRepository _repository;
  bool _submitted = false;

  Future<bool> pay({
    required int amount,
    required String method,
    required String reference,
  }) async {
    if (_submitted) return false;
    _submitted = true;
    emit(const PaymentState(status: PaymentFlowStatus.processing));
    try {
      final result = await _repository.createPayment(
        PaymentRequest(amount: amount, method: method, reference: reference),
      );
      if (result.status != PaymentStatus.success || result.paymentId == null) {
        emit(
          PaymentState(
            status: PaymentFlowStatus.failure,
            message: result.message ?? 'Payment was not completed.',
          ),
        );
        _submitted = false;
        return false;
      }
      final verified = await _repository.verifyPayment(result.paymentId!);
      if (verified.status != PaymentStatus.success) {
        emit(
          PaymentState(
            status: PaymentFlowStatus.failure,
            message: verified.message ?? 'Payment could not be verified.',
          ),
        );
        _submitted = false;
        return false;
      }
      emit(const PaymentState(status: PaymentFlowStatus.success));
      return true;
    } catch (_) {
      emit(
        const PaymentState(
          status: PaymentFlowStatus.failure,
          message: 'Payment service is unavailable. Try again.',
        ),
      );
      _submitted = false;
      return false;
    }
  }
}
