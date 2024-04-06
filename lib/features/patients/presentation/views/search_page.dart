import 'package:dento_support/core/configs/colors.dart';
import 'package:dento_support/core/services/local_storage_service.dart';
import 'package:dento_support/core/utils/date_format_utils.dart';
import 'package:dento_support/features/patients/models/search_response.dart';
import 'package:dento_support/features/patients/presentation/bloc/patient_list_bloc.dart';
import 'package:dento_support/features/patients/presentation/bloc/search_bloc.dart';
import 'package:dento_support/features/patients/presentation/widgets/search_item_widget.dart';
import 'package:dento_support/injector.dart';
import 'package:dento_support/routers/route_utils.dart';
import 'package:dento_support/routers/router.dart';
import 'package:dento_support/widgets/schedule_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    _focusNode.requestFocus();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFFF3F3F3),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: const Color(0xFFF3F3F3),
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
                  suffixIcon: IconButton(
                    icon: Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        color: const Color(0xFFDADADA),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.clear_rounded,
                          color: Colors.white,
                          size: 17,
                        ),
                      ),
                    ),
                    onPressed: () {
                      _textController.clear();
                      Navigator.pop(context);
                    },
                  ),
                  hintText: 'Type to Search',
                  hintStyle: AppFontStyle.hintStyle,
                ),
                // autofocus: true,
                focusNode: _focusNode,
                controller: _textController,
                textCapitalization: TextCapitalization.words,
                onChanged: (text) =>
                    context.read<SearchBloc>().add(TextChanged(text: text)),
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton:
              state.status == SearchStatus.search && state.isNotSchedule
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Cannot find the patient?',
                          style: TextStyle(
                            fontFamily: AppFont.inter,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: Color(0xFF898A8D),
                          ),
                        ),
                        const SizedBox(height: 12),
                        FloatingActionButton.extended(
                          elevation: 4,
                          backgroundColor: const Color(0xFFEBF3FF),
                          extendedPadding: const EdgeInsets.symmetric(
                            horizontal: 25,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side: const BorderSide(
                              width: 1.5,
                              color: AppColor.primaryColor,
                            ),
                          ),
                          icon: const Icon(
                            Icons.add,
                            color: AppColor.primaryColor,
                          ),
                          label: const Text(
                            'Add New Patient',
                            style: TextStyle(
                              fontFamily: AppFont.inter,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: AppColor.primaryColor,
                            ),
                          ),
                          onPressed: () => context.push(
                            AppPage.addPatient.toPath,
                            extra: PatientExtra(name: state.searchTerm),
                          ),
                        ),
                      ],
                    )
                  : null,
          body: state.searchResult.isEmpty &&
                  state.status == SearchStatus.noSearch
              ? const EmptyPatientWidget()
              : Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        state.status == SearchStatus.noSearch
                            ? 'Missed Patients from last 7 days'
                            : 'Search Results',
                        style: const TextStyle(
                          fontFamily: AppFont.inter,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: Color(0xFF898A8D),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 3.5,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.searchResult.length,
                          itemBuilder: (context, index) {
                            final searchResult = state.searchResult[index];

                            return InkWell(
                              onTap: () async {
                                final patient = await context
                                    .read<SearchBloc>()
                                    .getPatientWithId(searchResult.id);
                                if (patient != null) {
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    context.push(
                                      AppPage.patient.toPath,
                                      extra: PatientExtraNew(patient: patient),
                                    );
                                  });
                                }
                              },
                              child: SearchItemWidget(
                                name: searchResult.name,
                                mobile: searchResult.mobile,
                                fromSearch: state.status == SearchStatus.search,
                                onSchedule: () async {
                                  // Hide focus
                                  _focusNode.unfocus();

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
                                                  AppColor.primaryColor,
                                            ),
                                          ),
                                        ),
                                        child: child!,
                                      );
                                    },
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.now()
                                        .add(const Duration(days: 365)),
                                  );

                                  debugPrint('Picked $picked');
                                  if (picked != null) {
                                    final clinic = getIt<LocalStorageService>()
                                        .user
                                        .clinics
                                        .first;
                                    final dayOff = clinic.dayOff;
                                    final contains = dayOff.contains(
                                      DateFormatUtils.fullWeekDay(picked)
                                          .toLowerCase(),
                                    );

                                    if (!mounted) return;

                                    if (contains) {
                                      context.read<SearchBloc>().add(
                                            const OpenSchedule(schedule: false),
                                          );

                                      showScheduleSheet(
                                        context,
                                        onSchedule: () async {
                                          await _schedulePatient(
                                            context,
                                            searchResult,
                                            picked,
                                          );
                                        },
                                        onCancel: () {
                                          _focusNode.requestFocus();
                                          context.read<SearchBloc>().add(
                                                const OpenSchedule(
                                                  schedule: true,
                                                ),
                                              );
                                        },
                                      );
                                    } else {
                                      await _schedulePatient(
                                        context,
                                        searchResult,
                                        picked,
                                      );
                                    }
                                  }
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }

  Future<void> _schedulePatient(
    BuildContext context,
    SearchResult searchResult,
    DateTime picked,
  ) async {
    await context.read<SearchBloc>().schedulePatient(
          searchResult.id,
          picked,
        );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Patient scheduled successfully'),
        duration: Duration(seconds: 1),
      ),
    );

    context.read<PatientListBloc>()
      ..add(const PatientsFetched())
      ..add(const UpdateVisitorCount());

    Navigator.pop(context);
  }
}

class EmptyPatientWidget extends StatelessWidget {
  const EmptyPatientWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 100,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 50),
              Image.asset(
                AppAssets.emptySearch,
                height: 166,
              ),
              const SizedBox(height: 15),
              const Text(
                'Get Started with Search',
                style: TextStyle(
                  fontFamily: AppFont.inter,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: AppColor.primaryColor,
                ),
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 70),
                child: Text(
                  'Search with Patient name or Phone number',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: AppFont.inter,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: Color(0xFF464665),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
