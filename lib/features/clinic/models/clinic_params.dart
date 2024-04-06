class ClinicParams {
  const ClinicParams({
    required this.name,
    required this.mobile,
    required this.location,
    required this.dayOff,
  });

  final String name;
  final String mobile;
  final String location;
  final String dayOff;

  Map<String, dynamic> toJson() => {
        'name': name,
        'mobile': mobile,
        'location': location,
        'dayOff': dayOff,
      };
}
