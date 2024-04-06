import 'dart:developer';

import 'package:Dentosupport_mini/global/constants/api_constant.dart';
import 'package:Dentosupport_mini/global/constants/app_color.dart';
import 'package:Dentosupport_mini/global/data/NetworkClient.dart';
import 'package:Dentosupport_mini/global/utils/services/app_config.dart';
import 'package:Dentosupport_mini/global/constants/app_string.dart';
import 'package:Dentosupport_mini/global/widgets/aleart_dialog.dart';
import 'package:Dentosupport_mini/global/widgets/custom_dialogs.dart';
import 'package:Dentosupport_mini/global/widgets/permission.dart';
import 'package:Dentosupport_mini/src/routes/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

import 'global/constants/app_module.dart';

GetStorage box = GetStorage();
final getIt = GetIt.instance;

void main() async {
  BuildConfiguration.shared.environment = Environment.staging;
  WidgetsFlutterBinding.ensureInitialized();

 /* SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: AppColor.white,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
    ),
  );*/

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    // DeviceOrientation.portraitDown
  ]);

  await GetStorage.init();
  await Firebase.initializeApp();

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  setUp();
  AppPermission.askPermissions();
  runApp(
    MyApp(),
  );
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

// App Config

class _MyAppState extends State<MyApp> {
  String appVersion = "";
  String androidVersion = "";
  String iosVersion = "";
  bool? forceUpdate;
  bool? softUpdate;
  bool? appInMaintenance;

  final uriLink = Uri.parse("https://dentosupport.com/");

  Future<void> _launchUrl({
    String? uri,
  }) async {
    if (!await launchUrl(
      uriLink,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $uri';
    }
  }

  void getVersion() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    appVersion = info.version;

    Map<String, dynamic> dict = {};

    return NetworkClient.getInstance.callApi(
      Get.context!,
      baseUrl,
      ApiConstant.config,
      MethodType.Get,
      header: NetworkClient.getInstance.getAuthHeaders(),
      params: dict,
      successCallback: (response, message) {
        debugPrint("-=-=-=-callGetMeApi");
        log("-=-=-=-response-=-=-$response");

        if (response["status"] == 200 || response["status"] == "success") {
          debugPrint("-=-=-=-=-appVersion.value=-=-${appVersion}");

          androidVersion = response["data"][0]["androidVersionCode"];
          iosVersion = response["data"][0]["iosVersionCode"];
          forceUpdate = response["data"][0]["forceUpdate"];
          softUpdate = response["data"][0]["softUpdate"];
          appInMaintenance = response["data"][0]["appInMaintenance"];

          if (softUpdate == true) {
            if (GetPlatform.isAndroid) {
              if (androidVersion == appVersion) {
              } else {
                if (forceUpdate == true) {
                  commonAlertDialog(
                    title: "Dentosupport Update",
                    description:
                        "“Dentosupport” needs to be updated. Please update to the latest version.\n“version no. ${androidVersion}”",
                    confirmText: "Update",
                    cancelText: "Exit",
                    willPopScope: false,
                    onCancel: () {
                      SystemNavigator.pop();
                    },
                    onConfirm: () async {
                      _launchUrl();
                    },
                  );
                } else {
                  commonAlertDialog(
                    title: "Dentosupport",
                    description:
                        "“Dentosupport” needs to be updated. Please update to the latest version.\n“version no. ${androidVersion}”",
                    cancelText: "Skip",
                    confirmText: "Update",
                    willPopScope: false,
                    onConfirm: () {
                      _launchUrl();
                    },
                    onCancel: () async {
                      Get.back();
                    },
                  );
                }
              }
            } else if (GetPlatform.isIOS) {
              if (iosVersion == appVersion) {
              } else {
                if (forceUpdate == true) {
                  commonAlertDialog(
                    title: "Dentosupport",
                    description:
                        "“Dentosupport” needs to be updated. Please update to the latest version.\n“version no. ${androidVersion}”",
                    confirmText: "Update",
                    cancelText: "Exit",
                    willPopScope: false,
                    onCancel: () {
                      SystemNavigator.pop();
                    },
                    onConfirm: () async {
                      _launchUrl();
                    },
                  );
                } else {
                  commonAlertDialog(
                    title: "Dentosupport",
                    description:
                        "“Dentosupport” needs to be updated. Please update to the latest version.\n“version no. ${androidVersion}”",
                    cancelText: "Skip",
                    confirmText: "Update",
                    willPopScope: false,
                    onConfirm: () async {
                      _launchUrl();
                    },
                    onCancel: () async {
                      Get.back();
                    },
                  );
                }
              }
            }
          } else if (appInMaintenance == true) {
            commonAlertDialog(
              title: "Dentosupport",
              description: "“Dentosupport” maintenance",
              confirmText: "Visit",
              cancelText: "Exit",
              willPopScope: false,
              onCancel: () {
                SystemNavigator.pop();
              },
              onConfirm: () async {
                _launchUrl();
              },
            );
          } else {}
        } else {
          getIt<CustomDialogs>()
              .getDialog(title: "Failed", desc: response["message"]);
        }
      },
      failureCallback: (response, message) {

        debugPrint("-=-=-=-callGetMeApi");
        log("-=-=-=-response-=-=-$response");
        getIt<CustomDialogs>()
            .getDialog(title: "Failed", desc: message);
        print(" error");
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getVersion();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return GetMaterialApp(
      title: AppString.appNameMain,
      debugShowCheckedModeBanner: false,
      locale: Get.deviceLocale,
      builder: (context, child) {
        return MediaQuery(
          child: child!,
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        );
      },
      fallbackLocale: const Locale(
        'en',
        'US',
      ),
      theme: ThemeData(
        // fontFamily: 'Inter',
        fontFamily: 'DM Sans',
      ),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
