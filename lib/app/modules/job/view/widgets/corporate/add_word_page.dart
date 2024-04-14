import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:we_easy/app/modules/job/controller/job_controller.dart';
import 'package:we_easy/app/modules/widgets/custom_appbar_widget.dart';

import '../../../../../common/util/exports.dart';
import '../../../../widgets/animations/left_to_right_animation.dart';
import '../../../../widgets/base_text_widget.dart';
import '../../../../widgets/button_widget.dart';
import '../../../../widgets/custom_elevated_button.dart';
import '../../../../widgets/text_field_widget.dart';
import 'choose_profession.dart';

class AddWordPage extends GetView<JobController> {
  const AddWordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppbarWidget(
        title: 'Đăng tuyển dụng',
      ),
      body: Container(
        padding: const EdgeInsets.all(16).r,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LeftToRightAnimation(
                delay: 100.ms,
                child: const BaseText(
                  text: 'Công ty',
                ),
              ),
              SizedBox(width: 0.0, height: 6.h),
              LeftToRightAnimation(
                delay: 200.ms,
                child: Container(
                  alignment: Alignment.centerLeft,
                  height: 48.h,
                  padding: const EdgeInsets.only(left: 10, right: 10).r,
                  decoration: BoxDecoration(
                    color: AppColors.kGray050Color,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.kGray200Color),
                  ),
                  child: Text(
                    controller.textNameCTY.value,
                    style: AppTextStyle.textsmallStyle60016
                        .copyWith(color: AppColors.kGray900Color),
                  ),
                ),
              ),
              SizedBox(width: 0.0, height: 12.h),
              LeftToRightAnimation(
                delay: 300.ms,
                child: const BaseText(
                  text: 'Tiêu đề Tuyển dụng',
                ),
              ),
              SizedBox(width: 0.0, height: 6.h),
              LeftToRightAnimation(
                delay: 400.ms,
                child: TextFieldWidget(
                  // key: controller.keyEmail,
                  controller: controller.title,
                ),
              ),
              SizedBox(width: 0.0, height: 12.h),
              LeftToRightAnimation(
                delay: 500.ms,
                child: const BaseText(
                  text: 'Mức lương',
                ),
              ),
              SizedBox(width: 0.0, height: 6.h),
              LeftToRightAnimation(
                delay: 600.ms,
                child: TextFieldWidget(
                  // key: controller.keyEmail,
                  controller: controller.mucLuong,
                ),
              ),
              SizedBox(width: 0.0, height: 12.h),
              LeftToRightAnimation(
                delay: 700.ms,
                child: const BaseText(
                  text: 'Hạn nộp',
                ),
              ),
              SizedBox(width: 0.0, height: 6.h),
              LeftToRightAnimation(
                delay: 800.ms,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 48.h,
                      padding: const EdgeInsets.only(left: 10, right: 10).r,
                      decoration: BoxDecoration(
                        color: AppColors.kGray050Color,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.kGray200Color),
                      ),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          controller.selectDate();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Obx(
                              () => Text(
                                controller.dateBirth.value,
                                style: AppTextStyle.buttonTextStyle.copyWith(
                                  color: AppColors.black,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            const Icon(Icons.calendar_today),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 0.0, height: 12.h),
              LeftToRightAnimation(
                delay: 900.ms,
                child: const BaseText(
                  text: 'Chức vụ',
                ),
              ),
              SizedBox(width: 0.0, height: 6.h),
              LeftToRightAnimation(
                delay: 1000.ms,
                child: TextFieldWidget(
                  // key: controller.keyEmail,
                  controller: controller.chucVu,
                ),
              ),
              SizedBox(width: 0.0, height: 12.h),
              LeftToRightAnimation(
                delay: 1100.ms,
                child: const BaseText(
                  text: 'Hình thức làm việc',
                ),
              ),
              SizedBox(width: 0.0, height: 6.h),
              LeftToRightAnimation(
                delay: 1200.ms,
                child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    Get.bottomSheet(
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                          ),
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.options.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(controller.options[index],
                                  style: AppTextStyle.textsmallStyle),
                              onTap: () {
                                controller.selectedOption.value =
                                    controller.options[index];
                                Get.back();
                              },
                            );
                          },
                        ),
                      ),
                    );
                  },
                  child: Container(
                    alignment: Alignment.centerLeft,
                    height: 48.h,
                    padding: const EdgeInsets.only(left: 10, right: 10).r,
                    decoration: BoxDecoration(
                      color: AppColors.kGray050Color,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.kGray200Color),
                    ),
                    child: Obx(
                      () => Text(
                        controller.selectedOption.value,
                        style: AppTextStyle.textsmallStyle60016
                            .copyWith(color: AppColors.kGray900Color),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 0.0, height: 12.h),
              LeftToRightAnimation(
                delay: 1300.ms,
                child: const BaseText(
                  text: 'Số lượng',
                ),
              ),
              SizedBox(width: 0.0, height: 6.h),
              LeftToRightAnimation(
                delay: 1400.ms,
                child: TextFieldWidget(
                  // key: controller.keyEmail,
                  controller: controller.soLuong,
                ),
              ),
              SizedBox(width: 0.0, height: 12.h),
              LeftToRightAnimation(
                delay: 1300.ms,
                child: const BaseText(
                  text: 'Hoa hồng',
                ),
              ),
              SizedBox(width: 0.0, height: 6.h),
              LeftToRightAnimation(
                delay: 1400.ms,
                child: TextFieldWidget(
                  // key: controller.keyEmail,
                  controller: controller.hoaHong,
                ),
              ),
              SizedBox(width: 0.0, height: 12.h),
              LeftToRightAnimation(
                delay: 1500.ms,
                child: const BaseText(
                  text: 'Thời gian thử việc',
                ),
              ),
              SizedBox(width: 0.0, height: 6.h),
              LeftToRightAnimation(
                delay: 1600.ms,
                child: TextFieldWidget(
                  // key: controller.keyEmail,
                  controller: controller.thoiGianThuViec,
                ),
              ),
              SizedBox(width: 0.0, height: 12.h),
              LeftToRightAnimation(
                delay: 1700.ms,
                child: const BaseText(
                  text: 'Kinh nghiệm',
                ),
              ),
              SizedBox(width: 0.0, height: 6.h),
              LeftToRightAnimation(
                delay: 1800.ms,
                child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    Get.bottomSheet(
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                          ),
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.optionsKN.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(controller.optionsKN[index],
                                  style: AppTextStyle.textsmallStyle),
                              onTap: () {
                                controller.selectedOptionKM.value =
                                    controller.optionsKN[index];
                                Get.back();
                              },
                            );
                          },
                        ),
                      ),
                    );
                  },
                  child: Container(
                    alignment: Alignment.centerLeft,
                    height: 48.h,
                    padding: const EdgeInsets.only(left: 10, right: 10).r,
                    decoration: BoxDecoration(
                      color: AppColors.kGray050Color,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.kGray200Color),
                    ),
                    child: Obx(
                      () => Text(
                        controller.selectedOptionKM.value,
                        style: AppTextStyle.textsmallStyle60016
                            .copyWith(color: AppColors.kGray900Color),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 0.0, height: 12.h),
              LeftToRightAnimation(
                delay: 1800.ms,
                child: const BaseText(
                  text: 'Bằng cấp',
                ),
              ),
              SizedBox(width: 0.0, height: 6.h),
              LeftToRightAnimation(
                delay: 1900.ms,
                child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    Get.bottomSheet(
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                          ),
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.optionsBC.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(controller.optionsBC[index],
                                  style: AppTextStyle.textsmallStyle),
                              onTap: () {
                                controller.selectedOptionBC.value =
                                    controller.optionsBC[index];
                                Get.back();
                              },
                            );
                          },
                        ),
                      ),
                    );
                  },
                  child: Container(
                    alignment: Alignment.centerLeft,
                    height: 48.h,
                    padding: const EdgeInsets.only(left: 10, right: 10).r,
                    decoration: BoxDecoration(
                      color: AppColors.kGray050Color,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.kGray200Color),
                    ),
                    child: Obx(
                      () => Text(
                        controller.selectedOptionBC.value,
                        style: AppTextStyle.textsmallStyle60016
                            .copyWith(color: AppColors.kGray900Color),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 0.0, height: 12.h),
              LeftToRightAnimation(
                delay: 2000.ms,
                child: const BaseText(
                  text: 'Giới tính',
                ),
              ),
              SizedBox(width: 0.0, height: 6.h),
              LeftToRightAnimation(
                delay: 2100.ms,
                child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    Get.bottomSheet(
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                          ),
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.options.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(controller.optionsGT[index],
                                  style: AppTextStyle.textsmallStyle),
                              onTap: () {
                                controller.selectedOptionGT.value =
                                    controller.optionsGT[index];

                                Get.back();
                              },
                            );
                          },
                        ),
                      ),
                    );
                  },
                  child: Container(
                    alignment: Alignment.centerLeft,
                    height: 48.h,
                    padding: const EdgeInsets.only(left: 10, right: 10).r,
                    decoration: BoxDecoration(
                      color: AppColors.kGray050Color,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.kGray200Color),
                    ),
                    child: Obx(
                      () => Text(
                        controller.selectedOptionGT.value,
                        style: AppTextStyle.textsmallStyle60016
                            .copyWith(color: AppColors.kGray900Color),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 0.0, height: 12.h),
              LeftToRightAnimation(
                delay: 2200.ms,
                child: const BaseText(
                  text: 'Ngành nghề',
                ),
              ),
              SizedBox(width: 0.0, height: 6.h),
              LeftToRightAnimation(
                delay: 2300.ms,
                child: ButtonWidget(
                  onTap: () {
                    Get.to(() => const ChooseProfession());
                    controller.getCareer('');
                    controller.selectedCareers.value = [];
                    controller.selectedCount.value = 0;
                  },
                  widget: Container(
                    alignment: Alignment.centerLeft,
                    height: 48.h,
                    padding: const EdgeInsets.only(left: 10, right: 10).r,
                    decoration: BoxDecoration(
                      color: AppColors.kGray050Color,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.kGray200Color),
                    ),
                    child: Obx(
                      () => Text(
                        controller.getSelectedCareersString(),
                        style: AppTextStyle.textsmallStyle60016
                            .copyWith(color: AppColors.kGray900Color),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 0.0, height: 12.h),
              LeftToRightAnimation(
                delay: 2400.ms,
                child: const BaseText(
                  text: 'Mô tả công việc',
                ),
              ),
              SizedBox(width: 0.0, height: 6.h),
              LeftToRightAnimation(
                delay: 2500.ms,
                child: TextFieldWidget(
                  // key: controller.keyEmail,
                  obsNhapText: false,
                  controller: controller.motaCongViec,
                ),
              ),
              SizedBox(width: 0.0, height: 12.h),
              LeftToRightAnimation(
                delay: 2600.ms,
                child: const BaseText(
                  text: 'Yêu cầu công việc',
                ),
              ),
              SizedBox(width: 0.0, height: 6.h),
              LeftToRightAnimation(
                delay: 2700.ms,
                child: TextFieldWidget(
                  obsNhapText: false,
                  // key: controller.keyEmail,
                  controller: controller.yeucauCongViec,
                ),
              ),
              SizedBox(width: 0.0, height: 12.h),
              LeftToRightAnimation(
                delay: 2800.ms,
                child: const BaseText(
                  text: 'Quyền lợi được hưởng',
                ),
              ),
              SizedBox(width: 0.0, height: 6.h),
              LeftToRightAnimation(
                delay: 2900.ms,
                child: TextFieldWidget(
                  obsNhapText: false,
                  // key: controller.keyEmail,
                  controller: controller.quyenLoi,
                ),
              ),
              SizedBox(width: 0.0, height: 12.h),
              LeftToRightAnimation(
                delay: 3000.ms,
                child: const BaseText(
                  text: 'Yêu cầu hồ sơ',
                ),
              ),
              SizedBox(width: 0.0, height: 6.h),
              LeftToRightAnimation(
                delay: 3100.ms,
                child: TextFieldWidget(
                  // key: controller.keyEmail,
                  controller: controller.hoso,
                ),
              ),
              Obx(() => controller.isCheck == true
                  ? Column(
                      children: [
                        SizedBox(width: 0.0, height: 10.h),
                        Text(
                          controller.textEr.value,
                          style: AppTextStyle.textsmallStyle
                              .copyWith(color: Colors.red, fontSize: 12.sp),
                        ),
                      ],
                    )
                  : const SizedBox.shrink()),
              SizedBox(width: 0.0, height: 12.h),
              LeftToRightAnimation(
                  delay: 3200.ms,
                  child: Obx(
                    () => Column(
                      children: [
                        if (controller.isLoading == false)
                          ButtonWidget(
                            onTap: () {
                              controller.addJob();
                            },
                            text: 'Đăng tuyển dụng',
                          ),
                        if (controller.isLoading == true)
                          Container(
                              alignment: Alignment.center,
                              height: 45.h,
                              decoration: BoxDecoration(
                                color: AppColors.kButtonColor.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(8).r,
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        AppColors.kButtonColor.withOpacity(0.2),
                                    blurRadius: 10,
                                  )
                                ],
                              ),
                              child: LoadingAnimationWidget.fourRotatingDots(
                                  color: AppColors.white, size: 30.r)),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
