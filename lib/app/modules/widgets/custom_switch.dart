import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../../common/util/exports.dart';

class CustomSwitch extends StatelessWidget {
  final RxBool? value;
  final Function(bool) onToggle;

  const CustomSwitch({
    Key? key,
    required this.value,
    required this.onToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlutterSwitch(
      width: 40.w,
      height: 24.h,
      padding: 2.r,
      value: value?.value ?? false,
      toggleColor: AppColors.white,
      activeColor: AppColors.kGray1000Color,
      inactiveColor: AppColors.kGray300Color,
      onToggle: onToggle,
    );
  }
}
