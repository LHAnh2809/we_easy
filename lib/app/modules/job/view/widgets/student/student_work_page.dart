import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:we_easy/app/common/util/exports.dart';
import 'package:we_easy/app/modules/job/controller/job_controller.dart';

import '../../../../widgets/button_widget.dart';

class StudentWorkPage extends GetView<JobController> {
  const StudentWorkPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16).r,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Quản lý công việc',
                  style: AppTextStyle.textButtonStyle
                      .copyWith(color: AppColors.kGray1000Color),
                ),
              ],
            ),
          ),
          Obx(() => TabBar(
                onTap: (index) {
                  controller.selectTabb(index);
                },
                controller: controller.tabControllerr,
                labelPadding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                dividerHeight: 0,
                padding: const EdgeInsets.only(
                        top: 16, left: 16, right: 16, bottom: 16)
                    .r,
                unselectedLabelColor: AppColors.kGrayTextColor,
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                indicatorSize: TabBarIndicatorSize.label,
                indicator: const BoxDecoration(),
                labelColor: AppColors.white,
                tabs: [
                  _buildTab("Đăng ký", 0),
                  _buildTab("Được nhận", 1),
                  _buildTab("Bị từ chối", 2),
                ],
              )),
          Expanded(
            child: TabBarView(
              controller: controller.tabControllerr,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                const Text('text'),
                const Text('text'),
                const Text('text'),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTab(String text, int index) {
    return Tab(
      child: Column(
        children: [
          // ignore: unrelated_type_equality_checks
          if (controller.selectedIndexx == index)
            Container(
              width: 109.w,
              height: 32.h,
              decoration: BoxDecoration(
                color: AppColors.black,
                borderRadius: BorderRadius.circular(48).r,
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  text,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: Dimens.fontSize14,
                    fontFamily: "SFProText",
                  ),
                ),
              ),
            ),
          // ignore: unrelated_type_equality_checks
          if (controller.selectedIndexx != index)
            Container(
              width: 109.w,
              height: 32.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(48).r,
                border: Border.all(
                  // ignore: unrelated_type_equality_checks
                  color: controller.selectedIndexx != index
                      ? AppColors.kGrayTextColor
                      : Colors.transparent,
                  width:
                      // ignore: unrelated_type_equality_checks
                      controller.selectedIndexx != index ? 1.w : 0,
                ),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  text,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: Dimens.fontSize14,
                    fontFamily: "SFProText",
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
