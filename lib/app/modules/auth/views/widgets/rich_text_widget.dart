import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/util/exports.dart';
import '../../controllers/auth_controller.dart';

class RichTextWidget extends StatelessWidget {
  final AuthController controller = Get.find<AuthController>();
  RichTextWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: controller.isLogin.value
                  ? 'Chưa có tài khoản '
                  : 'Đã có tài khoản ',
              style: AppTextStyle.conditionNomalStyle
                  .copyWith(fontSize: Dimens.fontSize16),
            ),
            TextSpan(
              text: controller.isLogin.value ? Strings.signUp : 'Đăng nhập',
              style: AppTextStyle.conditionStyle.copyWith(
                  color: AppColors.kButtonColor, fontSize: Dimens.fontSize16),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  controller.isLogin.toggle();
                  controller.clearText();
                },
            ),
            TextSpan(
              text: ' Tại',
              style: AppTextStyle.conditionNomalStyle
                  .copyWith(fontSize: Dimens.fontSize16),
            ),
          ],
        ),
      ),
    );
  }
}
