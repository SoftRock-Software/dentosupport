part of 'payment_cubit.dart';

enum PaymentStatus {
  initial,
  success,
  failure;

  bool get isSuccess => this == PaymentStatus.success;
  bool get hasError => this == PaymentStatus.failure;
}

class PaymentState extends Equatable {
  const PaymentState({
    this.status = PaymentStatus.initial,
    this.type = PaymentType.online,
    this.marked = false,
    this.onProcessTeeth = const [],
    this.selectedTeeth = const [],
    this.dates = const [],
    this.notes = '',
    this.amount = 0,
    this.errorMessage = '',
  });

  final PaymentStatus status;
  final PaymentType type;
  final bool marked;
  final List<String> onProcessTeeth;
  final List<String> selectedTeeth;
  final List<VisitorCalendar> dates;
  final String notes;
  final double amount;
  final String errorMessage;

  PaymentState copyWith({
    PaymentStatus? status,
    PaymentType? type,
    bool? marked,
    List<String>? onProcessTeeth,
    List<String>? selectedTeeth,
    List<VisitorCalendar>? dates,
    String? notes,
    double? amount,
    String? errorMessage,
  }) {
    return PaymentState(
      status: status ?? this.status,
      type: type ?? this.type,
      marked: marked ?? this.marked,
      onProcessTeeth: onProcessTeeth ?? this.onProcessTeeth,
      selectedTeeth: selectedTeeth ?? this.selectedTeeth,
      dates: dates ?? this.dates,
      notes: notes ?? this.notes,
      amount: amount ?? this.amount,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [
        status,
        type,
        marked,
        onProcessTeeth,
        selectedTeeth,
        dates,
        notes,
        amount,
        errorMessage
      ];
}
