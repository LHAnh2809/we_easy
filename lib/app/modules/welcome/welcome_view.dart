import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/util/exports.dart';
import '../../routes/app_pages.dart';
import '../widgets/animations/left_to_right_animation.dart';
import '../widgets/custom_elevated_button.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(width: 0.0, height: 50.h),
            LeftToRightAnimation(
              delay: 0.ms,
              child: Hero(
                tag: "Logo",
                child: AppImages.svg(AppImages.logoAppImg,
                    width: 95.w, height: 95.h),
              ),
            ),
            SizedBox(width: 0.0, height: 16.h),
            LeftToRightAnimation(
              delay: 200.ms,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.w),
                child: AppImages.svg(AppImages.illustration,
                    width: 355.w, height: 319.h),
              ),
            ),
            SizedBox(width: 0.0, height: 70.h),
            LeftToRightAnimation(
              delay: 300.ms,
              child: CustomElevatedButton(
                title: 'Đăng nhập',
                minWidth: 220.w,
                onPressed: () {
                  Get.offAllNamed(Routes.auth, arguments: true);
                  print('Đăng nhập');
                },
              ),
            ),
            SizedBox(width: 0.0, height: 16.h),
            LeftToRightAnimation(
              delay: 400.ms,
              child: CustomElevatedButton(
                title: 'Đăng ký',
                minWidth: 220.w,
                onPressed: () {
                  Get.offAllNamed(Routes.auth, arguments: false);
                  print('Đăng ký');
                },
              ),
            ),
            SizedBox(width: 0.0, height: 16.h)
          ],
        ),
      ),
    );
  }
}
