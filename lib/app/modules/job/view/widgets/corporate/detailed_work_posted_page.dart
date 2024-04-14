import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:we_easy/app/common/util/exports.dart';
import 'package:we_easy/app/modules/job/controller/job_controller.dart';
import 'package:we_easy/app/modules/job/view/widgets/corporate/candidate_details_page.dart';
import 'package:we_easy/app/modules/widgets/button_widget.dart';

import '../../../../../data/model/posted_job_models/posted_job_model.dart';
import '../../../../home/view/dash_board/widgets/details_page.dart';
import '../../../../widgets/custom_appbar_widget.dart';

class DetailedWorkPostedPage extends GetView<JobController> {
  final PostedJobModel model;
  const DetailedWorkPostedPage({Key? key, required this.model})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
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
            Text(
              model.nameCty.toString(),
              style: AppTextStyle.textsmallStyle60016.copyWith(
                color: AppColors.kGray600Color,
              ),
            ),
            Text(
              'Đã có ${controller.textUT} người ứng tuyển',
              style: AppTextStyle.lableBodyStyle.copyWith(
                color: AppColors.kGray900Color,
              ),
            ),
            SizedBox(width: 0.0, height: 10.h),
            Container(
              height: 50.h,
              width: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  color: AppColors.kButtonColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Theme(
                    data: theme.copyWith(
                      colorScheme: theme.colorScheme.copyWith(
                        surfaceVariant: Colors.transparent,
                      ),
                    ),
                    child: TabBar(
                      unselectedLabelColor: Colors.white,
                      labelColor: Colors.black,
                      indicatorColor: Colors.white,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicator: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      labelStyle:
                          TextStyle(fontSize: 17.sp, fontFamily: "SFProText"),
                      unselectedLabelStyle:
                          TextStyle(fontSize: 17.sp, fontFamily: "SFProText"),
                      controller: controller.tabController,
                      tabs: const [
                        Tab(
                          text: 'Chi tiết công việc',
                        ),
                        Tab(
                          text: 'Danh sách ứng cử viên đã đăng ký',
                        ),
                      ],
                    ),
                  )),
            ),
            Expanded(
              child: TabBarView(
                controller: controller.tabController,
                children: [
                  ListView(
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
                  ListView(
                    children: [
                      SizedBox(width: 0.0, height: 10.h),

                      Text(
                        'Hồ sơ ứng cử viên đã đăng ký',
                        style: AppTextStyle.textButtonStyle
                            .copyWith(color: AppColors.kGray1000Color),
                      ),
                      // Sử dụng Column thay vì ListView
                      SizedBox(width: 0.0, height: 10.h),
                      Column(
                        children: controller.listUserUTModel.map((models) {
                          final m = models.parentStatus!;
                          print(m.name);
                          return ButtonWidget(
                            onTap: () {
                              Get.to(() => CandidateDetailsPage(
                                  model: models, id: model.postId.toString()));
                            },
                            widget: Container(
                              padding: const EdgeInsets.all(5).r,
                              width: 366.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8).r,
                                color: AppColors.kGray050Color,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (m.imageAVT == '')
                                        CircleAvatar(
                                          radius: 25.r,
                                          backgroundImage:
                                              const AssetImage(AppImages.avar),
                                        ),
                                      if (m.imageAVT != '')
                                        CircleAvatar(
                                          radius: 25.r,
                                          backgroundImage:
                                              NetworkImage(m.toString()),
                                        ),
                                      SizedBox(width: 10.w, height: 0.0),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            m.name.toString(),
                                            style: AppTextStyle.textbodyStyle,
                                          ),
                                          SizedBox(width: 0.0, height: 5.h),
                                          Text(
                                            m.phone.toString(),
                                            style: AppTextStyle.textbodyStyle,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SvgPicture.asset(
                                    models.childStatus == 2
                                        ? AppImages.iconCircleCheck
                                        : AppImages.iconCloseCircleFill,
                                    width: 30.w,
                                    height: 30.h,
                                    color: models.childStatus == 2
                                        ? AppColors.kSuccess600Color
                                        : AppColors.kRrror600Color,
                                  )
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
