enum AppPage {
  splash,
  signin,
  signupFirst,
  signupSecond,
  editProfile,
  manageClinics,
  addClinic,
  home,
  addPatient,
  settings,
  payments,
  subscriptionPlan,
  patient,
}

extension AppPageExtension on AppPage {
  String get toPath {
    switch (this) {
      case AppPage.signin:
        return '/signin';
      case AppPage.splash:
        return '/splash';
      case AppPage.signupFirst:
        return '/signup-first';
      case AppPage.signupSecond:
        return '/signup-second';
      case AppPage.editProfile:
        return '/edit-profile';
      case AppPage.manageClinics:
        return '/manage-clinics';
      case AppPage.addClinic:
        return 'add-clinic';
      case AppPage.home:
        return '/home';
      case AppPage.addPatient:
        return '/add-patient';
      case AppPage.settings:
        return '/settings';
      case AppPage.payments:
        return '/payments';
      case AppPage.subscriptionPlan:
        return '/subscription-plan';
      case AppPage.patient:
        return '/patient';
    }
  }
}
