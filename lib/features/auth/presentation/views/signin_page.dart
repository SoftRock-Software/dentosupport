import 'package:dento_support/core/configs/colors.dart';
import 'package:dento_support/features/auth/presentation/bloc/phone_auth_bloc.dart';
import 'package:dento_support/features/auth/presentation/widgets/phone_input_widget.dart';
import 'package:dento_support/features/auth/presentation/widgets/pin_input_widget.dart';
import 'package:dento_support/features/patients/presentation/bloc/patient_list_bloc.dart';
import 'package:dento_support/routers/route_utils.dart';
import 'package:dento_support/widgets/logo_view.dart';
import 'package:dento_support/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _key = GlobalKey<FormState>();
  String _mobile = '';
  String _otp = '';
  final _pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(systemNavigationBarColor: Colors.white),
    );

    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocListener<PhoneAuthBloc, PhoneAuthState>(
        listener: (context, state) {
          if (state.error != null && state.error!.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error!),
                duration: const Duration(seconds: 1),
              ),
            );
          }

          if (state.status.isOtpSent && state.otpSent) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  content: Text('OTP sent successfully'),
                  duration: Duration(seconds: 1),
                ),
              );
          }

          if (state.status.isUserNew) {
            context.go(AppPage.signupFirst.toPath, extra: _mobile);
          }
          if (state.status.isUserOld) {
            context.read<PatientListBloc>()
              ..add(const PatientsFetched())
              ..add(const UpdateVisitorCount());

            context.go(AppPage.home.toPath);
          }
        },
        child: BlocBuilder<PhoneAuthBloc, PhoneAuthState>(
          builder: (context, state) {
            return Form(
              key: _key,
              child: Column(
                children: [
                  const Spacer(),
                  const LogoView(),
                  const Spacer(),
                  ColoredBox(
                    color: Colors.white,
                    child: SafeArea(
                      top: false,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 25),
                            const Text(
                              'Your Smart Clinic Journey Starts Here',
                              style: AppFontStyle.style1,
                            ),
                            const SizedBox(height: 5),
                            if (state.status.isInitial)
                              PhoneInputWidget(
                                onChanged: (mobile) {
                                  if (mobile.length == 10) {
                                    _mobile = mobile;
                                  }
                                },
                              ),
                            if (state.status.isOtpSent)
                              PinInputWidget(
                                controller: _pinController,
                                mobile: _mobile,
                                onResendPressed: () {
                                  _pinController.clear();
                                  context.read<PhoneAuthBloc>().add(
                                        SendOtpEvent(
                                          phoneNumber: _mobile,
                                        ),
                                      );
                                },
                                onMobilePressed: () {
                                  context
                                      .read<PhoneAuthBloc>()
                                      .add(const ResetEvent());
                                },
                                onCompleted: (otp) => _otp = otp,
                              ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 25,
                                vertical: 20,
                              ),
                              child: AppPrimaryButton(
                                title: state.status.isInitial
                                    ? 'Verify'
                                    : 'Sign in',
                                onPressed: state.loading
                                    ? null
                                    : () {
                                        if (state.status.isInitial) {
                                          if (!_key.currentState!.validate()) {
                                            return;
                                          }

                                          context.read<PhoneAuthBloc>().add(
                                                SendOtpEvent(
                                                  phoneNumber: _mobile,
                                                ),
                                              );
                                        } else {
                                          if (_otp.length == 4) {
                                            context.read<PhoneAuthBloc>().add(
                                                  VerifyOtpEvent(smsCode: _otp),
                                                );
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  'Enter OTP',
                                                ),
                                                duration: Duration(seconds: 1),
                                              ),
                                            );
                                          }
                                        }
                                      },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
