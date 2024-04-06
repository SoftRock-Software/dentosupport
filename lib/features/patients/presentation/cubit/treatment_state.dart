part of 'treatment_cubit.dart';

enum TreatmentStatus {
  initial,
  success,
  failure;

  bool get isSuccess => this == TreatmentStatus.success;
  bool get hasError => this == TreatmentStatus.failure;
}

class TreatmentState extends Equatable {
  const TreatmentState({
    required this.title,
    this.status = TreatmentStatus.initial,
    this.suggestedTreatments = const [],
    this.errorMessage = '',
    this.tratmentCost = 0,
  });

  final TreatmentStatus status;
  final String title;
  final List<SuggestedTreatment> suggestedTreatments;
  final double tratmentCost;

  final String errorMessage;

  TreatmentState copyWith({
    TreatmentStatus? status,
    String? title,
    String? errorMessage,
    List<SuggestedTreatment>? suggestedTreatments,
    double? tratmentCost,
  }) {
    return TreatmentState(
      status: status ?? this.status,
      title: title ?? this.title,
      errorMessage: errorMessage ?? this.errorMessage,
      suggestedTreatments: suggestedTreatments ?? this.suggestedTreatments,
      tratmentCost: tratmentCost ?? this.tratmentCost,
    );
  }

  @override
  List<Object> get props =>
      [title, suggestedTreatments, status, errorMessage, tratmentCost];
}
