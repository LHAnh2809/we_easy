import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:we_easy/app/common/util/exports.dart';
import 'package:we_easy/app/modules/home/controllers/home_controller.dart';
import 'package:we_easy/app/modules/widgets/custom_appbar_widget.dart';

import '../../../../job/view/loading/loading.dart';
import '../../../../widgets/custom_empty_widget.dart';
import '../../../../widgets/custom_not_found_widget.dart';
import 'work_item_widget.dart';

class SearchDestination extends GetView<HomeController> {
  const SearchDestination({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppbarWidget(
        title: 'Tìm kiếm',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16).r,
            child: Text(
              'Tìm kiếm với "${controller.search.text}"',
              style: AppTextStyle.textsmallStyle,
            ),
          ),
          SizedBox(height: 10.h),
          Expanded(
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
          ),
        ],
      ),
    );
  }
}
