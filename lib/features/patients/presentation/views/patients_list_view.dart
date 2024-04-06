import 'package:dento_support/core/services/local_storage_service.dart';
import 'package:dento_support/core/utils/date_format_utils.dart';
import 'package:dento_support/features/patients/presentation/bloc/patient_list_bloc.dart';
import 'package:dento_support/features/patients/presentation/widgets/empty_list_widget.dart';
import 'package:dento_support/features/patients/presentation/widgets/patient_item_widget.dart';
import 'package:dento_support/injector.dart';
import 'package:dento_support/routers/route_utils.dart';
import 'package:dento_support/routers/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PatientsListView extends StatelessWidget {
  const PatientsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PatientListBloc, PatientListState>(
      builder: (context, state) {
        if (state.status == PatientListStatus.initial) {
          return const Center(child: RefreshProgressIndicator());
        }

        if (state.patients.isEmpty) {
          final selectedDate = state.date ?? DateTime.now();
          if (selectedDate.isToday) {
            final dayOff =
                getIt<LocalStorageService>().user.clinics.first.dayOff;
            final contains = dayOff.contains(
              DateFormatUtils.fullWeekDay(selectedDate).toLowerCase(),
            );
            if (contains) {
              return const EmptyListWidget(Empty.todayOff);
            } else {
              return const EmptyListWidget(Empty.today);
            }
          } else if (selectedDate.isBefore(DateTime.now())) {
            return const EmptyListWidget(Empty.yesterday);
          } else {
            return const EmptyListWidget(Empty.tomorrow);
          }
        } else {
          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.patients.length,
            itemBuilder: (context, index) {
              final patient = state.patients[index];

              return InkWell(
                onTap: () => context.push(
                  AppPage.patient.toPath,
                  extra: PatientExtraNew(patient: patient.patient),
                ),
                child: PatientItemWidget(
                  patient.patient,
                  isVisited: patient.isVisited,
                ),
              );
            },
            separatorBuilder: (context, index) => const Divider(
              color: Color(0xFFD4D4D4),
            ),
          );
        }
      },
    );
  }
}
