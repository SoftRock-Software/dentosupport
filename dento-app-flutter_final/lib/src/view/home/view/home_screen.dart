import 'dart:io';

import 'package:Dentosupport_mini/global/constants/app_asset.dart';
import 'package:Dentosupport_mini/global/constants/app_color.dart';
import 'package:Dentosupport_mini/global/constants/app_string.dart';
import 'package:Dentosupport_mini/global/constants/size_constant.dart';
import 'package:Dentosupport_mini/global/services/date_picker/date_picker_widget.dart';
import 'package:Dentosupport_mini/global/utils/uitilities.dart';
import 'package:Dentosupport_mini/src/view/home/component/common_name_dot_colum.dart';
import 'package:Dentosupport_mini/src/view/home/component/empty_schedule_patients_view.dart';
import 'package:Dentosupport_mini/src/view/home/component/home_screen_bottom.dart';
import 'package:Dentosupport_mini/src/view/home/component/past_day_view.dart';
import 'package:Dentosupport_mini/src/view/home/component/unlock_date_view.dart';
import 'package:Dentosupport_mini/src/view/home/controller/home_controller.dart';
import 'package:Dentosupport_mini/src/view/search/view/search_screen.dart';
import 'package:Dentosupport_mini/src/view/usersetting/view/user_setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends GetWidget<HomeController> {
  HomeScreen({Key? key}) : super(key: key);

  final DatePickerController _controller = DatePickerController();
  final DateTime _selectedValue = DateTime.now();

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor: AppColor.greyBackground,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 21.0,
                left: 21,
                right: 20,
              ),
              child: TextFormField(
                onTap: () {
                  Get.to(() => const SearchScreen());
                },
                // controller: controller.otp,
                // textAlign: TextAlign.start,
                textInputAction: TextInputAction.done,
                style: const TextStyle(
                  color: AppColor.blackText,
                  fontWeight: FontWeight.normal,
                  fontSize: 15,
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(
                    left: 24,
                    top: 0,
                    right: 0,
                    bottom: 0,
                  ),
                  prefixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10.0,
                          right: 10,
                          top: 10,
                          bottom: 10,
                        ),
                        child: Image.asset(
                          AppAsset.search,
                          height: 24,
                          width: 24,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  ),
                  suffixIcon: Obx(
                    () => controller.filerList.isEmpty
                        ? const SizedBox()
                        : PopupMenuButton(
                            color: AppColor.blue,
                            padding: const EdgeInsets.all(0),
                            splashRadius: 15,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  15.0,
                                ),
                              ),
                            ),
                            onSelected: (
                              int index,
                            ) {
                              if (controller.filerList.length - 1 != index) {
                                controller.selectedFilter.value = index;
                              }
                            },
                            itemBuilder: (context) {
                              return List.generate(controller.filerList.length,
                                  (index) {
                                return PopupMenuItem(
                                  value: index,
                                  child: controller.filerList.length - 1 ==
                                          index
                                      ? Container(
                                          padding: const EdgeInsets.only(
                                            left: 16,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColor.blue,
                                            borderRadius: BorderRadius.circular(
                                              15,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              const Text(
                                                AppString.addClinic,
                                                style: TextStyle(
                                                  color: AppColor.white,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                  top: 6,
                                                  // bottom: 6,
                                                  left: 8,
                                                  right: 5.5,
                                                ),
                                                width: 1,
                                                height: 25,
                                                decoration: const BoxDecoration(
                                                  color: AppColor.white,
                                                ),
                                              ),
                                              const Icon(
                                                Icons.add,
                                                color: AppColor.white,
                                              ),
                                            ],
                                          ),
                                        )
                                      : Container(
                                          padding: const EdgeInsets.only(
                                            left: 16,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColor.blue,
                                            borderRadius: BorderRadius.circular(
                                              15,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    // AppString.smileClinic,
                                                    controller.filerList[index]
                                                        ["title"],
                                                    style: const TextStyle(
                                                      color: AppColor.white,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                  Text(
                                                    // AppString.kalyan,
                                                    controller.filerList[index]
                                                        ["description"],
                                                    style: const TextStyle(
                                                      color: AppColor.white,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                  top: 6,
                                                  // bottom: 6,
                                                  left: 8,
                                                  right: 5.5,
                                                ),
                                                width: 1,
                                                height: 25,
                                                decoration: const BoxDecoration(
                                                  color: AppColor.white,
                                                ),
                                              ),
                                              Icon(
                                                controller.selectedFilter
                                                            .value ==
                                                        index
                                                    ? Icons
                                                        .radio_button_on_rounded
                                                    : Icons
                                                        .radio_button_unchecked_rounded,
                                                color: AppColor.white,
                                              ),
                                            ],
                                          ),
                                        ),
                                );
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.only(
                                left: 16,
                              ),
                              decoration: BoxDecoration(
                                color: AppColor.blue,
                                borderRadius: BorderRadius.circular(
                                  15,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        // AppString.smileClinic,
                                        controller.filerList[controller
                                            .selectedFilter.value]["title"],
                                        style: const TextStyle(
                                          color: AppColor.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        // AppString.kalyan,
                                        controller.filerList[controller
                                            .selectedFilter
                                            .value]["description"],
                                        style: const TextStyle(
                                          color: AppColor.lightWhite,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                      top: 6,
                                      bottom: 6,
                                      left: 8,
                                      right: 5.5,
                                    ),
                                    width: 1,
                                    height: 25,
                                    decoration: BoxDecoration(
                                      color: AppColor.white.withOpacity(
                                        0.5,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                      right: 4,
                                    ),
                                    width: 30,
                                    height: 30,
                                    decoration: const BoxDecoration(
                                      color: AppColor.greyBackground,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Center(
                                      child: Text(
                                        AppString.as,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: AppColor.blue,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ),
                  fillColor: AppColor.white,
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: AppColor.red,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: AppColor.whiteBackground,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: AppColor.whiteBackground,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  filled: true,
                  hintText: AppString.addSearchPatients,
                  hintStyle: const TextStyle(
                    color: AppColor.lightGreyText,
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  ),
                  border: const OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 14.0,
                bottom: 14.0,
                left: 5.0,
                right: 5.0,
              ),
              child: DatePicker(
                DateTime.now(),
                controller: _controller,
                initialSelectedDate: DateTime(
                  DateTime.now().year,
                  DateTime.now().month,
                  DateTime.now().day + 2,
                ),
                inactiveDates: [DateTime.now()],
                selectionColor: AppColor.blue,
                selectedTextColor: AppColor.white,
                dateTextStyle: const TextStyle(fontSize: 14),
                deactivatedColor: AppColor.black,
                onDateChange: (date) {
                  // New date selected
                  /*setState(
                        () {
                      _selectedValue = date;
                      shareBottomSheet(date: _selectedValue);
                    },
                  );*/
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 26.0,
                right: 20.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    AppString.today,
                    style: TextStyle(
                      color: AppColor.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    AppString.viewCalender,
                    style: TextStyle(
                      color: AppColor.blue,
                      fontWeight: FontWeight.w600,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
            unlockDateView()
          ],
        ),
      ),
      bottomNavigationBar: HomeScreenBottom(),
    );
  }
}
