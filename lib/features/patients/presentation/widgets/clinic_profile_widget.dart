import 'package:dento_support/core/configs/colors.dart';
import 'package:dento_support/core/services/local_storage_service.dart';
import 'package:dento_support/features/clinic/models/clinic.dart';
import 'package:dento_support/injector.dart';
import 'package:flutter/material.dart';
import 'package:popover/popover.dart';

class ClinicProfileWidget extends StatelessWidget {
  const ClinicProfileWidget({
    super.key,
    required this.name,
    required this.address,
    required this.ownerName,
    this.onTap,
    this.addNewClinic,
    this.onChangeClinic,
  });

  final String name;
  final String address;
  final String ownerName;
  final void Function()? onTap;
  final void Function()? addNewClinic;
  final void Function(int index)? onChangeClinic;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final clinics = getIt<LocalStorageService>().user.clinics;

        final clinicsCount = clinics.length;

        var height = 0.0;
        if (clinicsCount >= 3) {
          height = 60 * 3;
        } else {
          height = 60 * (clinicsCount + 1);
        }

        showPopover(
          context: context,
          bodyBuilder: (context) => ClinicListItems(
            clinics: clinics,
            onAddNew: () {
              Navigator.of(context).pop();
              addNewClinic?.call();
            },
            onChangeClinic: onChangeClinic,
          ),
          direction: PopoverDirection.bottom,
          width: 150,
          height: height + 1,
          arrowHeight: 15,
          arrowWidth: 30,
          backgroundColor: AppColor.primaryColor,
          radius: 20,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: AppColor.primaryColor,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(width: 5),
            Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width / 5,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: AppFont.inter,
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      color: AppColor.primaryColor,
                    ),
                  ),
                  Text(
                    address,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: AppFont.inter,
                      fontWeight: FontWeight.w500,
                      fontSize: 10,
                      color: AppColor.subtitleColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 9),
            Container(
              width: 1,
              height: 33,
              color: AppColor.primaryColor,
            ),
            const SizedBox(width: 3),
            GestureDetector(
              onTap: onTap,
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: AppColor.primaryColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text(
                    ownerName,
                    style: const TextStyle(
                      fontFamily: AppFont.inter,
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      color: Color(0xFFF3F3F3),
                    ),
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

class ClinicListItems extends StatelessWidget {
  const ClinicListItems({
    super.key,
    required this.clinics,
    this.onAddNew,
    this.onChangeClinic,
  });

  final List<Clinic> clinics;
  final void Function()? onAddNew;
  final void Function(int index)? onChangeClinic;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColor.primaryColor,
      child: ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: clinics.length + 1,
        itemBuilder: (context, index) {
          if (index == clinics.length) {
            return SizedBox(
              height: 60,
              child: InkWell(
                onTap: onAddNew,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.add,
                      color: AppColor.backgroundColor,
                      size: 30,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Add Clinic',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: AppFont.inter,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: AppColor.backgroundColor,
                      ),
                    )
                  ],
                ),
              ),
            );
          } else {
            return _buildClinicItemView(context, index);
          }
        },
        separatorBuilder: (context, index) => Container(
          height: 0.3,
          color: index == 2 ? null : Colors.white,
        ),
      ),
    );
  }

  SizedBox _buildClinicItemView(BuildContext context, int index) {
    return SizedBox(
      height: 60,
      child: InkWell(
        onTap: () {
          debugPrint('Switch clinic');
          Navigator.of(context).pop();
          onChangeClinic?.call(index);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 15, left: 10),
              child: Text(
                clinics[index].name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontFamily: AppFont.inter,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: AppColor.backgroundColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15, left: 10),
              child: Text(
                clinics[index].location,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontFamily: AppFont.inter,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: AppColor.hintColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
