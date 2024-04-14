import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/util/exports.dart';
import '../controllers/home_controller.dart';
import 'widgets/bottomNavigationBarItem_widget.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => controller.screens[controller.selectedIndex.value],
      ),
      bottomNavigationBar: Obx(
        () => Stack(
          children: [
            Container(
              height: 56.0.h,
            ),
            Theme(
              data: Theme.of(context).copyWith(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
              child: BottomNavigationBar(
                backgroundColor: AppColors.white,
                showUnselectedLabels: true,
                showSelectedLabels: true,
                type: BottomNavigationBarType.fixed,
                unselectedFontSize: 12.sp,
                selectedFontSize: 12.sp,
                // iconSize: 20.sp,
                items: <BottomNavigationBarItem>[
                  _buildBottomNavigationBarItem(
                    AppImages.homePage,
                    'Trang chủ',
                    controller.selectedIndex.value == 0
                        ? [
                            AppColors.kBrightPurpleColor,
                            AppColors.kDarkPurpleColor
                          ]
                        : [
                            AppColors.kGrayTextFormColor,
                            AppColors.kGrayTextFormColor
                          ],
                  ),
                  _buildBottomNavigationBarItem(
                    AppImages.iconCircleCheck,
                    'Công việc',
                    controller.selectedIndex.value == 1
                        ? [
                            AppColors.kBrightPurpleColor,
                            AppColors.kDarkPurpleColor
                          ]
                        : [
                            AppColors.kGrayTextFormColor,
                            AppColors.kGrayTextFormColor
                          ],
                  ),
                  _buildBottomNavigationBarItem(
                    AppImages.iconAccount,
                    'Tài khoản',
                    controller.selectedIndex.value == 2
                        ? [
                            AppColors.kBrightPurpleColor,
                            AppColors.kDarkPurpleColor
                          ]
                        : [
                            AppColors.kGrayTextFormColor,
                            AppColors.kGrayTextFormColor
                          ],
                  ),
                ],
                selectedItemColor: AppColors.black,
                unselectedItemColor: AppColors.kGrayTextFormColor,
                selectedLabelStyle:
                    const TextStyle(fontWeight: FontWeight.w600),
                currentIndex: controller.selectedIndex.value,
                onTap: (int index) {
                  controller.selectedIndex.value = index;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(
    String imagePath,
    String label,
    List<Color> colors,
  ) {
    return BottomNavigationBarItem(
      icon: BottomNavigationBarItemWidget(imagePath: imagePath, colors: colors),
      label: label,
    );
  }
}
