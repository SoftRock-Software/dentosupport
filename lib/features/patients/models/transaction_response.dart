import 'package:dento_support/features/patients/models/transaction.dart';
import 'package:json_annotation/json_annotation.dart';

part 'transaction_response.g.dart';

@JsonSerializable()
class TransactionResponse {
  const TransactionResponse({
    required this.status,
    required this.data,
  });

  factory TransactionResponse.fromJson(Map<String, dynamic> json) =>
      _$TransactionResponseFromJson(json);

  final String status;
  final List<Transaction> data;
}
