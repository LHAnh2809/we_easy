import 'package:flutter/material.dart';
import 'package:flutter_animate/num_duration_extensions.dart';
import 'package:get/get.dart';
import 'package:we_easy/app/modules/auth/views/widgets/rich_text_widget.dart';

import '../../../../common/util/exports.dart';
import '../../../widgets/animations/left_to_right_animation.dart';
import '../../../widgets/base_text_widget.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/text_field_widget.dart';
import '../../controllers/auth_controller.dart';

class SignInPage extends GetView<AuthController> {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 30.h, left: 18.w, right: 18.w, bottom: 8.h),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            LeftToRightAnimation(
              delay: 0.ms,
              child: AppImages.svg(AppImages.logoAppImg,
                  width: 95.w, height: 95.h),
            ),
            SizedBox(width: 0.0, height: 36.h),
            LeftToRightAnimation(
              delay: 100.ms,
              child: const BaseText(
                text: Strings.emailAddress,
              ),
            ),
            SizedBox(width: 0.0, height: 6.h),
            LeftToRightAnimation(
              delay: 200.ms,
              child: TextFieldWidget(
                controller: controller.email,
              ),
            ),
            SizedBox(width: 0.0, height: 12.h),
            LeftToRightAnimation(
              delay: 300.ms,
              child: const BaseText(
                text: Strings.password,
              ),
            ),
            SizedBox(width: 0.0, height: 6.h),
            LeftToRightAnimation(
                delay: 400.ms,
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
                    ))),
            SizedBox(width: 0.0, height: 12.h),
            LeftToRightAnimation(
              delay: 500.ms,
              child: Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {},
                  child: Text(
                    Strings.forgotPassword,
                    style: AppTextStyle.conditionStyle.copyWith(
                        color: Colors.blue, fontSize: Dimens.fontSize16),
                  ),
                ),
              ),
            ),
            SizedBox(width: 0.0, height: 48.h),
            LeftToRightAnimation(
              delay: 600.ms,
              child: CustomElevatedButton(
                title: Strings.signIn,
                buttonColor: AppColors.kButtonColor,
                onPressed: () {
                  controller.signInAccount(context);
                },
              ),
            ),
            SizedBox(width: 0.0, height: 24.h),
            LeftToRightAnimation(
              delay: 700.ms,
              child: RichTextWidget(),
            )
          ],
        ),
      ),
    );
  }
}
