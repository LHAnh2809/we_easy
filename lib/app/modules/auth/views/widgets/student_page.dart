import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:we_easy/app/modules/auth/views/widgets/choose_profession.dart';
import 'package:we_easy/app/modules/widgets/button_widget.dart';

import '../../../../common/util/exports.dart';
import '../../../../common/util/navigator.dart';
import '../../../widgets/animations/left_to_right_animation.dart';
import '../../../widgets/base_text_widget.dart';
import '../../../widgets/text_field_widget.dart';
import '../../controllers/auth_controller.dart';

class StudentPage extends StatelessWidget {
  final AuthController controller;
  const StudentPage({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(width: 0.0, height: 15.h),
        LeftToRightAnimation(
          delay: 200.ms,
          child: const BaseText(
            text: 'Chụp thẻ sinh viên',
          ),
        ),
        SizedBox(width: 0.0, height: 4.h),
        Obx(
          () => controller.imageFile.value != null
              ? LeftToRightAnimation(
                  delay: 300.ms,
                  child: GestureDetector(
                    onLongPressEnd: (details) {
                      // Xóa ảnh khi người dùng nhấn giữ
                      controller.imageFile.value = null;
                    },
                    child: Image.file(controller.imageFile.value!),
                  ),
                )
              : LeftToRightAnimation(
                  delay: 300.ms,
                  child: ButtonWidget(
                    onTap: () {
                      goPresent(
                        children: [
                          ButtonWidget(
                            onTap: () {
                              controller.pickImageFromGallery();
                              Get.back();
                            },
                            text: 'Tải ảnh lên từ di động',
                          ),
                          SizedBox(width: 0.0, height: 10.h),
                          ButtonWidget(
                            onTap: () {
                              controller.pickImageFromCamera();
                              Get.back();
                            },
                            text: 'Tải ảnh lên bằng camera',
                          )
                        ],
                      );
                    },
                    widget: SvgPicture.asset(
                      AppImages.imageStudentCard,
                      height: 150.h,
                      width: 250.w,
                    ),
                  ),
                ),
        ),
        SizedBox(width: 0.0, height: 12.h),
        LeftToRightAnimation(
          delay: 400.ms,
          child: const BaseText(
            text: 'Họ Và Tên',
          ),
        ),
        SizedBox(width: 0.0, height: 6.h),
        LeftToRightAnimation(
          delay: 500.ms,
          child: TextFieldWidget(
            key: controller.keyName,
            controller: controller.name,
          ),
        ),
        SizedBox(width: 0.0, height: 12.h),
        LeftToRightAnimation(
          delay: 400.ms,
          child: const BaseText(
            text: 'Ngày sinh',
          ),
        ),
        SizedBox(width: 0.0, height: 6.h),
        LeftToRightAnimation(
          delay: 500.ms,
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
          delay: 600.ms,
          child: const BaseText(
            text: 'Giới tính',
          ),
        ),
        SizedBox(width: 0.0, height: 6.h),
        LeftToRightAnimation(
          delay: 700.ms,
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
                          controller.sex.text = controller.options[index];
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
          delay: 800.ms,
          child: const BaseText(
            text: 'Tình Trạng hôn nhân',
          ),
        ),
        SizedBox(width: 0.0, height: 6.h),
        LeftToRightAnimation(
          delay: 900.ms,
          child: TextFieldWidget(
            key: controller.keytinhTrangHonNhan,
            controller: controller.tinhTrangHonNhan,
          ),
        ),
        SizedBox(width: 0.0, height: 12.h),
        LeftToRightAnimation(
          delay: 1000.ms,
          child: const BaseText(
            text: 'Lớp',
          ),
        ),
        SizedBox(width: 0.0, height: 6.h),
        LeftToRightAnimation(
          delay: 1100.ms,
          child: TextFieldWidget(
            key: controller.keylop,
            controller: controller.lop,
          ),
        ),
        SizedBox(width: 0.0, height: 12.h),
        LeftToRightAnimation(
          delay: 1200.ms,
          child: const BaseText(
            text: 'Khóa học',
          ),
        ),
        SizedBox(width: 0.0, height: 6.h),
        LeftToRightAnimation(
          delay: 1300.ms,
          child: TextFieldWidget(
            key: controller.keykhoaHoc,
            controller: controller.khoaHoc,
          ),
        ),
        SizedBox(width: 0.0, height: 12.h),
        LeftToRightAnimation(
          delay: 1400.ms,
          child: const BaseText(
            text: 'Sinh viên năm mấy',
          ),
        ),
        SizedBox(width: 0.0, height: 6.h),
        LeftToRightAnimation(
          delay: 1500.ms,
          child: TextFieldWidget(
            key: controller.keysinhVienNamMay,
            controller: controller.sinhVienNamMay,
          ),
        ),
        SizedBox(width: 0.0, height: 12.h),
        LeftToRightAnimation(
          delay: 1600.ms,
          child: const BaseText(
            text: 'Chuyên ngành gì',
          ),
        ),
        SizedBox(width: 0.0, height: 6.h),
        LeftToRightAnimation(
          delay: 1700.ms,
          child: TextFieldWidget(
            key: controller.keychuyenNganh,
            controller: controller.chuyenNganh,
          ),
        ),
        SizedBox(width: 0.0, height: 12.h),
        LeftToRightAnimation(
          delay: 1800.ms,
          child: const BaseText(
            text: 'Sở trường',
          ),
        ),
        SizedBox(width: 0.0, height: 6.h),
        LeftToRightAnimation(
          delay: 1900.ms,
          child: TextFieldWidget(
            key: controller.keysoTruong,
            controller: controller.soTruong,
          ),
        ),
        SizedBox(width: 0.0, height: 12.h),
        LeftToRightAnimation(
          delay: 2000.ms,
          child: const BaseText(
            text: 'Kinh nghiệm làm việc',
          ),
        ),
        SizedBox(width: 0.0, height: 6.h),
        LeftToRightAnimation(
          delay: 2100.ms,
          child: TextFieldWidget(
            key: controller.keykinhNghiemLamViec,
            controller: controller.kinhNghiemLamViec,
          ),
        ),
        SizedBox(width: 0.0, height: 12.h),
        LeftToRightAnimation(
          delay: 2200.ms,
          child: const BaseText(
            text: 'Kỹ năng thành thạo',
          ),
        ),
        SizedBox(width: 0.0, height: 6.h),
        LeftToRightAnimation(
          delay: 2300.ms,
          child: TextFieldWidget(
            key: controller.keykyNangThanhThao,
            controller: controller.kyNangThanhThao,
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
            )),
        SizedBox(width: 0.0, height: 12.h),
        LeftToRightAnimation(
          delay: 2400.ms,
          child: const BaseText(
            text: 'Số điện thoại',
          ),
        ),
        SizedBox(width: 0.0, height: 6.h),
        LeftToRightAnimation(
          delay: 2500.ms,
          child: TextFieldWidget(
            key: controller.keyPhone,
            controller: controller.phone,
          ),
        ),
        SizedBox(width: 0.0, height: 12.h),
        LeftToRightAnimation(
          delay: 2600.ms,
          child: const BaseText(
            text: 'Email',
          ),
        ),
        SizedBox(width: 0.0, height: 6.h),
        LeftToRightAnimation(
          delay: 2700.ms,
          child: TextFieldWidget(
            key: controller.keyEmail,
            controller: controller.email,
          ),
        ),
        SizedBox(width: 0.0, height: 12.h),
        LeftToRightAnimation(
          delay: 2800.ms,
          child: const BaseText(
            text: Strings.password,
          ),
        ),
        SizedBox(width: 0.0, height: 6.h),
        LeftToRightAnimation(
            delay: 2900.ms,
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
          delay: 3000.ms,
          child: const BaseText(
            text: Strings.confirmPassword,
          ),
        ),
        SizedBox(width: 0.0, height: 6.h),
        LeftToRightAnimation(
          delay: 3100.ms,
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
