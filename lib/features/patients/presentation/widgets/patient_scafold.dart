import 'package:dento_support/core/configs/colors.dart';
import 'package:dento_support/features/patients/models/patient.dart';
import 'package:dento_support/features/patients/presentation/bloc/patient_list_bloc.dart';
import 'package:dento_support/routers/route_utils.dart';
import 'package:dento_support/routers/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:popover/popover.dart';
import 'package:url_launcher/url_launcher.dart';

class PatientScaffold extends StatelessWidget {
  const PatientScaffold({
    super.key,
    required Patient patient,
    required Widget body,
    FloatingActionButtonLocation? floatingActionButtonLocation,
    Widget? floatingActionButton,
    Widget? bottomNavigationBar,
    void Function()? onBackTap,
  })  : _patient = patient,
        _child = body,
        _floatingActionButtonLocation = floatingActionButtonLocation,
        _floatingActionButton = floatingActionButton,
        _bottomNavigationBar = bottomNavigationBar,
        _onBackTap = onBackTap;

  final Patient _patient;
  final Widget _child;
  final FloatingActionButtonLocation? _floatingActionButtonLocation;
  final Widget? _floatingActionButton;
  final Widget? _bottomNavigationBar;
  final void Function()? _onBackTap;

  static const _boldStyle = TextStyle(
    fontFamily: AppFont.inter,
    fontWeight: FontWeight.w700,
    fontSize: 20,
    color: AppColor.textColor,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          systemNavigationBarColor: Colors.white,
        ),
        leading: InkWell(
          onTap: () {
            if (_onBackTap != null) {
              _onBackTap?.call();
            } else {
              Navigator.pop(context);
            }
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: AppColor.primaryColor,
          ),
        ),
        title: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _patient.name,
                  textAlign: TextAlign.center,
                  style: _boldStyle,
                ),
                const SizedBox(width: 8),
                Text(
                  '${_patient.genderText} ${_patient.age}',
                  textAlign: TextAlign.center,
                  style: AppFontStyle.textStyle,
                ),
              ],
            ),
            GestureDetector(
              onTap: () async {
                final url = Uri(scheme: 'tel', path: _patient.mobile);
                try {
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  }
                } catch (_) {}
              },
              child: Text(
                _patient.mobile,
                style: AppFontStyle.style4,
              ),
            ),
          ],
        ),
        actions: [IconButtonWidget(patient: _patient)],
      ),
      body: _child,
      floatingActionButtonLocation: _floatingActionButtonLocation,
      floatingActionButton: _floatingActionButton,
      bottomNavigationBar: _bottomNavigationBar,
    );
  }
}

class IconButtonWidget extends StatelessWidget {
  const IconButtonWidget({
    super.key,
    required this.patient,
  });

  final Patient patient;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        showPopover(
          context: context,
          bodyBuilder: (context) => PopupWidget(patient: patient),
          direction: PopoverDirection.bottom,
          width: 80,
          height: 70,
          arrowHeight: 7.5,
          arrowWidth: 15,
          backgroundColor: AppColor.backgroundColor,
          radius: 10,
        );
      },
      icon: const Icon(
        Icons.more_vert,
      ),
    );
  }
}

class PopupWidget extends StatelessWidget {
  const PopupWidget({
    super.key,
    required this.patient,
  });

  final Patient patient;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                  context.push(
                    AppPage.addPatient.toPath,
                    extra: PatientExtra(
                      name: patient.name,
                      patient: patient,
                    ),
                  );
                },
                child: const Text(
                  'Edit',
                  style: TextStyle(color: AppColor.primaryColor),
                ),
              ),
            ),
          ),
          Container(
            height: 1,
            color: const Color(0xFF898A8D),
          ),
          Expanded(
            child: Center(
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                  _showAlertDialog(context);
                },
                child: const Text(
                  'Delete',
                  style: TextStyle(
                    color: AppColor.red,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // This shows a CupertinoModalPopup which hosts a CupertinoAlertDialog.
  void _showAlertDialog(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) =>
          BlocListener<PatientListBloc, PatientListState>(
        listener: (context, state) {
          if (state.status.isDelete) {
            context.read<PatientListBloc>()
              ..add(const PatientsFetched())
              ..add(const UpdateVisitorCount());
            Navigator.of(context).popUntil((route) => route.isFirst);
          }
        },
        child: CupertinoAlertDialog(
          title: const Text('Delete Patient'),
          content: const Text('Are you sure?'),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              /// This parameter indicates the action would perform
              /// a destructive action such as deletion, and turns
              /// the action's text color to red.
              isDestructiveAction: true,
              onPressed: () async {
                Navigator.pop(context);
                context.read<PatientListBloc>().add(PatientDeleted(patient.id));
              },
              child: const Text('Delete'),
            ),
            CupertinoDialogAction(
              /// This parameter indicates this action is the default,
              /// and turns the action's text to bold text.
              isDefaultAction: true,
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }
}
