import 'package:flutter/material.dart';
import 'package:flutter_animate/num_duration_extensions.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:radio_group_v2/radio_group_v2.dart';
import 'package:we_easy/app/modules/auth/views/widgets/rich_text_widget.dart';

import '../../../../common/util/exports.dart';
import '../../../widgets/animations/left_to_right_animation.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../controllers/auth_controller.dart';
import 'enterprise_page.dart';
import 'student_page.dart';

class SignUpPage extends GetView<AuthController> {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RadioGroupController myController = RadioGroupController();

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: 30.h, left: 18.w, right: 18.w, bottom: 8.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                LeftToRightAnimation(
                  delay: 0.ms,
                  child: Hero(
                      tag: Strings.logo,
                      child: AppImages.svg(AppImages.logoAppImg,
                          width: 95.w, height: 95.h)),
                ),
                SizedBox(width: 0.0, height: 27.h),
                LeftToRightAnimation(
                  delay: 100.ms,
                  child: RadioGroup(
                    controller: myController,
                    values: const [
                      "Sinh viên",
                      "Doanh nghiệp",
                    ],
                    indexOfDefault: 0,
                    orientation: RadioGroupOrientation.horizontal,
                    decoration: RadioGroupDecoration(
                      spacing: 10.0,
                      labelStyle: AppTextStyle.textbodyStyle,
                      activeColor: AppColors.kButtonColor,
                    ),
                    onChanged: (newValue) {
                      controller.verticalValAutomatic.value =
                          newValue.toString();
                      controller.clearText();
                    },
                  ),
                ),
                Column(
                  children: [
                    Obx(
                      () => controller.verticalValAutomatic.value == 'Sinh viên'
                          ? StudentPage(controller: controller)
                          : EnterprisePage(controller: controller),
                    ),
                  ],
                ),
              ],
            ),
          ),
          _buildCondition(),
          SizedBox(width: 0.0, height: 40.h),
          LeftToRightAnimation(
            delay: 1600.ms,
            child: Obx(
              () => Column(
                children: [
                  if (controller.isLoading == false)
                    CustomElevatedButton(
                      title: Strings.signUp,
                      buttonColor: AppColors.kButtonColor,
                      onPressed: () {
                        controller.resgisterAccount(context);
                      },
                    ),
                  if (controller.isLoading == true)
                    CustomElevatedButton(
                        buttonColor: AppColors.kButtonColor,
                        onPressed: () {},
                        titleWidget: LoadingAnimationWidget.fourRotatingDots(
                            color: AppColors.white, size: 30.r)),
                ],
              ),
            ),
          ),
          SizedBox(width: 0.0, height: 24.h),
          LeftToRightAnimation(delay: 1700.ms, child: RichTextWidget()),
          SizedBox(width: 0.0, height: 18.h)
        ],
      ),
    );
  }

  _buildCondition() {
    return LeftToRightAnimation(
      delay: 1700.ms,
      child: Padding(
        padding: EdgeInsets.only(left: 4.w),
        child: Row(
          children: [
            Obx(
              () => Checkbox(
                shape: RoundedRectangleBorder(
                  borderRadius: 4.borderRadius,
                ),
                value: controller.isPrivacy.value,
                onChanged: (value) {
                  controller.isPrivacy.toggle();
                },
                focusColor: AppColors.kPrimaryColor,
              ),
            ),
            Expanded(
              child: _buildTextCondition(),
            )
          ],
        ),
      ),
    );
  }

  _buildTextCondition() {
    return GestureDetector(
      onTap: () {
        Utils.getLaunchUrl(
            "https://www.termsfeed.com/live/4e528d06-5755-468d-8efa-6bbd79a729fb");
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
                text: Strings.authCondition1,
                style: AppTextStyle.conditionNomalStyle),
            TextSpan(
              text: Strings.authCondition2,
              style: AppTextStyle.conditionStyle
                  .copyWith(color: AppColors.kPrimaryColor),
            ),
            TextSpan(
                text: Strings.authCondition3,
                style: AppTextStyle.conditionNomalStyle),
            TextSpan(
              text: Strings.authCondition4,
              style: AppTextStyle.conditionStyle
                  .copyWith(color: AppColors.kPrimaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
