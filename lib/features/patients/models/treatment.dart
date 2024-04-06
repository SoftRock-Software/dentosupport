import 'package:dento_support/core/extensions/list_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'treatment.g.dart';

@JsonSerializable()
class Treatment extends Equatable {
  const Treatment({
    required this.toothNumber,
    required this.id,
    required this.name,
    required this.amount,
    required this.status,
    required this.patientId,
    required this.clinicId,
    required this.createdAt,
  });

  factory Treatment.fromJson(Map<String, dynamic> json) =>
      _$TreatmentFromJson(json);

  final List<String> toothNumber;
  final int id;
  final String name;
  final int amount;
  final String status;
  final int patientId;
  final int clinicId;
  final DateTime createdAt;

  String get tooths => getToothList(toothNumber)
      .join(', ')
      .replaceAll('Upper', 'Upper arch')
      .replaceAll('Lower', 'Lower arch');

  @override
  List<Object?> get props => [
        toothNumber,
        id,
        name,
        amount,
        status,
        patientId,
        clinicId,
        createdAt,
      ];
}

List<String> getToothList(List<String> toothNumber) {
  final ur = ['11', '12', '13', '14', '15', '16', '17', '18'];
  final ul = ['21', '22', '23', '24', '25', '26', '27', '28'];
  final ll = ['31', '32', '33', '34', '35', '36', '37', '38'];
  final lr = ['41', '42', '43', '44', '45', '46', '47', '48'];

  final result = <String>[];
  final selectedTeeth = toothNumber.map((e) => e.trim()).toSet();

  final containsUR = selectedTeeth.containsAll(ur.toSet());
  final containsUL = selectedTeeth.containsAll(ul.toSet());
  if (containsUR && containsUL) {
    result.add('Upper');
    selectedTeeth
      ..removeAll(ur.toSet())
      ..removeAll(ul.toSet());
  }

  final containsLR = selectedTeeth.containsAll(lr.toSet());
  final containsLL = selectedTeeth.containsAll(ll.toSet());
  if (containsLR && containsLL) {
    result.add('Lower');
    selectedTeeth
      ..removeAll(lr.toSet())
      ..removeAll(ll.toSet());
  }

  final sortedTeeth = selectedTeeth
      .toList()
      .sorted((a, b) => int.parse(a).compareTo(int.parse(b)));
  result.addAll(sortedTeeth);

  return result;
}
