import 'package:dento_support/core/configs/colors.dart';
import 'package:dento_support/core/utils/date_format_utils.dart';
import 'package:dento_support/features/auth/domain/domain.dart';
import 'package:dento_support/routers/route_utils.dart';
import 'package:dento_support/widgets/gender_option_widget.dart';
import 'package:dento_support/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class SignUpFirstPage extends StatelessWidget {
  const SignUpFirstPage({super.key, required this.mobile});

  final String mobile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: SignUpView(mobile: mobile),
    );
  }
}

class SignUpView extends StatefulWidget {
  const SignUpView({super.key, required this.mobile});

  final String mobile;

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _key = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _dobController = TextEditingController();
  String _gender = 'M';
  String _dob = '';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                  'Primary information',
                  style: TextStyle(
                    fontFamily: AppFont.inter,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: AppColor.textColor,
                  ),
                ),
                Text(
                  'Please enter your details for seamless experience',
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
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                hintText: 'Your Name',
                hintStyle: AppFontStyle.hintStyle,
              ),
              style: AppFontStyle.textStyle,
              textCapitalization: TextCapitalization.words,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[A-Za-z ]'))
              ],
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
            ),
            const SizedBox(height: 30),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: 'Your email address',
                hintStyle: AppFontStyle.hintStyle,
              ),
              style: AppFontStyle.textStyle,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter an email';
                }
                // Use a Regex pattern to check if the email is valid
                const pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                final regex = RegExp(pattern);
                if (!regex.hasMatch(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            const SizedBox(height: 30),
            TextField(
              readOnly: true,
              decoration: InputDecoration(
                hintText: '+91-${widget.mobile}',
                hintStyle: AppFontStyle.textStyle,
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      'Verified',
                      style: TextStyle(
                        fontFamily: AppFont.inter,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: AppColor.primaryColor,
                      ),
                    ),
                    Icon(
                      Icons.verified,
                      size: 14,
                      color: AppColor.primaryColor,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            TextFormField(
              controller: _dobController,
              decoration: const InputDecoration(
                hintText: 'Date of Birth',
                hintStyle: AppFontStyle.hintStyle,
              ),
              style: AppFontStyle.textStyle,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a date of birth';
                }
                return null;
              },
              readOnly: true,
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  builder: (context, child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: const ColorScheme.light(
                          primary: AppColor.primaryColor,
                        ),
                        textButtonTheme: TextButtonThemeData(
                          style: TextButton.styleFrom(
                            foregroundColor:
                                AppColor.primaryColor, // button text color
                          ),
                        ),
                      ),
                      child: child!,
                    );
                  },
                  initialDate: DateTime(DateTime.now().year - 20),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(DateTime.now().year - 20),
                );

                if (picked != null) {
                  _dobController.text = picked.dob;
                  _dob = '${picked.year}-${picked.month}-${picked.day}';
                }
              },
            ),
            const SizedBox(height: 30),
            GenderOptionWidget(
              onChanged: (gender) => _gender = gender!.value,
            ),
            const SizedBox(height: 50),
            AppPrimaryButton(
              title: 'Continue',
              onPressed: () {
                if (!_key.currentState!.validate()) return;
                context.push(
                  AppPage.signupSecond.toPath,
                  extra: RegisterParams(
                    name: _nameController.text,
                    email: _emailController.text,
                    dob: _dob,
                    gender: _gender,
                  ),
                );
              },
            ),
            const Padding(
              padding: EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  '1 of 2',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: AppFont.inter,
                    fontWeight: FontWeight.w600,
                    fontSize: 10,
                    color: AppColor.textColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
