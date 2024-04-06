import 'package:dento_support/core/configs/colors.dart';
import 'package:dento_support/core/constants/app_constant.dart';
import 'package:dento_support/core/services/local_storage_service.dart';
import 'package:dento_support/features/app/bloc/app_bloc.dart';
import 'package:dento_support/features/settings/widgets/logout_button_widget.dart';
import 'package:dento_support/features/settings/widgets/setting_item_widget.dart';
import 'package:dento_support/features/settings/widgets/subscription_widget.dart';
import 'package:dento_support/injector.dart';
import 'package:dento_support/routers/route_utils.dart';
import 'package:dento_support/widgets/primary_button.dart';
import 'package:dento_support/widgets/user_detail_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  Future<void> _launchURLApp(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _launchExternalUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication,
      );
    } else {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        systemOverlayStyle: const SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.white,
          systemNavigationBarDividerColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.light,
          statusBarColor: Colors.white,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 30),
                UserDetailWidget(
                  name: getIt<LocalStorageService>().user.name,
                  phoneNumber: getIt<LocalStorageService>().user.mobile,
                ),
                const SizedBox(height: 32),
                const SubscriptionWidget(
                  subtitle: 'Only for 749/- per month',
                ),
                const SizedBox(height: 62),
                SettingItemWidget(
                  title: 'Edit Profile',
                  onTap: () => context.push(AppPage.editProfile.toPath),
                ),
                SettingItemWidget(
                  title: 'Manage Clinics',
                  onTap: () => context.push(AppPage.manageClinics.toPath),
                ),
                const SettingItemWidget(title: 'Notifications'),
                SettingItemWidget(
                  title: 'Terms of Service',
                  onTap: () async => _launchURLApp(AppConstant.termsOfService),
                ),
                SettingItemWidget(
                  title: 'Privacy Policy',
                  onTap: () async =>
                      _launchURLApp(AppConstant.privacyPolicyUrl),
                ),
                SettingItemWidget(
                  title: 'My Subscriptions',
                  onTap: () => context.push(AppPage.payments.toPath),
                ),
                const RequestToDataDeletion(),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Contact us via ',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: AppColor.textColor,
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        final emailLaunchUri = Uri(
                          scheme: 'mailto',
                          path: AppConstant.supportMail,
                        );

                        try {
                          final result = await launchUrl(emailLaunchUri);
                          debugPrint('$result');
                        } catch (_) {
                          debugPrint('Not able to open default mail app');
                        }
                      },
                      child: const Text(
                        'Email',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: AppColor.primaryColor,
                        ),
                      ),
                    ),
                    const Text(
                      ' or via ',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: AppColor.textColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () async => _launchExternalUrl(AppConstant.whatsApp),
                  child: Image.asset(
                    AppAssets.whatsapp,
                    width: MediaQuery.of(context).size.width / 2,
                  ),
                ),
                const SizedBox(height: 136),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: LogoutButtonWidget(
              onPressed: () {
                context.pushReplacement(AppPage.signin.toPath);
                context.read<AppBloc>().add(const AppLogoutRequested());
              },
            ),
          ),
        ],
      ),
    );
  }
}

class RequestToDataDeletion extends StatelessWidget {
  const RequestToDataDeletion({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingItemWidget(
      title: 'Request Data Deletion',
      color: AppColor.red,
      onTap: () => showSuccessSheet(context),
    );
  }

  void showSuccessSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.1),
                blurRadius: 4,
              )
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              Container(
                height: 4,
                width: 28,
                decoration: BoxDecoration(
                  color: const Color(0xFFAAAAAA),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  '''
Are you sure you want to delete all your data from dentosupport?''',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: AppFont.inter,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: AppColor.red,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  '''
This action cannot be undone. All patients records and account data will be deleted forever.''',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: AppFont.inter,
                    fontWeight: FontWeight.w500,
                    fontSize: 10,
                    color: Color(0xFF1A202C),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              AppPrimaryButton(
                title: 'Delete All My Data',
                backgroundColor: AppColor.red,
                onPressed: () async {
                  final success = await context.read<AppBloc>().deleteUser();
                  if (success) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      context.pushReplacement(AppPage.signin.toPath);
                      context.read<AppBloc>().add(const AppLogoutRequested());
                    });
                  }
                },
              ),
              const SizedBox(height: 20),
              AppPrimaryButton(
                title: 'Go Back',
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      },
    );
  }
}
