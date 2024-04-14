import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:we_easy/app/modules/home/controllers/home_controller.dart';
import 'package:we_easy/app/modules/widgets/button_widget.dart';

import '../../../../../common/util/exports.dart';
import '../../../../../data/model/all_job_models/all_job_cty_model.dart';
import 'detailed_work_cty_page.dart';

class WorkItemCtyWidget extends GetView<HomeController> {
  final AllJobCtyModel model;
  final String time;
  const WorkItemCtyWidget({Key? key, required this.model, required this.time})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonWidget(
      onTap: () {
        controller
            .getJob(model.postId.toString())
            .then((value) => Get.to(() => DetailedWorkCtyPage(model: model)));
      },
      widget: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16).r,
            color: AppColors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25.r,
                      backgroundImage: const AssetImage(AppImages.avar),
                    ),
                    SizedBox(width: 10.w, height: 0.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 260.w,
                          child: Text(
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            model.title.toString(),
                            style: AppTextStyle.lableBodyStyle.copyWith(
                              color: AppColors.kPurplePurpleColor,
                            ),
                          ),
                        ),
                        Text(
                          time.toString(),
                          style: AppTextStyle.textsmallStyle
                              .copyWith(color: AppColors.kGray500Color),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(width: 0.0, height: 4.h),
                Text(
                  model.nameCty.toString(),
                  style: AppTextStyle.textsmallStyle60016.copyWith(
                    color: AppColors.kGray600Color,
                  ),
                ),
                SizedBox(width: 0.0, height: 16.h),
                Row(
                  children: [
                    SvgPicture.asset(
                      AppImages.iconMoneyDollarCircleLine,
                      color: AppColors.kGray600Color,
                      width: 24.w,
                      height: 24.h,
                    ),
                    SizedBox(width: 10.h, height: 0.0),
                    Text(
                        model.mucluong.toString() == "Thỏa luận"
                            ? model.mucluong.toString()
                            : '${Utils.formatNumber(int.parse(model.mucluong.toString()))}đ',
                        style: AppTextStyle.textbodyStyle)
                  ],
                ),
                SizedBox(width: 0, height: 16.h),
                Row(
                  children: [
                    SvgPicture.asset(
                      AppImages.iconTimeLine,
                      color: AppColors.kGray600Color,
                      width: 24.w,
                      height: 24.h,
                    ),
                    SizedBox(width: 10.h, height: 0.0),
                    Text(model.hanNop.toString(),
                        style: AppTextStyle.textbodyStyle)
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16).r,
            color: AppColors.kGray050Color,
            child: Row(
              children: [
                Icon(
                  Ionicons.eye_outline,
                  size: 24.sp,
                ),
                SizedBox(width: 10.h, height: 0.0),
                Text(model.view.toString(), style: AppTextStyle.textbodyStyle)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
