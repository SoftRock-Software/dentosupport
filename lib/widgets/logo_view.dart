import 'package:dento_support/core/configs/colors.dart';
import 'package:flutter/material.dart';

class LogoView extends StatelessWidget {
  const LogoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                AppAssets.appIcon,
                height: 150,
              ),
            ),
            /*Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 5, top: 1, bottom: 1),
                  decoration: const BoxDecoration(color: Colors.blue),
                  child: const Text(
                    'dento',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(right: 5, top: 1, bottom: 1),
                  decoration: const BoxDecoration(
                    color: Colors.lightBlueAccent,
                  ),
                  child: const Text(
                    'support',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),*/
            const SizedBox(height: 10),
            const Text(
              'Your digital notebook',
              style: TextStyle(
                fontFamily: AppFont.inter,
                fontWeight: FontWeight.w700,
                fontSize: 15,
                color: AppColor.backgroundColor,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
