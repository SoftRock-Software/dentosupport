import 'package:dento_support/core/configs/colors.dart';
import 'package:dento_support/core/services/local_storage_service.dart';
import 'package:dento_support/features/clinic/cubit/clinic_cubit.dart';
import 'package:dento_support/features/clinic/models/clinic.dart';
import 'package:dento_support/features/clinic/models/clinic_params.dart';
import 'package:dento_support/features/clinic/views/clinic_view.dart';
import 'package:dento_support/injector.dart';
import 'package:dento_support/widgets/primary_button.dart';
import 'package:dento_support/widgets/user_detail_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClinicPage extends StatelessWidget {
  const ClinicPage({
    super.key,
    this.clinic,
  });

  final Clinic? clinic;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(clinic == null ? 'Add New Clinic' : 'Manage Clinics'),
      ),
      body: BlocProvider(
        create: (context) => ClinicCubit(),
        child: _ClinicView(clinic: clinic),
      ),
    );
  }
}

class _ClinicView extends StatefulWidget {
  const _ClinicView({required this.clinic});

  final Clinic? clinic;

  @override
  State<_ClinicView> createState() => _ClinicViewState();
}

class _ClinicViewState extends State<_ClinicView> {
  final _key = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _locationController = TextEditingController();
  List<String> _selectedItems = [];

  @override
  void initState() {
    super.initState();

    if (widget.clinic != null) {
      _nameController.text = widget.clinic!.name;
      _mobileController.text = widget.clinic!.mobile;
      _locationController.text = widget.clinic!.location;
      for (final element in widget.clinic!.dayOff) {
        if (element.isNotEmpty) {
          _selectedItems.add(element.capitalize);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ClinicCubit, ClinicState>(
      listener: (context, state) {
        if (state.status == ClinicStatus.failure) {
          FocusScope.of(context).unfocus();

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              duration: const Duration(seconds: 1),
            ),
          );
        }

        if (state.status == ClinicStatus.success) {
          Navigator.pop(context, true);
        }
      },
      child: SingleChildScrollView(
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
              const SizedBox(height: 60),
              SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.clinic != null
                                ? widget.clinic!.name
                                : 'Clinic Details',
                            style: const TextStyle(
                              fontFamily: AppFont.inter,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: AppColor.textColor,
                            ),
                          ),
                          Text(
                            widget.clinic != null
                                ? widget.clinic!.location
                                : 'Please enter your clinic details',
                            style: const TextStyle(
                              fontFamily: AppFont.inter,
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: AppColor.subtitleColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (widget.clinic != null &&
                        getIt<LocalStorageService>().user.clinics.length > 1)
                      InkWell(
                        onTap: () => showDeleteSheet(
                          context,
                          onDelete: () async {
                            Navigator.pop(context);

                            await context
                                .read<ClinicCubit>()
                                .deleteClinic(widget.clinic!.id);
                          },
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFE8E8),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Text(
                            'Delete Clinic',
                            style: TextStyle(
                              fontFamily: AppFont.inter,
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: AppColor.red,
                            ),
                          ),
                        ),
                      )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ClinicView(
                nameController: _nameController,
                mobileController: _mobileController,
                locationController: _locationController,
                selectedItems: _selectedItems,
                onChanged: (value) {
                  FocusManager.instance.primaryFocus?.unfocus();
                  _selectedItems = value;
                },
              ),
              const SizedBox(height: 60),
              BlocBuilder<ClinicCubit, ClinicState>(
                builder: (context, state) {
                  return AppPrimaryButton(
                    title: 'Save',
                    onPressed: state.status == ClinicStatus.loading
                        ? null
                        : () {
                            if (!_key.currentState!.validate()) return;

                            final params = ClinicParams(
                              name: _nameController.text,
                              mobile: _mobileController.text,
                              location: _locationController.text,
                              dayOff: _selectedItems.isEmpty
                                  ? ''
                                  : _selectedItems
                                      .map((e) => e.toLowerCase())
                                      .join(','),
                            );

                            if (widget.clinic != null) {
                              context
                                  .read<ClinicCubit>()
                                  .editClinic(params, widget.clinic!.id);
                            } else {
                              context.read<ClinicCubit>().addClinic(params);
                            }
                          },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showDeleteSheet(BuildContext context, {void Function()? onDelete}) {
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Are you sure you want to delete ${widget.clinic!.name}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
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
Only the clinic and schedule history will be deleted, while patient data will remain intact and not be affected.''',
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
                title: 'Delete ${widget.clinic!.name}',
                backgroundColor: AppColor.red,
                onPressed: onDelete,
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

extension StringExtension on String {
  String get capitalize =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
}
