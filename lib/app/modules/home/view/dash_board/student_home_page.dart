import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:we_easy/app/modules/home/controllers/home_controller.dart';
import 'package:we_easy/app/modules/home/view/dash_board/widgets/search_widget.dart';
import 'package:we_easy/app/modules/home/view/dash_board/widgets/work_item_widget.dart';
import 'package:we_easy/app/modules/widgets/button_widget.dart';

import '../../../../common/util/exports.dart';
import '../../../job/view/loading/loading.dart';
import '../../../widgets/custom_empty_widget.dart';
import '../../../widgets/custom_not_found_widget.dart';

class StudentHomePage extends GetView<HomeController> {
  const StudentHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          toolbarHeight: 120.h,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 0.0, height: 10.h),
              ButtonWidget(
                onTap: () {
                  Get.to(() => SearchWidget());
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
                  child: Text(
                    'Tìm kiếm',
                    style: AppTextStyle.textsmallStyle60016
                        .copyWith(color: AppColors.kGray300Color),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16).r,
                child: Text(
                  'Việc làm hấp dẫn',
                  style: AppTextStyle.lableBodyStyle,
                ),
              ),
            ],
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () => controller.getPostJob(''),
          child: controller.obx(
            (state) {
              return ListView.separated(
                itemBuilder: (context, index) {
                  final model = controller.listAllJobModel[index];
                  String? formattedDateTime =
                      Utils.timestampToDateTime(model.date);
                  return WorkItemWidget(
                    model: model,
                    time: formattedDateTime.toString(),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(
                  height: 5.h,
                ),
                itemCount: controller.listAllJobModel.length,
              );
            },
            onLoading: const Padding(
              padding: EdgeInsets.all(16),
              child: Loading(),
            ),
            onEmpty: Center(child: CustomEmptyWidget(top: 0.12.sh)),
            onError: (error) => Center(
              child: CustomNotFoundWidget(error: error, top: 0.18.sh),
            ),
          ),
        ));
  }
}
