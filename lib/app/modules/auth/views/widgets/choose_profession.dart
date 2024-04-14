import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:we_easy/app/common/util/exports.dart';
import 'package:we_easy/app/modules/auth/controllers/auth_controller.dart';
import 'package:we_easy/app/modules/widgets/button_widget.dart';

import '../../../widgets/animations/left_to_right_animation.dart';
import '../../../widgets/text_field_widget.dart';

class ChooseProfession extends GetView<AuthController> {
  const ChooseProfession({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16).r,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LeftToRightAnimation(
                delay: 100.ms,
                child: Text(
                  textAlign: TextAlign.center,
                  'Nhập để tìm kiếm hoặc chọn trong các ngành nghề dưới đây, tối đa 3 ngành nghề',
                  style: AppTextStyle.textsmallStyle
                      .copyWith(color: AppColors.kGray500Color),
                ),
              ),
              SizedBox(width: 0.0, height: 10.h),
              LeftToRightAnimation(
                delay: 200.ms,
                child: TextFieldWidget(
                  hintText: 'Nhập tên ngành nghề để tìm kiếm',
                  // controller: controller.phone,
                  onChanged: (value) {
                    value;
                    controller.getCareer(value);
                  },
                ),
              ),
              SizedBox(width: 0.0, height: 12.h),
              LeftToRightAnimation(
                delay: 300.ms,
                child: SizedBox(
                  height: 590.h,
                  child: Obx(
                    () => ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final model = controller.listCareerModel[index];
                        return Obx(
                          () => ButtonWidget(
                            onTap: () {
                              controller.toggleCareerSelection(
                                  index, !controller.isCheckedList[index]);
                              if (!controller.isCheckedList[index]) {
                                // Kiểm tra xem đã đạt được số lượng tối đa mục được chọn chưa
                                if (controller.selectedCount.value < 3) {
                                  controller.isCheckedList[index] =
                                      !controller.isCheckedList[index];
                                  controller.selectedCount.value++;
                                }
                              } else {
                                controller.isCheckedList[index] =
                                    !controller.isCheckedList[index];
                                controller.selectedCount.value--;
                              }
                            },
                            widget: Row(
                              children: [
                                Material(
                                  child: Checkbox(
                                      value: controller.isCheckedList[index],
                                      onChanged: (value) {
                                        if (controller.selectedCount.value <
                                                3 ||
                                            controller.isCheckedList[index]) {
                                          controller.isCheckedList[index] =
                                              value!;
                                          controller.toggleCareerSelection(
                                              index, value);

                                          if (value) {
                                            controller.selectedCount.value++;
                                          } else {
                                            controller.selectedCount.value--;
                                          }
                                        }
                                      }),
                                ),
                                Text(
                                  model.name.toString(),
                                  style: AppTextStyle.textsmallStyle,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 10.h,
                        );
                      },
                      itemCount: controller.listCareerModel.length,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        alignment: Alignment.center,
        height: 45.h,
        width: double.infinity,
        padding: const EdgeInsets.only(left: 30).r,
        color: AppColors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonWidget(
              onTap: () {
                if (controller.getSelectedCareersString() != "") {
                  Get.back();
                } else {
                  return Utils.showSnackbar(
                    'Cần chọn một ngành nghề để tuyển dụng',
                    AppImages.iconCircleCheck,
                    AppColors.kRrror600Color,
                  );
                }
              },
              text: 'Áp dụng',
            ),
          ],
        ),
      ),
    );
  }
}
