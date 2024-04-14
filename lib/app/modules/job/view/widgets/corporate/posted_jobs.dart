import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:we_easy/app/modules/job/controller/job_controller.dart';
import 'package:we_easy/app/modules/job/view/widgets/corporate/posted_job_item_page.dart';

import '../../../../../common/util/exports.dart';
import '../../../../widgets/custom_empty_widget.dart';
import '../../../../widgets/custom_not_found_widget.dart';
import '../../loading/loading.dart';

class PostedJobs extends GetView<JobController> {
  const PostedJobs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => controller.getPostJob(),
      child: controller.obx(
        (state) {
          return ListView.separated(
            itemBuilder: (context, index) {
              final model = controller.listPostedJobModel[index];
              String? formattedDateTime = Utils.timestampToDateTime(model.date);
              return PostedJobItemPage(
                model: model,
                time: formattedDateTime.toString(),
              );
            },
            separatorBuilder: (context, index) => SizedBox(
              height: 5.h,
            ),
            itemCount: controller.listPostedJobModel.length,
          );
        },
        onLoading: const Padding(
          padding: EdgeInsets.all(16),
          child: Loading(),
        ),
        onEmpty:Center(child: CustomEmptyWidget(top: 0.12.sh)),
        onError: (error) => Center(
          child: CustomNotFoundWidget(error: error, top: 0.18.sh),
        ),
      ),
    );
  }
}
