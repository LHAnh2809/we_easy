import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../controllers/auth_controller.dart';
import 'widgets/sign_in_page.dart';
import 'widgets/sign_up_page.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.isLogin.value = Get.arguments ?? true;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(
        () => SafeArea(
          child: controller.isLogin.value
              ? const SignInPage()
              : const SignUpPage(),
        ),
      ),
    );
  }
}
