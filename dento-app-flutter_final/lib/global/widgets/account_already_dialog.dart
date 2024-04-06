import 'package:Dentosupport_mini/global/constants/app_color.dart';
import 'package:flutter/material.dart';

class AccountAlreadyDialog extends StatelessWidget {
  const AccountAlreadyDialog({
    Key? key,
    required this.onCancel,
    required this.onDone,
    required this.continueWith,
    required this.email,
    required this.mobileNumber,
  }) : super(key: key);

  final VoidCallback onCancel;
  final VoidCallback onDone;
  final VoidCallback continueWith;
  final String email;
  final String mobileNumber;

  _dialogContent(
    BuildContext context,
  ) {
    return Wrap(
      runAlignment: WrapAlignment.center,
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(
            horizontal: 25,
          ),
          padding: const EdgeInsets.only(
            bottom: 10,
          ),
          decoration: BoxDecoration(
            color: AppColor.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(
              15,
            ),
          ),
          child: Material(
            color: AppColor.transparent,
            borderRadius: BorderRadius.circular(
              15,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        padding: const EdgeInsets.all(
                          0,
                        ),
                        onPressed: () {},
                        icon: Icon(
                          Icons.cancel,
                          color: AppColor.transparent,
                          size: 20,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Account Already Exist!",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColor.blue,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        padding: const EdgeInsets.all(
                          0,
                        ),
                        onPressed: () {
                          onCancel();
                        },
                        icon: Icon(
                          Icons.cancel,
                          color: AppColor.black.withOpacity(0.25),
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Text(
                  "$mobileNumber is already linked to $email",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColor.black,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    onDone();
                  },
                  child: Container(
                    height: 40,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColor.blue,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(
                      left: 17,
                      right: 17,
                      top: 13,
                      bottom: 7,
                    ),
                    padding: EdgeInsets.only(
                      left: 17,
                      right: 17,
                      top: 11,
                      bottom: 10,
                    ),
                    child: FittedBox(
                      child: Text(
                        "Switch to $email",
                        style: TextStyle(
                          color: AppColor.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    continueWith();
                  },
                  child: Text(
                    "Continue with different phone number",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColor.red,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return _dialogContent(
      context,
    );
  }
}
