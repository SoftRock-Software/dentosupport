part of 'patient_list_bloc.dart';

enum PatientListStatus {
  initial,
  success,
  delete,
  failure;

  bool get isSuccess => this == PatientListStatus.success;
  bool get isDelete => this == PatientListStatus.delete;
  bool get hasError => this == PatientListStatus.failure;
}

class PatientListState extends Equatable {
  const PatientListState({
    this.status = PatientListStatus.initial,
    this.patients = const [],
    this.totalAmount = 0,
    this.cashAmount = 0,
    this.visited = 0,
    this.pendingVisitor = 0,
    this.dates = const [],
    this.date,
    this.errorMessage = '',
  });

  final PatientListStatus status;
  final List<Row> patients;
  final int totalAmount;
  final int cashAmount;
  final int visited;
  final List<VisitorCalendar> dates;
  final DateTime? date;
  final int pendingVisitor;

  final String errorMessage;

  String get dateString => (date ?? DateTime.now()).dateString;

  bool get showFuture => (date ?? DateTime.now()).isAfter(DateTime.now());
  int get futurePatients => pendingVisitor + visited;

  bool get isTodayAndEmpty =>
      (date ?? DateTime.now()).isToday && patients.isEmpty;

  PatientListState copyWith({
    PatientListStatus? status,
    List<Row>? patients,
    int? totalAmount,
    int? cashAmount,
    int? visited,
    int? pendingVisitor,
    List<VisitorCalendar>? dates,
    DateTime? date,
    String? errorMessage,
  }) {
    return PatientListState(
      status: status ?? this.status,
      patients: patients ?? this.patients,
      totalAmount: totalAmount ?? this.totalAmount,
      cashAmount: cashAmount ?? this.cashAmount,
      visited: visited ?? this.visited,
      pendingVisitor: pendingVisitor ?? this.pendingVisitor,
      dates: dates ?? this.dates,
      date: date ?? this.date,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        patients,
        totalAmount,
        cashAmount,
        dates,
        visited,
        errorMessage,
        date,
      ];
}
