import 'package:equatable/equatable.dart';

class DivyaSession extends Equatable {
  const DivyaSession({required this.phone, required this.verified});

  final String phone;
  final bool verified;

  @override
  List<Object?> get props => [phone, verified];
}
