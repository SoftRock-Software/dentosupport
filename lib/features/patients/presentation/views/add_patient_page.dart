import 'package:dento_support/core/configs/colors.dart';
import 'package:dento_support/core/services/local_storage_service.dart';
import 'package:dento_support/core/utils/date_format_utils.dart';
import 'package:dento_support/features/patients/models/patient.dart';
import 'package:dento_support/features/patients/presentation/bloc/patient_list_bloc.dart';
import 'package:dento_support/features/patients/presentation/cubit/add_patient_cubit.dart';
import 'package:dento_support/features/patients/repository/patient_repository.dart';
import 'package:dento_support/injector.dart';
import 'package:dento_support/routers/route_utils.dart';
import 'package:dento_support/routers/router.dart';
import 'package:dento_support/widgets/gender_option_widget.dart';
import 'package:dento_support/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AddPatientPage extends StatelessWidget {
  const AddPatientPage({
    super.key,
    required this.name,
    this.patient,
  });

  final String name;
  final Patient? patient;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          patient == null ? 'Add Patient' : 'Edit Patient',
          style: const TextStyle(
            fontFamily: AppFont.inter,
            fontWeight: FontWeight.w700,
            fontSize: 22,
            color: AppColor.textColor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            padding: EdgeInsets.zero,
            icon: const Icon(
              Icons.close,
              size: 20,
              color: AppColor.textColor,
            ),
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) => AddPatientCubit(),
        child: AddPatientView(
          name: name,
          patient: patient,
        ),
      ),
    );
  }
}

class AddPatientView extends StatefulWidget {
  const AddPatientView({
    super.key,
    required this.name,
    this.patient,
  });

  final String name;
  final Patient? patient;

  @override
  State<AddPatientView> createState() => _AddPatientViewState();
}

class _AddPatientViewState extends State<AddPatientView> {
  final _key = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _ageController = TextEditingController();
  final _locationController = TextEditingController();
  String _gender = 'M';

  final dayOff = getIt<LocalStorageService>().user.clinics.first.dayOff;

  @override
  void initState() {
    super.initState();

    if (widget.patient != null) {
      _nameController.text = widget.patient!.name;
      _mobileController.text = widget.patient!.mobile;
      _ageController.text = widget.patient!.age.toString();
      _locationController.text = widget.patient!.location;
      _gender = widget.patient!.gender;
    } else {
      // From search page
      if (double.tryParse(widget.name) != null) {
        _mobileController.text = widget.name;
      } else {
        _nameController.text = widget.name;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final contains = dayOff.contains(
      DateFormatUtils.fullWeekDay(DateTime.now()).toLowerCase(),
    );

    return BlocListener<AddPatientCubit, AddPatientState>(
      listener: (context, state) {
        if (state.status == PatientStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              duration: const Duration(seconds: 1),
            ),
          );
        }

        if (state.status == PatientStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Patient added successfully'),
              duration: Duration(seconds: 1),
            ),
          );

          context.push(
            AppPage.patient.toPath,
            extra: PatientExtraNew(
              patient: state.patient!,
              fromAddPatient: true,
            ),
          );
        }

        if (state.status == PatientStatus.edited) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Patient edit successfully'),
              duration: Duration(seconds: 1),
            ),
          );
          context.read<PatientListBloc>()
            ..add(const PatientsFetched())
            ..add(const UpdateVisitorCount());
          Navigator.of(context).popUntil((route) => route.isFirst);
        }
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
        child: Form(
          key: _key,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                textCapitalization: TextCapitalization.words,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[A-Za-z ]'))
                ],
                decoration: const InputDecoration(
                  hintText: 'Name',
                  hintStyle: AppFontStyle.hintStyle,
                  counterText: '',
                ),
                maxLength: 26,
                style: AppFontStyle.textStyle,
                autofocus: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      controller: _mobileController,
                      style: AppFontStyle.textStyle,
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                      ],
                      decoration: const InputDecoration(
                        hintText: 'Mobile number',
                        hintStyle: AppFontStyle.hintStyle,
                        counterText: '',
                        helperText: ' ',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a valid phone number';
                        } else if (value.length != 10) {
                          return 'Please enter a valid phone number';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 30),
                  Expanded(
                    child: TextFormField(
                      controller: _ageController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'Age',
                        hintStyle: AppFontStyle.hintStyle,
                        counterText: '',
                        helperText: ' ',
                      ),
                      style: AppFontStyle.textStyle,
                      maxLength: 3,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                      ],
                      // validator: (value) {
                      //   if (value!.isEmpty) {
                      //     return 'Please enter a age';
                      //   } else if (!(int.parse(value) >= 2 &&
                      //       int.parse(value) <= 110)) {
                      //     return 'Please enter valid age';
                      //   } else {
                      //     return null;
                      //   }
                      // },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              GenderOptionWidget(
                onChanged: (gender) => _gender = gender!.value,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _locationController,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  hintText: 'Location',
                  hintStyle: AppFontStyle.hintStyle,
                ),
                style: AppFontStyle.textStyle,
                // validator: (value) {
                //   if (value!.isEmpty) {
                //     return 'Please enter a patient location';
                //   }
                //   return null;
                // },
              ),
              const SizedBox(height: 40),
              if (contains)
                const Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Text(
                    'Today is clinic day off',
                    style: TextStyle(
                      fontFamily: AppFont.inter,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: AppColor.textColor,
                    ),
                  ),
                ),
              BlocBuilder<AddPatientCubit, AddPatientState>(
                builder: (context, state) {
                  return AppPrimaryButton(
                    title: widget.patient != null
                        ? 'Save'
                        : contains
                            ? 'Unblock Today & Add New Patient'
                            : 'Add New Patient',
                    onPressed: state.status == PatientStatus.loading
                        ? null
                        : () async {
                            if (!_key.currentState!.validate()) return;

                            if (_ageController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please enter a age'),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                              return;
                            } else if (!(int.parse(_ageController.text) >= 2 &&
                                int.parse(_ageController.text) <= 110)) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please enter valid age'),
                                  duration: Duration(seconds: 1),
                                ),
                              );

                              return;
                            }

                            final params = AddPatientParams(
                              name: _nameController.text,
                              mobile: _mobileController.text,
                              gender: _gender,
                              age: int.parse(_ageController.text),
                              clinicId: getIt<LocalStorageService>()
                                  .user
                                  .clinics
                                  .first
                                  .id,
                              location: _locationController.text,
                            );

                            if (widget.patient != null) {
                              await context.read<AddPatientCubit>().editPatient(
                                    params,
                                    widget.patient!.id.toString(),
                                  );
                            } else {
                              await context
                                  .read<AddPatientCubit>()
                                  .addPatient(params);
                            }
                          },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
