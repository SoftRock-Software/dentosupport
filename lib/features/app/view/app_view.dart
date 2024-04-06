import 'package:dento_support/core/configs/colors.dart';
import 'package:dento_support/features/app/bloc/app_bloc.dart';
import 'package:dento_support/features/patients/presentation/bloc/patient_list_bloc.dart';
import 'package:dento_support/injector.dart';
import 'package:dento_support/routers/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DentoSupportApp extends StatelessWidget {
  const DentoSupportApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AppBloc()..add(const UpdateFcmToken())),
        BlocProvider(
          create: (_) => getIt<PatientListBloc>()
            ..add(const PatientsFetched())
            ..add(const UpdateVisitorCount()),
        ),
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
        child: child ?? const SizedBox(),
      ),
      theme: ThemeData(
        primaryColor: AppColor.primaryColor,
        scaffoldBackgroundColor: AppColor.backgroundColor,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          centerTitle: true,
          backgroundColor: AppColor.backgroundColor,
          foregroundColor: AppColor.textColor,
          titleTextStyle: TextStyle(
            fontFamily: AppFont.inter,
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: AppColor.textColor,
          ),
          iconTheme: IconThemeData(color: AppColor.primaryColor),
        ),
      ),
    );
  }
}
