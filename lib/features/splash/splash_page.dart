import 'package:dento_support/core/configs/colors.dart';
import 'package:dento_support/features/app/bloc/app_bloc.dart';
import 'package:dento_support/main.dart';
import 'package:dento_support/routers/route_utils.dart';
import 'package:dento_support/widgets/logo_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    setAppFlow();
  }

  Future<void> setAppFlow() async {
    await Future.delayed(
      const Duration(seconds: 1),
      () async {
        switch (context.read<AppBloc>().state.status) {
          case AppStatus.authenticated:
            context.go(AppPage.home.toPath);
            break;
          case AppStatus.unauthenticated:
            context.go(AppPage.signin.toPath);
            break;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          const LogoView(),
          Positioned(
            left: 0,
            right: 0,
            bottom: 96,
            child: Text(
              'Version $versionName',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: AppFont.inter,
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: AppColor.backgroundColor,
                letterSpacing: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
