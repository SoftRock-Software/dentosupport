import 'package:dento_support/features/auth/domain/domain.dart';
import 'package:dento_support/features/auth/presentation/bloc/phone_auth_bloc.dart';
import 'package:dento_support/features/auth/presentation/cubit/signup_cubit.dart';
import 'package:dento_support/features/auth/presentation/cubit/user_cubit.dart';
import 'package:dento_support/features/auth/presentation/views/edit_profile_page.dart';
import 'package:dento_support/features/auth/presentation/views/signin_page.dart';
import 'package:dento_support/features/auth/presentation/views/signup_first_page.dart';
import 'package:dento_support/features/auth/presentation/views/signup_second_page.dart';
import 'package:dento_support/features/clinic/cubit/clinic_cubit.dart';
import 'package:dento_support/features/clinic/views/manage_clinics_page.dart';
import 'package:dento_support/features/patients/models/patient.dart';
import 'package:dento_support/features/patients/presentation/bloc/patient_bloc.dart';
import 'package:dento_support/features/patients/presentation/views/add_patient_page.dart';
import 'package:dento_support/features/patients/presentation/views/home_page.dart';
import 'package:dento_support/features/patients/presentation/views/patient_page.dart';
import 'package:dento_support/features/payments/views/payment_page.dart';
import 'package:dento_support/features/payments/views/subscription_plan_page.dart';
import 'package:dento_support/features/settings/views/settings_page.dart';
import 'package:dento_support/features/splash/splash_page.dart';
import 'package:dento_support/injector.dart';
import 'package:dento_support/routers/route_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

part 'router.g.dart';

final router = GoRouter(
  initialLocation: AppPage.splash.toPath,
  routes: [
    GoRoute(
      path: AppPage.splash.toPath,
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: AppPage.signin.toPath,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: BlocProvider(
          create: (context) => getIt<PhoneAuthBloc>(),
          child: const SignInPage(),
        ),
        transitionsBuilder: (_, animation, __, child) =>
            FadeTransition(opacity: animation, child: child),
      ),
    ),
    GoRoute(
      path: AppPage.signupFirst.toPath,
      builder: (context, state) =>
          SignUpFirstPage(mobile: state.extra! as String),
    ),
    GoRoute(
      path: AppPage.signupSecond.toPath,
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => ClinicCubit()),
          BlocProvider(create: (_) => SignupCubit(postSignup: getIt()))
        ],
        child: SignUpSecondPage(params: state.extra! as RegisterParams),
      ),
    ),
    GoRoute(
      path: AppPage.editProfile.toPath,
      builder: (context, state) => BlocProvider(
        create: (context) => UserCubit(),
        child: const EditProfilePage(),
      ),
    ),
    GoRoute(
      path: AppPage.home.toPath,
      pageBuilder: (_, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const HomePage(),
        transitionsBuilder: (_, animation, __, child) =>
            FadeTransition(opacity: animation, child: child),
      ),
    ),
    GoRoute(
      path: AppPage.patient.toPath,
      builder: (_, state) {
        final patient = state.extra! as PatientExtraNew;
        return BlocProvider(
          create: (context) =>
              getIt<PatientBloc>()..add(FetchPatient(patient.patient.id)),
          child: PatientPage(
            patient.patient,
            fromAddPatient: patient.fromAddPatient,
          ),
        );
      },
    ),
    GoRoute(
      path: AppPage.settings.toPath,
      builder: (context, state) => const SettingsPage(),
    ),
    GoRoute(
      path: AppPage.payments.toPath,
      builder: (context, state) => const PaymentPage(),
    ),
    GoRoute(
      path: AppPage.subscriptionPlan.toPath,
      builder: (context, state) => const SubscriptionPlanPage(),
    ),
    GoRoute(
      path: AppPage.manageClinics.toPath,
      builder: (context, state) => const ManageClinicsPage(),
    ),
    GoRoute(
      path: AppPage.addPatient.toPath,
      pageBuilder: (_, state) {
        final patientExtra = state.extra! as PatientExtra;

        return CustomTransitionPage(
          key: state.pageKey,
          fullscreenDialog: true,
          child: AddPatientPage(
            name: patientExtra.name,
            patient: patientExtra.patient,
          ),
          transitionsBuilder: (_, animation, __, child) {
            const begin = Offset(0, 1);
            const end = Offset.zero;
            const curve = Curves.ease;

            final tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
      },
    ),
  ],
);

@TypedGoRoute<HomeRoute>(path: '/home')
class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const HomePage();
}

class PatientExtra {
  const PatientExtra({required this.name, this.patient});

  final String name;
  final Patient? patient;
}

class PatientExtraNew {
  PatientExtraNew({required this.patient, this.fromAddPatient = false});

  final Patient patient;
  final bool fromAddPatient;
}
