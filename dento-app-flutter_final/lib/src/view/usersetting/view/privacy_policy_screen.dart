import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../global/constants/app_color.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Privacy Policy",
          style: TextStyle(
              color: AppColor.blue, fontSize: 20, fontWeight: FontWeight.w700),
        ),
        elevation: 2,
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColor.blue,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 30, bottom: 30, left: 25, right: 25),
        child: Column(children: [
          Text(
            "This Privacy Policy covers the information we collect about you when you use our products or services, or otherwise interact with us (for example, by attending our premisfffes or events or by communicating with us), unless a different policy is displayed.  Atlassian, we and us refers to Atlassian Pty Ltd, Atlassian, Inc. and any of our corporate affiliates.  We offer a wide range of products, including our cloud, server and data center products.  We refer to all of these products, together with our other services a websites as ${"Services"} in this policy.    ",
            style: TextStyle(
                color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "This policy also explains your choices surrounding how we use information about you, which include how you can object to certain uses of information about you and how you can access and update certain information about you.  If you do not agree with this policy, do not access or use our Services or interact with any other aspect of our business.",
            style: TextStyle(
                color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "Where we provide the Services under contract with an organization (for example, your employer) that organization controls the information processed by the Services. For more information, please see Notice to End Users below. This policy does not apply to the extent we process personal information in the role of a processor on behalf of such organizations.",
            style: TextStyle(
                color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "What information we collect about you We collect information about you when you provide it to us, when you use our Services, and when other sources provide it to us, as further described below.",
            style: TextStyle(
                color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "Information you provide to ussuch as to allow you to access, store, share and edit certain content from a third-party through our Services.  For example, you may authorize our Services to access, display and store files from a third-party document-sharing service within the Services interface. Or you may authorize our Services to connect with a third-party calendaring service or to sync a contact list or address book so that your meetings and connections are available to you through the Services, so you can invite ",
            style: TextStyle(
                color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400),
          )
        ]),
      ),
    );
  }
}
