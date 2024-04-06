import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../global/constants/api_constant.dart';
import '../../../../../global/constants/app_color.dart';
import '../../../../../global/constants/size_constant.dart';
import '../../../../../global/utils/my_text_field.dart';
import '../../../../../global/utils/uitilities.dart';
import '../../controllers/individual_patient_screen_controller.dart';

class BottomWidgetForRecordPayment extends StatefulWidget {
  IndividualPatientScreenController individualPatientScreenController =
      IndividualPatientScreenController();

  BottomWidgetForRecordPayment(
      {required this.individualPatientScreenController});

  @override
  _BottomWidgetForRecordPaymentState createState() =>
      _BottomWidgetForRecordPaymentState();
}

class _BottomWidgetForRecordPaymentState
    extends State<BottomWidgetForRecordPayment> {
  IndividualPatientScreenController controller =
      IndividualPatientScreenController();

  final focus = FocusNode();

  @override
  void initState() {
    focus.requestFocus();
    controller = widget.individualPatientScreenController;
    // controller.paymentAmount.value.clear();
    controller.isCashTrue.value = false;
    controller.isAddPaymentHistoryActive.value = false;
    ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Form(
        key: controller.addRecordFormKey,
        child: Container(
          height: MySize.getHeight((controller.isAddPaymentHistoryActive.isTrue)
              ? (!isNullEmptyOrFalse(controller.paymentHistoryList))
                  ? 420
                  : 320
              : 190),
          color: Colors.white,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacing.height(15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacing.width(10),
                  InkWell(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        controller.closeAllBottoms();
                        controller.isAddRecordPaymentActive.value = false;
                      },
                      child: Padding(
                        padding: EdgeInsets.only(top: MySize.getHeight(10)),
                        child: Icon(Icons.arrow_back_ios,
                            size: MySize.getHeight(25), color: AppColor.blue),
                      )),
                  Spacing.width(5),
                  Container(
                      width: MySize.getWidth(170),
                      child: getTextField(
                          textEditingController: controller.paymentAmount.value,
                          hintText: "Enter Amount",
                          prefixText: "₹  ",
                          maxLength: 6,
                          numberText6Formatter: true,
                          textInputType: TextInputType.numberWithOptions(),
                          focusNode: focus,
                          validation: (val) {
                            if (isNullEmptyOrFalse(val)) {
                              return "Enter amount";
                            } else if (double.parse(controller
                                        .paymentAmount.value.text
                                        .toString()) <=
                                    0 ||
                                double.parse(controller.paymentAmount.value.text
                                        .toString()) <=
                                    0.0) {
                              return "Wrong amount";
                            } else if (int.parse(controller
                                    .paymentAmount.value.text
                                    .toString()) >
                                double.parse(controller.pendingPayment.value
                                    .toString())) {
                              return "Wrong amount";
                            }
                            return null;
                          },
                          fillColor: Color(0xffEFEFF0))),
                  Spacing.width(15),
                  Padding(
                    padding: EdgeInsets.only(top: MySize.getHeight(13)),
                    child: Text(
                      "Cash",
                      style: TextStyle(
                          fontSize: MySize.getHeight(18),
                          color: AppColor.blue,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Spacing.width(5),
                  Container(
                    width: MySize.getWidth(51),
                    height: MySize.getHeight(31),
                    padding: EdgeInsets.only(top: MySize.getHeight(15)),
                    child: CupertinoSwitch(
                      onChanged: (val) {
                        controller.isCashTrue.value = val;
                        controller.isCashTrue.refresh();
                      },
                      value: controller.isCashTrue.value,
                      activeColor: AppColor.blue,
                    ),
                  ),
                ],
              ),
              if (controller.isAddPaymentHistoryActive.value)
                Padding(
                  padding: const EdgeInsets.only(
                    top: 5.0,
                    left: 46.0,
                  ),
                  child: Row(
                    children: [
                      Text(
                        "Remaining Balance ${NumberFormat.currency(
                          name: "INR",
                          locale: 'en_IN',
                          customPattern: "##,##,###",
                          decimalDigits: 2,
                          // change it to get decimal places
                          symbol: '₹ ',
                        ).format(double.parse(controller.pendingPayment.value.toString())).toString()}",
                        style: TextStyle(
                          color: AppColor.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              Spacing.height(24),
              if (!controller.isAddPaymentHistoryActive.value)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        print(controller.patientId +
                            " ==>" +
                            controller.clinicId);
                        controller.isAddPaymentHistoryActive.toggle();
                        controller.callGetPaymentHistoryListApi(
                            context: context, patientId: controller.patientId);
                      },
                      child: Text(
                        "Payment History",
                        style: TextStyle(
                            fontSize: MySize.getHeight(16),
                            color: AppColor.blue),
                      ),
                    ),
                    Spacing.width(30),
                    Center(
                      child: InkWell(
                        onTap: () {
                          if (controller.addRecordFormKey.currentState!
                              .validate()) {
                            controller.callAddPaymentApi(
                                context: context,
                                patientId: controller.patientId);
                          }
                        },
                        child: getButton(
                            title: "Record Payment",
                            height: 43,
                            width: 162,
                            fontSize: 15,
                            borderRadius: 20),
                      ),
                    ),
                  ],
                )
              else
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: MySize.getWidth(30)),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          onTap: () {
                            print(controller.patientId +
                                " ==>" +
                                controller.clinicId);
                            controller.isAddPaymentHistoryActive.toggle();
                            setState(() {});
                          },
                          child: Text(
                            "Payment History",
                            style: TextStyle(
                                fontSize: MySize.getHeight(16),
                                fontWeight: FontWeight.w600,
                                color: AppColor.blue),
                          ),
                        ),
                      ),
                      Spacing.height(10),
                      Container(
                        height: MySize.getHeight(
                            (!isNullEmptyOrFalse(controller.paymentHistoryList))
                                ? 200
                                : 100),
                        child: (controller.hasPaymentDataData.isFalse)
                            ? Center(
                                child: CircularProgressIndicator(
                                    color: AppColor.blue),
                              )
                            : (!isNullEmptyOrFalse(
                                    controller.paymentHistoryList))
                                ? ListView.separated(
                                    itemBuilder: (context, index) {
                                      return Container(
                                        width: MySize.getWidth(250),
                                        alignment: Alignment.center,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              DateFormat("dd-MMMM-yyyy").format(
                                                  controller
                                                      .paymentHistoryList[index]
                                                      .dateTimeCreatedAt!),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize:
                                                      MySize.getHeight(15)),
                                            ),
                                            Text(
                                              NumberFormat.currency(
                                                name: "INR",
                                                locale: 'en_IN',
                                                customPattern: "##,##,###",
                                                decimalDigits: 0,
                                                // change it to get decimal places
                                                symbol: '₹ ',
                                              )
                                                  .format(double.parse(
                                                      controller
                                                          .paymentHistoryList[
                                                              index]
                                                          .amount
                                                          .toString()))
                                                  .toString(),
                                              style: TextStyle(
                                                  color: AppColor.blue,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize:
                                                      MySize.getHeight(14)),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return Spacing.height(10);
                                    },
                                    itemCount:
                                        controller.paymentHistoryList.length)
                                : Center(
                                    child: Container(
                                        child: Text("No Payment history....")),
                                  ),
                      ),
                      Spacing.height(30),
                      Center(
                        child: InkWell(
                          onTap: () {
                            if (controller.addRecordFormKey.currentState!
                                .validate()) {
                              controller.callAddPaymentApi(
                                  context: context,
                                  patientId: controller.patientId);
                            }
                          },
                          child: getButton(
                            title: "Record Payment",
                            height: 43,
                            width: 162,
                            fontSize: 15,
                            borderRadius: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      );
    });
  }
}
