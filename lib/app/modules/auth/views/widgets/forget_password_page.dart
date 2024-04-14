import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/util/exports.dart';
import '../../../widgets/base_text_widget.dart';
import '../../../widgets/custom_appbar_widget.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/text_field_widget.dart';
import '../../controllers/auth_controller.dart';

class ForgetPasswordPage extends GetView<AuthController> {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppbarWidget(
        title: 'Đặt lại mật khẩu',
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 16.w),
        child: Column(
          children: <Widget>[
            Text(
              'Nhập địa chỉ email đăng nhập đã đăng ký của bạn để nhận liên kết an toàn để đặt mật khẩu mới',
              style: AppTextStyle.descriptionStyle,
            ),
            SizedBox(width: 0.0, height: 30.h),
            const BaseText(
              text: Strings.emailAddress,
            ),
            SizedBox(width: 0.0, height: 6.h),
            TextFieldWidget(
              key: controller.keyForgotPassword,
              controller: controller.forgotPassword,
            ),
            SizedBox(width: 0.0, height: 172.h),
            CustomElevatedButton(
              title: "Gửi đặt lại mật khẩu",
              minWidth: 240,
              buttonColor: AppColors.kButtonColor,
              onPressed: () {
                controller.postForgotPassword();
              },
            ),
            SizedBox(width: 0.0, height: 24.h),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Từ chối đổi mật khẩu',
                    style: AppTextStyle.conditionNomalStyle
                        .copyWith(fontSize: Dimens.fontSize16),
                  ),
                  TextSpan(
                    text: 'Đăng nhập',
                    style: AppTextStyle.conditionStyle.copyWith(
                        color: AppColors.kButtonColor,
                        fontSize: Dimens.fontSize16),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Get.back();
                      },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
