import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:we_easy/app/modules/widgets/custom_appbar_widget.dart';

import '../../../../../common/util/exports.dart';
import '../../../../widgets/animations/left_to_right_animation.dart';
import '../../../../widgets/flutter_dropdown_search.dart';
import '../../../controllers/home_controller.dart';
import 'search_destination.dart';

class SearchWidget extends GetView<HomeController> {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppbarWidget(
        addBackButton: true,
        onBackPress: () {
          controller.getPostJob('');
          controller.search.text = '';
          Get.back();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16).r,
        child: Column(
          children: [
            LeftToRightAnimation(
                delay: 100.ms,
                child: FlutterDropdownSearch(
                  hintText: 'Tìm kiếm',
                  style: AppTextStyle.textsmallStyle,
                  dropdownTextStyle: AppTextStyle.textsmallStyle,
                  textController: controller.search,
                  dropdownBgColor: AppColors.kGray050Color,
                  items:
                      controller.listJobModel.map((job) => job.name!).toList(),
                  dropdownHeight: 300,
                  onFieldSubmitted: (value) {
                    controller.getPostJob(controller.search.text);
                    Get.to(() => const SearchDestination());
                  },
                )),
          ],
        ),
      ),
    );
  }
}
