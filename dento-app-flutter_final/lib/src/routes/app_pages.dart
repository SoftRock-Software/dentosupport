import 'package:Dentosupport_mini/src/view/phonelogin/binding/phone_login_binding.dart';
import 'package:Dentosupport_mini/src/view/phonelogin/view/phone_login_screen.dart';
import 'package:get/get.dart';

import '../../app/modules/add_patient_and_home_screen/bindings/add_patient_and_home_screen_binding.dart';
import '../../app/modules/add_patient_and_home_screen/views/add_patient_and_home_screen_view.dart';
import '../../app/modules/edit_profile_screen/bindings/edit_profile_screen_binding.dart';
import '../../app/modules/edit_profile_screen/views/edit_profile_screen_view.dart';
import '../../app/modules/individual_patient_screen/bindings/individual_patient_screen_binding.dart';
import '../../app/modules/individual_patient_screen/views/individual_patient_screen_view.dart';
import '../../app/modules/user_setting_screen/bindings/user_setting_screen_binding.dart';
import '../../app/modules/user_setting_screen/views/user_setting_screen_view.dart';
import '../../global/constants/api_constant.dart';
import '../../main.dart';
import '../view/authorization/signup/binding/signup_binding.dart';
import '../view/authorization/signup/view/signup_screen.dart';
import '../view/home/binding/home_binding.dart';
import '../view/home/view/home_screen.dart';
import '../view/pricing/binding/pricing_binding.dart';
import '../view/pricing/view/pricing_screen.dart';
import '../view/splash/binding/splash_binding.dart';
import '../view/splash/view/splash_view.dart';

// App Pages

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // ignore: constant_identifier_names
  static String INITIAL =
      // (!isNullEmptyOrFalse(box.read(ArgumentConstant.token)))
      (!isNullEmptyOrFalse(box.read(ArgumentConstant.userAlreadyLogin)))
          ? Routes.ADD_PATIENT_AND_HOME_SCREEN
          : Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashView(),
      binding: SplashBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.SIGNUP_SCREEN,
      page: () => const SingUpScreen(),
      binding: SignUpBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.PRICING_SCREEN,
      page: () => const PricingScreen(),
      binding: PricingBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.HOME_SCREEN,
      page: () => HomeScreen(),
      binding: HomeBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.ADD_PATIENT_AND_HOME_SCREEN,
      page: () => AddPatientAndHomeScreenView(),
      binding: AddPatientAndHomeScreenBinding(),
    ),
    GetPage(
      name: _Paths.INDIVIDUAL_PATIENT_SCREEN,
      page: () => IndividualPatientScreenView(),
      binding: IndividualPatientScreenBinding(),
    ),
    GetPage(
      name: _Paths.USER_SETTING_SCREEN,
      page: () => const UserSettingScreenView(),
      binding: UserSettingScreenBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE_SCREEN,
      page: () => EditProfileScreenView(),
      binding: EditProfileScreenBinding(),
    ),
    GetPage(
      name: _Paths.PHONE_LOGIN_SCREEN,
      page: () => PhoneLoginView(),
      binding: PhoneLoginBinding(),
    ),
  ];
}
