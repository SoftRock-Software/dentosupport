//Views are all the Widgets and Pages within the Flutter Application.
// These views may contain a “view controller” themselves,
// but that is still considered part of the view application tier.

import 'package:Dentosupport_mini/global/constants/app_color.dart';
import 'package:Dentosupport_mini/global/constants/size_constant.dart';
import 'package:Dentosupport_mini/src/view/splash/component/splash_component.dart';
import 'package:Dentosupport_mini/src/view/splash/controller/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashView extends GetWidget<SplashController> {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    MySize().init(context);
    return Scaffold(
      backgroundColor: AppColor.white,
      body: splashView(context, controller: controller),
    );
  }
}
