import 'package:dento_support/core/configs/colors.dart';
import 'package:dento_support/core/services/local_storage_service.dart';
import 'package:dento_support/features/clinic/cubit/clinic_list_cubit.dart';
import 'package:dento_support/features/clinic/views/clinic_page.dart';
import 'package:dento_support/features/patients/presentation/bloc/patient_list_bloc.dart';
import 'package:dento_support/injector.dart';
import 'package:dento_support/widgets/primary_button.dart';
import 'package:dento_support/widgets/user_detail_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManageClinicsPage extends StatelessWidget {
  const ManageClinicsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Clinics'),
      ),
      body: BlocProvider(
        create: (_) => ClinicListCubit()..getClinic(),
        child: const ClinicListView(),
      ),
    );
  }
}

class ClinicListView extends StatelessWidget {
  const ClinicListView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: BlocBuilder<ClinicListCubit, ClinicListState>(
        builder: (context, state) {
          return Column(
            children: [
              const SizedBox(height: 30),
              UserDetailWidget(
                name: getIt<LocalStorageService>().user.name,
                phoneNumber: getIt<LocalStorageService>().user.mobile,
              ),
              const SizedBox(height: 60),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.clinics.length,
                itemBuilder: (context, index) {
                  final clinic = state.clinics[index];

                  return Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  clinic.name,
                                  style: const TextStyle(
                                    fontFamily: AppFont.inter,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    color: AppColor.textColor,
                                  ),
                                ),
                                Text(
                                  clinic.location,
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
                          TextButton(
                            onPressed: () async {
                              final result = await Navigator.push<bool>(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ClinicPage(clinic: clinic),
                                ),
                              );

                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                if (result ?? false) {
                                  context.read<PatientListBloc>()
                                    ..add(const PatientsFetched())
                                    ..add(const UpdateVisitorCount());

                                  context.read<ClinicListCubit>().getClinic();
                                }
                              });
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: const Text(
                              'Edit',
                              style: AppFontStyle.style4,
                            ),
                          ),
                          const SizedBox(width: 25),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 18),
                        child: Divider(
                          color: Color(0xFFD6D6D6),
                          height: 1,
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 120),
              AppPrimaryButton(
                title: 'Add Clinic',
                onPressed: state.clinics.length >= 3
                    ? null
                    : () async {
                        final result = await Navigator.push<bool>(
                          context,
                          MaterialPageRoute(builder: (_) => const ClinicPage()),
                        );

                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (result ?? false) {
                            context.read<ClinicListCubit>().getClinic();
                          }
                        });
                      },
              ),
              const SizedBox(height: 4),
              const Text(
                '*You can add upto 3 clinics',
                style: TextStyle(
                  fontFamily: AppFont.inter,
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                  color: Color.fromRGBO(0, 0, 0, 0.5),
                ),
              ),
              const SizedBox(height: 30),
            ],
          );
        },
      ),
    );
  }
}
