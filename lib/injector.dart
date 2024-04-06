import 'package:dento_support/core/configs/enviornment.dart';
import 'package:dento_support/core/exceptions/app_response_exception.dart';
import 'package:dento_support/core/services/dio_client.dart';
import 'package:dento_support/core/services/local_storage_service.dart';
import 'package:dento_support/features/auth/data/data.dart';
import 'package:dento_support/features/auth/domain/domain.dart';
import 'package:dento_support/features/auth/presentation/bloc/phone_auth_bloc.dart';
import 'package:dento_support/features/patients/presentation/bloc/patient_bloc.dart';
import 'package:dento_support/features/patients/presentation/bloc/patient_list_bloc.dart';
import 'package:dento_support/features/patients/repository/patient_repository.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt getIt = GetIt.instance;

Future<void> initializeDependencies(Enviorment enviorment) async {
  final sharedPreferences = await SharedPreferences.getInstance();

  getIt
    ..registerSingleton<Enviorment>(enviorment)
    ..registerSingleton<Dio>(Dio())
    ..registerSingleton<DioClient>(
      DioClient(
        getIt<Dio>(),
        baseUrl: getIt<Enviorment>().baseUrl,
        exceptionMapper: <T>(Response<T> response, exception) {
          final data = response.data;
          if (data != null && data is Map<String, dynamic>) {
            // We only map responses that have json response data:
            return AppResponseException(
              message: data['message']?.toString() ?? 'Message key not found',
              exception: exception,
            );
          }
          return null;
        },
      ),
    )
    ..registerLazySingleton<LocalStorageService>(
      () => LocalStorageService(sharedPreferences),
    );

  _initAuthDependencies();
  _initPatientsDependencies();
}

void _initAuthDependencies() {
  // Register dataSources
  getIt
    ..registerLazySingleton<AuthRemoteDatasource>(
      () => AuthRemoteDatasourceImpl(getIt()),
    )
    // Register repositories
    ..registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(getIt()))
    // Register use cases
    ..registerLazySingleton(() => PostLogin(getIt()))
    ..registerLazySingleton(() => SendOtp(getIt()))
    ..registerLazySingleton(() => PostSignup(getIt()))
    ..registerLazySingleton(() => GetUser(getIt()))
    // Register bloc
    ..registerFactory(
      () => PhoneAuthBloc(
        postLogin: getIt(),
        sendOtp: getIt(),
        getUser: getIt(),
      ),
    );
}

void _initPatientsDependencies() {
  getIt
    ..registerLazySingleton(() => PatientRepository(getIt()))
    ..registerFactory(PatientListBloc.new)
    ..registerFactory(() => PatientBloc(patientRepository: getIt()));
}
