import 'package:dento_support/core/constants/end_point.dart';
import 'package:dento_support/core/services/dio_client.dart';
import 'package:dento_support/features/clinic/models/clinic_params.dart';
import 'package:dento_support/features/clinic/models/clinic_response.dart';

class ClinicRepository {
  const ClinicRepository(this._client);

  final DioClient _client;

  Future<ClinicResponse> getAllClinic() async {
    try {
      final response = await _client.get(EndPoint.clinic);
      return ClinicResponse.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addClinic(ClinicParams params) async {
    try {
      await _client.post<Map<String, dynamic>>(
        EndPoint.clinic,
        data: params.toJson(),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateClinic(ClinicParams params, String id) async {
    try {
      await _client.patch('${EndPoint.clinic}/$id', data: params.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteClinic(String id) async {
    try {
      await _client.delete<Map<String, dynamic>>('${EndPoint.clinic}/$id');
    } catch (e) {
      rethrow;
    }
  }
}
