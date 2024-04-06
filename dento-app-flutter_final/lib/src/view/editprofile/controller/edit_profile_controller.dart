import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class EditProfileController extends GetxController {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  RxBool isActiveName = false.obs;
  RxBool isActiveEmail = false.obs;
  RxBool isActivePhone = false.obs;
  final editProfileValidation = GlobalKey<FormState>();
}
