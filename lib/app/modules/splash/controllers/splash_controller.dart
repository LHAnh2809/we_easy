import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class SplashController extends GetxController {
  void getTime() {
    Timer(const Duration(seconds: 2), () {
      checkLoginStatus();
    });
  }

  Future<void> checkLoginStatus() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    // Kiểm tra xem người dùng đã đăng nhập hay chưa
    if (auth.currentUser != null) {
      print('Người dùng đã đăng nhập');
      Get.offAllNamed(Routes.home);
      // Thực hiện các hành động khi người dùng đã đăng nhập
    } else {
      Get.offAllNamed(Routes.welcome);
      print('Người dùng chưa đăng nhập');
      // Thực hiện các hành động khi người dùng chưa đăng nhập
    }
  }
}
