part of 'patient_bloc.dart';

enum PatientStatus {
  initial,
  success,
  failure;

  bool get hasError => this == PatientStatus.failure;
}

class PatientState extends Equatable {
  const PatientState({
    this.status = PatientStatus.initial,
    this.treatmets = const [],
    this.transactions = const [],
    this.receivedPayment = 0,
    this.pendingPayment = 0,
    this.totalPayment = 0,
    this.onProcessTeeth = const [],
    this.errorMessage = '',
    this.nextSchedule,
  });

  final PatientStatus status;
  final List<Treatment> treatmets;
  final List<Transaction> transactions;
  final int receivedPayment;
  final int pendingPayment;
  final int totalPayment;
  final List<String> onProcessTeeth;
  final NextSchedule? nextSchedule;

  final String errorMessage;

  PatientState copyWith({
    PatientStatus? status,
    List<Treatment>? treatmets,
    List<Transaction>? transactions,
    int? receivedPayment,
    int? pendingPayment,
    int? totalPayment,
    List<String>? onProcessTeeth,
    NextSchedule? nextSchedule,
    String? errorMessage,
  }) {
    return PatientState(
      status: status ?? this.status,
      treatmets: treatmets ?? this.treatmets,
      transactions: transactions ?? this.transactions,
      receivedPayment: receivedPayment ?? this.receivedPayment,
      pendingPayment: pendingPayment ?? this.pendingPayment,
      totalPayment: totalPayment ?? this.totalPayment,
      onProcessTeeth: onProcessTeeth ?? this.onProcessTeeth,
      nextSchedule: nextSchedule ?? this.nextSchedule,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  /// Record Payment button visible or hide
  bool get showRecordPayment {
    return treatmets.where((element) => element.status != 'Done').isNotEmpty;
  }

  @override
  List<Object?> get props => [
        status,
        treatmets,
        transactions,
        receivedPayment,
        pendingPayment,
        totalPayment,
        onProcessTeeth,
        nextSchedule,
        errorMessage
      ];
}
