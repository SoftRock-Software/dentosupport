import 'package:dento_support/core/configs/colors.dart';
import 'package:dento_support/core/extensions/list_extension.dart';
import 'package:dento_support/core/services/local_storage_service.dart';
import 'package:dento_support/core/utils/date_format_utils.dart';
import 'package:dento_support/features/clinic/views/clinic_page.dart';
import 'package:dento_support/features/patients/presentation/bloc/patient_list_bloc.dart';
import 'package:dento_support/features/patients/presentation/bloc/search_bloc.dart';
import 'package:dento_support/features/patients/presentation/views/calendar_list_view.dart';
import 'package:dento_support/features/patients/presentation/views/patients_list_view.dart';
import 'package:dento_support/features/patients/presentation/views/search_page.dart';
import 'package:dento_support/features/patients/presentation/widgets/clinic_profile_widget.dart';
import 'package:dento_support/features/patients/presentation/widgets/status_info_widget.dart';
import 'package:dento_support/injector.dart';
import 'package:dento_support/routers/route_utils.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// Controller to scroll or jump to a particular item.
  late ItemScrollController _itemScrollController;

  @override
  void initState() {
    _itemScrollController = ItemScrollController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PatientListBloc, PatientListState>(
      listener: (context, state) {
        if (state.status.hasError) {
          // ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              duration: const Duration(seconds: 1),
            ),
          );
        }

        if (state.status.isSuccess &&
            state.dates.isNotEmpty &&
            state.dateString == 'Today') {
          Future.delayed(const Duration(milliseconds: 200), () {
            _itemScrollController.scrollTo(
              index: 12,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOutCubic,
            );
          });
        }
      },
      child: BlocBuilder<PatientListBloc, PatientListState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color(0xFFF3F3F3),
            appBar: AppBar(
              backgroundColor: const Color(0xFFF3F3F3),
              systemOverlayStyle: const SystemUiOverlayStyle(
                systemNavigationBarColor: Color(0xFFF3F3F3),
                systemNavigationBarDividerColor: Color(0xFFF3F3F3),
                systemNavigationBarIconBrightness: Brightness.light,
                statusBarColor: Color(0xFFF3F3F3),
                statusBarBrightness: Brightness.light,
                statusBarIconBrightness: Brightness.dark,
              ),
              title: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.05),
                      blurRadius: 4,
                      offset: Offset(0, 4),
                    )
                  ],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: AppColor.primaryColor,
                    ),
                    hintText: 'Search & Add Patients',
                    hintStyle: AppFontStyle.hintStyle,
                    suffixIcon: ClinicProfileWidget(
                      name: getIt<LocalStorageService>().user.clinicName,
                      address: getIt<LocalStorageService>().user.clinicLocation,
                      ownerName: getIt<LocalStorageService>().user.initials,
                      onTap: () => context.push(AppPage.settings.toPath),
                      addNewClinic: () async {
                        final result = await Navigator.of(context).push<bool>(
                          MaterialPageRoute(
                            builder: (_) => const ClinicPage(),
                          ),
                        );

                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (result ?? false) {
                            context.read<PatientListBloc>()
                              ..add(const PatientsFetched())
                              ..add(const UpdateVisitorCount());
                          }
                        });
                      },
                      onChangeClinic: (index) {
                        final user = getIt<LocalStorageService>().user;
                        final newClinics = user.clinics..swap(0, index);

                        // Update user again
                        user.copyWith(clinics: newClinics);
                        getIt<LocalStorageService>().setUser(user);

                        context.read<PatientListBloc>()
                          ..add(const PatientsFetched())
                          ..add(const UpdateVisitorCount());
                      },
                    ),
                  ),
                  readOnly: true,
                  onTap: () => _goToSearch(context),
                ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton:
                _searchButton(onPressed: () => _goToSearch(context)),
            bottomNavigationBar: SizedBox(
              height: defaultTargetPlatform == TargetPlatform.android ? 72 : 88,
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
                  child: state.showFuture
                      ? Center(
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  '${state.futurePatients} Patients',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontFamily: AppFont.inter,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                    color: AppColor.primaryColor,
                                  ),
                                ),
                              ),
                              const Expanded(child: Text('')),
                              const Expanded(child: Text('')),
                            ],
                          ),
                        )
                      : state.isTodayAndEmpty
                          ? const Center(
                              child: Text(
                                'Nothing to show here',
                                style: TextStyle(
                                  fontFamily: AppFont.inter,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color: Color(0xFF8C8C8C),
                                ),
                              ),
                            )
                          : StatusInfoWidget(
                              cash: state.cashAmount.toString(),
                              total: state.totalAmount.toString(),
                              pending: state.pendingVisitor.toString(),
                              visited: state.visited.toString(),
                            ),
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  CalendarListView(
                    state.dates,
                    itemScrollController: _itemScrollController,
                    onDateSelect: (date) {
                      if (date.dayOff) {
                        if ((date.badge ?? 0) > 0 || date.dateTime.isToday) {
                          context.read<PatientListBloc>().add(SelectDate(date));
                        }
                      } else {
                        context.read<PatientListBloc>().add(SelectDate(date));
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(state.dateString, style: AppFontStyle.style6),
                        TextButton(
                          onPressed: () async {
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
                                        foregroundColor: AppColor
                                            .primaryColor, // button text color
                                      ),
                                    ),
                                  ),
                                  child: child!,
                                );
                              },
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now()
                                  .add(const Duration(days: -365)),
                              lastDate:
                                  DateTime.now().add(const Duration(days: 365)),
                            );

                            if (picked != null) {
                              if (!mounted) return;

                              context.read<PatientListBloc>().add(
                                    SelectDate(
                                      VisitorCalendar(dateTime: picked),
                                    ),
                                  );
                            }
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text(
                            'View Calendar',
                            style: AppFontStyle.style10,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const PatientsListView(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _goToSearch(BuildContext context) {
    Navigator.push<void>(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (context) => SearchBloc()..add(const MissedPatientsFetched()),
          child: const SearchPage(),
        ),
      ),
    );
  }

  Widget scheduleButton({required void Function()? onPressed}) =>
      FloatingActionButton.extended(
        elevation: 4,
        backgroundColor:
            onPressed == null ? const Color(0xFFE6E6E6) : AppColor.primaryColor,
        extendedPadding:
            const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
        label: Text(
          'Schedule',
          style: AppFontStyle.style7.copyWith(
            color: onPressed == null ? const Color(0xFF8C8C8C) : null,
          ),
        ),
        onPressed: onPressed,
      );

  Widget _searchButton({required void Function()? onPressed}) => SizedBox(
        height: 43,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(21.5)),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.161),
                blurRadius: 6,
                offset: Offset(0, 3),
              )
            ],
          ),
          child: FloatingActionButton.extended(
            elevation: 0,
            backgroundColor: onPressed == null
                ? const Color(0xFFE6E6E6)
                : AppColor.primaryColor,
            extendedPadding:
                const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            label: const Text('Search & Add', style: AppFontStyle.style7),
            onPressed: onPressed,
          ),
        ),
      );
}
