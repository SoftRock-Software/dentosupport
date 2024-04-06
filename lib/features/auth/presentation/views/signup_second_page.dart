import 'package:dento_support/core/configs/colors.dart';
import 'package:dento_support/core/constants/app_constant.dart';
import 'package:dento_support/features/auth/domain/domain.dart';
import 'package:dento_support/features/auth/presentation/cubit/signup_cubit.dart';
import 'package:dento_support/features/clinic/cubit/clinic_cubit.dart';
import 'package:dento_support/features/clinic/models/clinic_params.dart';
import 'package:dento_support/features/clinic/views/clinic_view.dart';
import 'package:dento_support/routers/route_utils.dart';
import 'package:dento_support/widgets/primary_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class SignUpSecondPage extends StatefulWidget {
  const SignUpSecondPage({
    super.key,
    required this.params,
  });

  final RegisterParams params;

  @override
  State<SignUpSecondPage> createState() => _SignUpSecondPageState();
}

class _SignUpSecondPageState extends State<SignUpSecondPage> {
  final _key = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _locationController = TextEditingController();
  List<String> _offDays = [];

  Future<void> _launchURLApp(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SignupCubit, SignupState>(
          listener: (context, state) {
            if (state.status.isSuccess) {
              final params = ClinicParams(
                name: _nameController.text,
                mobile: _mobileController.text,
                location: _locationController.text,
                dayOff: _offDays.isEmpty
                    ? ''
                    : _offDays.map((e) => e.toLowerCase()).join(','),
              );

              context.read<ClinicCubit>().addClinic(params);
            }

            if (state.status.hasError) {
              FocusScope.of(context).unfocus();

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                  duration: const Duration(seconds: 1),
                ),
              );
            }
          },
        ),
        BlocListener<ClinicCubit, ClinicState>(
          listener: (context, state) {
            if (state.status == ClinicStatus.success) {
              context.go(AppPage.home.toPath);
            }

            if (state.status == ClinicStatus.failure) {
              FocusScope.of(context).unfocus();

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                  duration: const Duration(seconds: 1),
                ),
              );
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'dento',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppColor.primaryColor,
                      ),
                    ),
                    TextSpan(
                      text: 'support',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Clinic Details',
                      style: TextStyle(
                        fontFamily: AppFont.inter,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: AppColor.textColor,
                      ),
                    ),
                    Text(
                      '''
Please enter your clinic details for maintaining records''',
                      style: TextStyle(
                        fontFamily: AppFont.inter,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: AppColor.subtitleColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                ClinicView(
                  nameController: _nameController,
                  mobileController: _mobileController,
                  locationController: _locationController,
                  onChanged: (value) => _offDays = value,
                ),
                const SizedBox(height: 50),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Text.rich(
                      style: const TextStyle(
                        fontFamily: AppFont.inter,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: Color(0xFF1F2544),
                      ),
                      textAlign: TextAlign.center,
                      TextSpan(
                        children: [
                          const TextSpan(
                            text:
                                'By clicking Finish I agree with dentosupport ',
                          ),
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'terms of service',
                                style: const TextStyle(
                                  fontFamily: AppFont.plusJakartaSans,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.underline,
                                  color: Color(0xFF1F2544),
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    await _launchURLApp(
                                      AppConstant.termsOfService,
                                    );
                                  },
                              ),
                              const TextSpan(text: ' and '),
                              TextSpan(
                                text: 'privacy policy!',
                                style: const TextStyle(
                                  fontFamily: AppFont.plusJakartaSans,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.underline,
                                  color: Color(0xFF1F2544),
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    await _launchURLApp(
                                      AppConstant.privacyPolicyUrl,
                                    );
                                  },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                BlocBuilder<SignupCubit, SignupState>(
                  builder: (context, SignupState signupState) {
                    return BlocBuilder<ClinicCubit, ClinicState>(
                      builder: (context, ClinicState clinicState) {
                        return AppPrimaryButton(
                          title: 'Finish',
                          onPressed: clinicState.status ==
                                      ClinicStatus.loading ||
                                  signupState.status.isLoading
                              ? null
                              : () {
                                  if (!_key.currentState!.validate()) return;

                                  context
                                      .read<SignupCubit>()
                                      .signUp(widget.params);
                                },
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: 20),
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    '2 of 2',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: AppFont.inter,
                      fontWeight: FontWeight.w600,
                      fontSize: 10,
                      color: AppColor.textColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
