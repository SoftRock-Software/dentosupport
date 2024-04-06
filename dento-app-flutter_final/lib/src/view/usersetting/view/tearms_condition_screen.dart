import 'package:Dentosupport_mini/global/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TearmsAndConditionScreen extends StatelessWidget {
  const TearmsAndConditionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Terms and Conditions",
            style: TextStyle(
                color: AppColor.blue,
                fontSize: 20,
                fontWeight: FontWeight.w700),
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
          padding: EdgeInsets.only(top: 25, left: 27, right: 27, bottom: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "The Facebook company is now Meta. We've updated our Terms of Use, Data Policy and Cookies Policy to reflect the new name on 4 January 2022. While our company name has changed, we are continuing to offer the same products, including Instagram from Meta. Our Data Policy and Terms of Use remain in effect, and this name change does not affect how we use or share data. Learn more about Meta and our vision for the metaverse.",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                "Welcome to Instagram!",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "These Terms of Use (or ${"Teams"}) govern your use of Instagram, except where we expressly state that separate terms (and not these) apply, and provide information about the Instagram Service (the ${"Service"}), outlined below. When you create an Instagram account or use Instagram, you agree to these Terms. The Meta Terms of Service do not apply to this Service.",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "The Instagram Service is one of the Meta Products, provided to you by Meta Platforms, Inc. These Terms of Use therefore constitute an agreement between you and Meta Platforms, Inc.",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                " The Instagram Service",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              Text(
                "We agree to provide you with the Instagram Service. The Service includes all of the Instagram products, features, applications, services, technologies, and software that we provide to advance Instagram's mission: To bring you closer to the people and things you love. The Service is made up of the following aspects:Offering personalized opportunities to create, connect, communicate, discover, and share.People are different. We want to strengthen your relationships through shared experiences you actually care about. So we build systems that try to understand who and what you and others care about, and use that information to help you create, find, join, and share in experiences that matter to you. Part of that is highlighting content, features, offers, and accounts you might be interested in, and offering ways for you to experience Instagram, based on things you and others do on and off Instagram.Fostering a positive, inclusive, and safe environment.We develop and use tools and offer resources to our community members that help to make their experiences positive and inclusive, including when we think they might need help. We also have teams and systems that work to combat abuse and violations of our Terms and policies, as well as harmful and deceptive behavior. We use all the information we have-including your information-to try to keep our platform secure. We also may share information about misuse or harmful content with other Meta Companies or law enforcement. Learn more in the Data Policy.Developing and using technologies that help us consistently serve our growing community.Organizing and analyzing information for our growing community is central to our Service. A big part of our Service is creating and using cutting-edge technologies that help us personalize, protect, and improve our Service on an incredibly large scale for a broad global community. Technologies like artificial intelligence and machine learning give us the power to apply complex processes across our Service. Automated technologies also help us ensure the functionality and integrity of our Service.Providing consistent and seamless experiences across other Meta Company Products.Instagram is part of the Meta Companies, which share technology, systems, insights, and information-including the information we have about you (learn more in the Data Policy) in order to provide services that are better, safer, and more secure. We also provide ways to interact across the Meta Company Products that you use, and designed systems to achieve a seamless and consistent experience across the Meta Company Products.Ensuring access to our Service.To operate our global Service, we must store and transfer data across our systems around the world, including outside of your country of residence. The use of this global infrastructure is necessary and essential to provide our Service. This infrastructure may be owned or operated by Meta Platforms, Inc., Meta Platforms Ireland Limited, or their affiliates.Connecting you with brands, products, and services in ways you care about.We use data from Instagram and other Meta Company Products, as well as from third-party partners, to show you ads, offers, and other sponsored content that we believe will be meaningful to you. And we try to make that content as relevant as all your other experiences on Instagram.${"Research and innovation.We use the information we have to study our Service and collaborate with others on research to make our Service better and contribute to the well-being of our community."}",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ));
  }
}
