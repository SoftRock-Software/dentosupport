import 'package:dento_support/core/configs/colors.dart';
import 'package:dento_support/features/patients/models/patient.dart';
import 'package:dento_support/features/patients/presentation/bloc/patient_bloc.dart';
import 'package:dento_support/features/patients/presentation/bloc/patient_list_bloc.dart';
import 'package:dento_support/features/patients/presentation/cubit/payment_cubit.dart';
import 'package:dento_support/features/patients/presentation/cubit/treatment_cubit.dart';
import 'package:dento_support/features/patients/presentation/views/add_payment_page.dart';
import 'package:dento_support/features/patients/presentation/views/add_treatment_page.dart';
import 'package:dento_support/features/patients/presentation/views/summary_page.dart';
import 'package:dento_support/features/patients/presentation/views/timeline_page.dart';
import 'package:dento_support/features/patients/presentation/widgets/patient_scafold.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PatientPage extends StatefulWidget {
  const PatientPage(
    this.patient, {
    super.key,
    this.fromAddPatient = false,
  });

  final Patient patient;
  final bool fromAddPatient;

  @override
  State<PatientPage> createState() => _PatientPageState();
}

class _PatientPageState extends State<PatientPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _refreshHome = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    _tabController.animateTo(1);
  }

  Route<bool> _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => BlocProvider(
        create: (_) => TreatmentCubit(widget.patient.id),
        child: AddTreatmentPage(patientAge: widget.patient.age),
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0, 1);
        const end = Offset.zero;
        const curve = Curves.ease;

        final tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PatientBloc, PatientState>(
      listener: (context, state) {
        if (state.status.hasError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              duration: const Duration(seconds: 1),
            ),
          );
        }
      },
      child: BlocBuilder<PatientBloc, PatientState>(
        builder: (context, state) {
          if (state.status == PatientStatus.initial) {
            return const Center(child: RefreshProgressIndicator());
          }

          return WillPopScope(
            onWillPop: () async => false,
            child: PatientScaffold(
              onBackTap: () {
                // Update only if there is something changed

                if (_refreshHome || widget.fromAddPatient) {
                  context.read<PatientListBloc>()
                    ..add(const PatientsFetched())
                    ..add(const UpdateVisitorCount());
                }
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              patient: widget.patient,
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButton: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(width: 20),
                  if (state.showRecordPayment)
                    SizedBox(
                      height: 44,
                      width: MediaQuery.of(context).size.width / 2 - 24,
                      child: ElevatedButton(
                        onPressed: state.treatmets.isEmpty
                            ? null
                            : () async {
                                final result = await Navigator.push<bool>(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => BlocProvider(
                                      create: (context) => PaymentCubit(
                                        onProcessTeeth: state.onProcessTeeth,
                                        patientId: widget.patient.id,
                                      ),
                                      child: AddPaymentPage(
                                        patient: widget.patient,
                                        pendingPayment: state.pendingPayment,
                                        nextSchedule: state.nextSchedule,
                                      ),
                                    ),
                                  ),
                                );

                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  if (result ?? false) {
                                    _refreshHome = true;
                                    _tabController.animateTo(0);
                                    context
                                        .read<PatientBloc>()
                                        .add(FetchPatient(widget.patient.id));
                                  }
                                });
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 4,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            'Record Payment',
                            maxLines: 1,
                            style: TextStyle(
                              fontFamily: AppFont.inter,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: AppColor.backgroundColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(width: 8),
                  SizedBox(
                    height: 44,
                    width: MediaQuery.of(context).size.width / 2 - 24,
                    child: ElevatedButton(
                      onPressed: () async {
                        final result =
                            await Navigator.push<bool>(context, _createRoute());

                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (result ?? false) {
                            _refreshHome = true;
                            _tabController.animateTo(1);
                            context
                                .read<PatientBloc>()
                                .add(FetchPatient(widget.patient.id));
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFEBF3FF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: const BorderSide(
                            width: 1.5,
                            color: AppColor.primaryColor,
                          ),
                        ),
                        elevation: 4,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          'Add Rx',
                          style: TextStyle(
                            fontFamily: AppFont.inter,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: AppColor.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
              bottomNavigationBar: SizedBox(
                height:
                    defaultTargetPlatform == TargetPlatform.android ? 72 : 88,
                child: Center(
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.102),
                          blurRadius: 8,
                          offset: Offset(0, -3),
                        )
                      ],
                    ),
                    child: _bottomInfo(state),
                  ),
                ),
              ),
              body: Column(
                children: [
                  DecoratedBox(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom:
                            BorderSide(color: Color(0xFFF4F6F9), width: 1.5),
                      ),
                    ),
                    child: TabBar(
                      tabs: const [
                        Tab(text: 'Timeline'),
                        Tab(text: 'Summary'),
                      ],
                      controller: _tabController,
                      unselectedLabelStyle: AppFontStyle.style4,
                      labelStyle: AppFontStyle.selectedLabelStyle,
                      labelColor: AppColor.textColor,
                      unselectedLabelColor: const Color(0xFF969696),
                      indicatorColor: AppColor.primaryColor,
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        TimelinePage(transactions: state.transactions),
                        SummaryPage(
                          treatmets: state.treatmets,
                          patient: widget.patient,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _bottomInfo(PatientState state) {
    if (state.treatmets.isEmpty) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'There are no payment details',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: AppFont.inter,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Color(0xFF787878),
                ),
              ),
            ],
          ),
        ],
      );
    }

    return Center(
      child: Padding(
        padding: EdgeInsets.only(
          top: defaultTargetPlatform == TargetPlatform.android ? 24 : 10,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Total',
                    textAlign: TextAlign.center,
                    style: AppFontStyle.style9,
                  ),
                  Text(
                    state.totalPayment.toStringAsFixed(0),
                    textAlign: TextAlign.center,
                    style: AppFontStyle.style6,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Received',
                    textAlign: TextAlign.center,
                    style: AppFontStyle.style9,
                  ),
                  Text(
                    state.receivedPayment.toStringAsFixed(0),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: AppFont.inter,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: AppColor.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Pending',
                    textAlign: TextAlign.center,
                    style: AppFontStyle.style9,
                  ),
                  Text(
                    state.pendingPayment.toStringAsFixed(0),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: AppFont.inter,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: AppColor.red,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
