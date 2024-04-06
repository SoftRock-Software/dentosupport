import 'package:dento_support/core/configs/colors.dart';
import 'package:dento_support/core/services/local_storage_service.dart';
import 'package:dento_support/core/utils/date_format_utils.dart';
import 'package:dento_support/features/auth/presentation/cubit/user_cubit.dart';
import 'package:dento_support/injector.dart';
import 'package:dento_support/widgets/gender_option_widget.dart';
import 'package:dento_support/widgets/primary_button.dart';
import 'package:dento_support/widgets/user_detail_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _key = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _dobController = TextEditingController();
  String _gender = 'M';
  String _dob = '';

  @override
  void initState() {
    final user = getIt<LocalStorageService>().user;

    _nameController.text = user.name;
    _emailController.text = user.email;
    final dobDateTime = DateTime.parse(user.dob);
    _dob = user.dob;
    _dobController.text = dobDateTime.dob;
    _gender = user.gender;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) {
        if (state.status == UserStatus.failure) {
          FocusScope.of(context).unfocus();

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              duration: const Duration(seconds: 1),
            ),
          );
        }

        if (state.status == UserStatus.success) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Profile'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Form(
            key: _key,
            child: Column(
              children: [
                const SizedBox(height: 30),
                UserDetailWidget(
                  name: getIt<LocalStorageService>().user.name,
                  phoneNumber: getIt<LocalStorageService>().user.mobile,
                ),
                const SizedBox(height: 42),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    hintText: 'Your name',
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
                        r'^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                    final regex = RegExp(pattern);
                    if (!regex.hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 40),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '+91-${getIt<LocalStorageService>().user.mobile}',
                        style: AppFontStyle.textStyle,
                      ),
                    ),
                    const Text(
                      'Verified',
                      style: TextStyle(
                        fontFamily: AppFont.inter,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: AppColor.primaryColor,
                      ),
                    ),
                    const Icon(
                      Icons.verified,
                      size: 14,
                      color: AppColor.primaryColor,
                    ),
                  ],
                ),
                const SizedBox(height: 25),
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
                  value: _gender,
                  onChanged: (gender) => _gender = gender!.value,
                ),
                const SizedBox(height: 50),
                BlocBuilder<UserCubit, UserState>(
                  builder: (context, state) {
                    return AppPrimaryButton(
                      title: 'Save',
                      onPressed: state.status == UserStatus.loading
                          ? null
                          : () {
                              if (!_key.currentState!.validate()) return;

                              context.read<UserCubit>().editUser(
                                    name: _nameController.text,
                                    email: _emailController.text,
                                    dob: _dob,
                                    gender: _gender,
                                  );
                            },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
