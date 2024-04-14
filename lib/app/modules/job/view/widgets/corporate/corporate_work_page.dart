import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:we_easy/app/modules/job/controller/job_controller.dart';
import 'package:we_easy/app/modules/job/view/widgets/corporate/posted_jobs.dart';
import 'package:we_easy/app/modules/widgets/button_widget.dart';
import 'package:we_easy/app/modules/widgets/custom_svg.dart';

import '../../../../../common/util/exports.dart';
import 'add_word_page.dart';
import 'expired_job_page.dart';

class CorporateWorkPage extends GetView<JobController> {
  const CorporateWorkPage({Key? key}) : super(key: key);

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
                ButtonWidget(
                    onTap: () {
                      Get.to(() => const AddWordPage());
                    },
                    widget: const CustomSvg(
                      image: AppImages.iconAdd,
                      color: AppColors.kGray1000Color,
                    ))
              ],
            ),
          ),
          Obx(() => TabBar(
                onTap: (index) {
                  controller.selectTab(index);
                },
                controller: controller.tabController,
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
                  _buildTab("Đã đăng", 0),
                  _buildTab("Hết thời hạn", 1),
                ],
              )),
          Expanded(
            child: TabBarView(
              controller: controller.tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                PostedJobs(),
                ExpiredJobPage(),
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
          if (controller.selectedIndex == index)
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
          if (controller.selectedIndex != index)
            Container(
              width: 109.w,
              height: 32.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(48).r,
                border: Border.all(
                  // ignore: unrelated_type_equality_checks
                  color: controller.selectedIndex != index
                      ? AppColors.kGrayTextColor
                      : Colors.transparent,
                  width:
                      // ignore: unrelated_type_equality_checks
                      controller.selectedIndex != index ? 1.w : 0,
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
