import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:we_easy/app/common/util/exports.dart';
import 'package:we_easy/app/modules/auth/controllers/auth_controller.dart';

import '../../../widgets/animations/left_to_right_animation.dart';
import '../../../widgets/base_text_widget.dart';
import '../../../widgets/text_field_widget.dart';

class EnterprisePage extends StatelessWidget {
  final AuthController controller;
  const EnterprisePage({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(width: 0.0, height: 15.h),
        LeftToRightAnimation(
          delay: 200.ms,
          child: BaseText(
            text: 'Tên doanh nghiệp',
          ),
        ),
        SizedBox(width: 0.0, height: 6.h),
        LeftToRightAnimation(
          delay: 300.ms,
          child: TextFieldWidget(
            key: controller.KeyCompanyName,
            controller: controller.companyName,
          ),
        ),
        SizedBox(width: 0.0, height: 12.h),
        LeftToRightAnimation(
          delay: 400.ms,
          child: const BaseText(
            text: 'Đăng ký kinh doanh (nếu có)',
          ),
        ),
        SizedBox(width: 0.0, height: 6.h),
        LeftToRightAnimation(
          delay: 500.ms,
          child: TextFieldWidget(
            controller: controller.businessRegistration,
          ),
        ),
        SizedBox(width: 0.0, height: 12.h),
        LeftToRightAnimation(
          delay: 600.ms,
          child: const BaseText(
            text: 'Địa chỉ kinh doanh',
          ),
        ),
        SizedBox(width: 0.0, height: 6.h),
        LeftToRightAnimation(
          delay: 700.ms,
          child: TextFieldWidget(
            key: controller.keyBusinessAddress,
            controller: controller.businessAddress,
          ),
        ),
        SizedBox(width: 0.0, height: 12.h),
        LeftToRightAnimation(
          delay: 800.ms,
          child: const BaseText(
            text: 'Số điện thoại',
          ),
        ),
        SizedBox(width: 0.0, height: 6.h),
        LeftToRightAnimation(
          delay: 900.ms,
          child: TextFieldWidget(
            key: controller.keyPhone,
            controller: controller.phone,
          ),
        ),
        SizedBox(width: 0.0, height: 12.h),
        LeftToRightAnimation(
          delay: 1000.ms,
          child: const BaseText(
            text: 'Email',
          ),
        ),
        SizedBox(width: 0.0, height: 6.h),
        LeftToRightAnimation(
          delay: 1100.ms,
          child: TextFieldWidget(
            key: controller.keyEmail,
            controller: controller.email,
          ),
        ),
        SizedBox(width: 0.0, height: 12.h),
        LeftToRightAnimation(
          delay: 1200.ms,
          child: const BaseText(
            text: Strings.password,
          ),
        ),
        SizedBox(width: 0.0, height: 6.h),
        LeftToRightAnimation(
            delay: 1300.ms,
            child: Obx(() => TextFieldWidget(
                  suffixIcon: InkWell(
                    onTap: () => controller.obscureTextPass.toggle(),
                    child: Icon(
                      controller.obscureTextPass.value
                          ? Icons.visibility
                          : Icons.visibility_off,
                      size: Dimens.fontSize20,
                      color: AppColors.kIconEyesColor,
                    ),
                  ),
                  obscureText: controller.obscureTextPass.value,
                  controller: controller.password,
                  key: controller.keyPassword,
                ))),
        SizedBox(width: 0.0, height: 12.h),
        LeftToRightAnimation(
          delay: 1400.ms,
          child: const BaseText(
            text: Strings.confirmPassword,
          ),
        ),
        SizedBox(width: 0.0, height: 6.h),
        LeftToRightAnimation(
          delay: 1500.ms,
          child: Obx(() => TextFieldWidget(
                key: controller.keyConfirmPassword,
                suffixIcon: InkWell(
                  onTap: () => controller.obscureTextRePass.toggle(),
                  child: Icon(
                    controller.obscureTextRePass.value
                        ? Icons.visibility
                        : Icons.visibility_off,
                    size: Dimens.fontSize20,
                    color: AppColors.kIconEyesColor,
                  ),
                ),
                obscureText: controller.obscureTextRePass.value,
                controller: controller.confirmPassword,
              )),
        ),
      ],
    );
  }
}
