import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:we_easy/app/modules/home/controllers/home_controller.dart';
import 'package:we_easy/app/modules/widgets/button_widget.dart';
import 'package:we_easy/app/modules/widgets/custom_appbar_widget.dart';

import '../../../../../common/util/exports.dart';
import '../../../../../data/model/all_job_models/all_job_cty_model.dart';
import 'details_page.dart';

class DetailedWorkCtyPage extends GetView<HomeController> {
  final AllJobCtyModel model;
  const DetailedWorkCtyPage({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppbarWidget(
        title: 'Chi tiết tuyển dụng',
      ),
      body: Padding(
        padding: const EdgeInsets.all(5).r,
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
            Obx(
              () => controller.textPermission.value == 0 &&
                      controller.isUngTuyen.value != true
                  ? Column(
                      children: [
                        SizedBox(width: 0.0, height: 4.h),
                        ButtonWidget(
                          onTap: () {
                            controller.postUngtuyen(model.postId.toString());
                          },
                          widget: Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12).r,
                            width: 120.w,
                            height: 32.h,
                            decoration: BoxDecoration(
                              color: AppColors.kWarning100Color,
                              borderRadius: BorderRadius.circular(16).r,
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  child: SvgPicture.asset(
                                    AppImages.iconAdd,
                                    color: AppColors.kWarning700Color,
                                    width: 16.w,
                                    height: 16.h,
                                  ),
                                ),
                                SizedBox(width: 6.w, height: 0.0),
                                Text(
                                  'Ứng tuyển',
                                  style: AppTextStyle.largeBodyStyle.copyWith(
                                    fontSize: 14.sp,
                                    color: AppColors.kWarning700Color,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
            ),
            SizedBox(width: 0.0, height: 10.h),
            Expanded(
              child: ListView(
                children: [
                  SizedBox(width: 0.0, height: 10.h),
                  Container(
                    padding: const EdgeInsets.all(5).r,
                    width: 366.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8).r,
                      color: AppColors.kGray050Color,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Thông tin',
                          style: AppTextStyle.textButtonStyle
                              .copyWith(color: AppColors.kGray1000Color),
                        ),
                        SizedBox(width: 0.0, height: 15.h),
                        DetailsPage(
                          iconL: AppImages.iconMoneyDollarCircle,
                          iconR: AppImages.iconDate,
                          titleL: 'Mức lương:',
                          contentL: model.mucluong.toString() == "Thỏa luận"
                              ? model.mucluong.toString()
                              : '${Utils.formatNumber(int.parse(model.mucluong.toString()))}đ',
                          titleR: 'Hạn nộp:',
                          contentR: model.hanNop.toString(),
                        ),
                        SizedBox(width: 0.0, height: 10.h),
                        DetailsPage(
                          iconL: AppImages.iconWork,
                          iconR: AppImages.iconTimeLine,
                          titleL: 'Chức vụ:',
                          contentL: model.chucVu.toString(),
                          titleR: 'Hình thức công việc:',
                          contentR: model.hinhThucLamViec.toString(),
                        ),
                        SizedBox(width: 0.0, height: 10.h),
                        DetailsPage(
                          iconL: AppImages.iconAccount,
                          iconR: AppImages.iconAccount,
                          titleL: 'Số lượng:',
                          contentL: model.soLuong.toString(),
                          titleR: 'Hoa hồng:',
                          contentR: model.hoaHong.toString(),
                        ),
                        SizedBox(width: 0.0, height: 10.h),
                        DetailsPage(
                          iconL: AppImages.iconTimeRepeatLine,
                          iconR: AppImages.iconExchangeFundsLine,
                          titleL: 'Thời gian thử việc:',
                          contentL: model.thoiGianThuViec.toString(),
                          titleR: 'Kinh nghiệm:',
                          contentR: model.kinhNghiep.toString(),
                        ),
                        SizedBox(width: 0.0, height: 10.h),
                        DetailsPage(
                          iconL: AppImages.iconBookOpenLine,
                          iconR: AppImages.iconGenderSvgrepoCom,
                          titleL: 'Bằng cấp:',
                          contentL: model.bangCap.toString(),
                          titleR: 'Giới tính:',
                          contentR: model.gioiTinh.toString(),
                        ),
                        SizedBox(width: 0.0, height: 10.h),
                        DetailsPage(
                          iconL: AppImages.iconFileCopyFill,
                          iconR: '',
                          titleL: 'Ngành nghề:',
                          contentL: model.ngheNghiep.toString(),
                          titleR: '',
                          contentR: '',
                          noR: true,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 0.0, height: 16.h),
                  Container(
                    padding: const EdgeInsets.all(5).r,
                    width: 366.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8).r,
                      color: AppColors.kGray050Color,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Mô tả công việc',
                          style: AppTextStyle.textButtonStyle
                              .copyWith(color: AppColors.kGray1000Color),
                        ),
                        SizedBox(width: 0.0, height: 15.h),
                        Text(
                          model.moTaCongViec.toString(),
                          style: AppTextStyle.textsmallStyle60016,
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: 0.0, height: 16.h),
                  Container(
                    padding: const EdgeInsets.all(5).r,
                    width: 366.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8).r,
                      color: AppColors.kGray050Color,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Yêu cầu công việc',
                          style: AppTextStyle.textButtonStyle
                              .copyWith(color: AppColors.kGray1000Color),
                        ),
                        SizedBox(width: 0.0, height: 15.h),
                        Text(
                          model.yeuCauCongViec.toString(),
                          style: AppTextStyle.textsmallStyle60016,
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: 0.0, height: 16.h),
                  Container(
                    padding: const EdgeInsets.all(5).r,
                    width: 366.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8).r,
                      color: AppColors.kGray050Color,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Quyền lợi được hưởng',
                          style: AppTextStyle.textButtonStyle
                              .copyWith(color: AppColors.kGray1000Color),
                        ),
                        SizedBox(width: 0.0, height: 15.h),
                        Text(
                          model.quyenLoiDuocHuong.toString(),
                          style: AppTextStyle.textsmallStyle60016,
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: 0.0, height: 16.h),
                  Container(
                    padding: const EdgeInsets.all(5).r,
                    width: 366.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8).r,
                      color: AppColors.kGray050Color,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Yêu cầu hồ sơ',
                          style: AppTextStyle.textButtonStyle
                              .copyWith(color: AppColors.kGray1000Color),
                        ),
                        SizedBox(width: 0.0, height: 15.h),
                        Text(
                          model.yeuCauHoiSo.toString(),
                          style: AppTextStyle.textsmallStyle60016,
                        )
                      ],
                    ),
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
