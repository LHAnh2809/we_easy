import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:we_easy/app/common/util/exports.dart';

import 'package:we_easy/app/modules/job/controller/job_controller.dart';
import 'package:we_easy/app/modules/widgets/button_widget.dart';
import 'package:we_easy/app/modules/widgets/custom_appbar_widget.dart';

import '../../../../../data/model/user_models/user_ut_model.dart';
import 'information_page.dart';

class CandidateDetailsPage extends GetView<JobController> {
  final UserUTModel model;
  final String id;
  const CandidateDetailsPage({
    Key? key,
    required this.model,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbarWidget(
        title: 'Chi tiết ứng cử viên',
      ),
      body: ListView(
        children: [
          Column(
            children: [
              SizedBox(width: 0.0, height: 30.h),
              Column(
                children: [
                  if (model.parentStatus!.imageAVT == '')
                    CircleAvatar(
                      radius: 50.r,
                      backgroundImage: const AssetImage(AppImages.avar),
                    ),
                  if (model.parentStatus!.imageAVT != '')
                    CircleAvatar(
                      radius: 50.r,
                      backgroundImage: NetworkImage(model.parentStatus!.imageAVT.toString()),
                    ),
                ],
              ),
              SizedBox(width: 0.0, height: 15.h),
              Text(
                model.parentStatus!.name.toString(),
                style: AppTextStyle.lableBodyStyle,
              ),
              Text(
                model.parentStatus!.nganhNghe.toString(),
                style: AppTextStyle.lableBodyStyle.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppColors.kPurplePurpleColor,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0).r,
            child: Column(
              children: [
                InformationPage(
                  title: 'Mã ứng viên:',
                  content: model.parentStatus!.id.toString(),
                ),
                SizedBox(width: 0.0, height: 10.h),
                InformationPage(
                  title: 'Email:',
                  content: model.parentStatus!.email.toString(),
                ),
                SizedBox(width: 0.0, height: 10.h),
                InformationPage(
                  title: 'Số điện thoại:',
                  content: model.parentStatus!.phone.toString(),
                ),
                SizedBox(width: 0.0, height: 10.h),
                InformationPage(
                  title: 'Tình trạng hôn nhân:',
                  content: model.parentStatus!.tinhTrangHonNhan.toString(),
                ),
                SizedBox(width: 0.0, height: 10.h),
                InformationPage(
                  title: 'Giới tính:',
                  content: model.parentStatus!.gioiTinh.toString(),
                ),
                SizedBox(width: 0.0, height: 10.h),
                InformationPage(
                  title: 'Ngày sinh:',
                  content: model.parentStatus!.ngaySinh.toString(),
                ),
                SizedBox(width: 0.0, height: 10.h),
                InformationPage(
                  title: 'Lớp:',
                  content: model.parentStatus!.lop.toString(),
                ),
                SizedBox(width: 0.0, height: 10.h),
                InformationPage(
                  title: 'Khóa học:',
                  content: model.parentStatus!.khoaHoc.toString(),
                ),
                SizedBox(width: 0.0, height: 10.h),
                InformationPage(
                  title: 'Sinh viên năm:',
                  content: model.parentStatus!.sinhVienNamMay.toString(),
                ),
                SizedBox(width: 0.0, height: 10.h),
                InformationPage(
                  title: 'Sở trường:',
                  content: model.parentStatus!.soTruong.toString(),
                ),
                SizedBox(width: 0.0, height: 10.h),
                InformationPage(
                  title: 'Kinh nghiệm làm việc:',
                  content: model.parentStatus!.kinhNghiemLamViec.toString(),
                ),
                SizedBox(width: 0.0, height: 10.h),
                InformationPage(
                  title: 'Kỹ năng thành thạo:',
                  content: model.parentStatus!.kyNangThanhThao.toString(),
                ),
                SizedBox(width: 0.0, height: 10.h),
                SizedBox(
                  width: 343.w,
                  child: Row(
                    children: [
                      Expanded(
                        child: ButtonWidget(
                          onTap: () {
                            controller.postUngtuyen(
                                id, 1, model.parentStatus!.email.toString());
                          },
                          text: 'Không đạt yêu cầu',
                          colorBackGroud: AppColors.white,
                          colorBoder: AppColors.kRrror600Color,
                          boder: true.obs,
                          textStyle: AppTextStyle.textButtonStyle
                              .copyWith(color: AppColors.kRrror600Color),
                        ),
                      ),
                      SizedBox(width: 10.w, height: 0.0),
                      Expanded(
                        child: ButtonWidget(
                          onTap: () {
                            controller.postUngtuyen(
                                id, 2, model.parentStatus!.email.toString());
                          },
                          text: 'Đạt yêu cầu',
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
