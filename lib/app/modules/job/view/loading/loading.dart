import 'package:flutter/material.dart';
import 'package:we_easy/app/common/util/exports.dart';

import '../../../../common/util/shimmer.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // height: 80.h,
          width: 343.w,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12).r,
          decoration: BoxDecoration(
              color: AppColors.kBackgroundColor,
              border: Border.all(color: AppColors.kBackgroundColor, width: 0.5),
              borderRadius: 10.borderRadius),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  customShimmer(width: 40.w, height: 40.h, circle: true),
                  SizedBox(width: 10.w, height: 0.0),
                  Column(
                    children: [
                      customShimmer(width: 250.w, height: 25.h),
                      SizedBox(width: 0.0, height: 4.h),
                      customShimmer(width: 250.w, height: 10.h),
                    ],
                  )
                ],
              ),
              SizedBox(width: 0.0, height: 10.h),
              customShimmer(width: 300.w, height: 15.h),
              SizedBox(width: 0.0, height: 10.h),
              Row(
                children: [
                  customShimmer(width: 25.w, height: 25.h, circle: true),
                  SizedBox(width: 10.w, height: 0.0),
                  customShimmer(width: 100.w, height: 25.h),
                ],
              ),
              SizedBox(width: 0.0, height: 10.h),
              Row(
                children: [
                  customShimmer(width: 25.w, height: 25.h, circle: true),
                  SizedBox(width: 10.w, height: 0.0),
                  customShimmer(width: 100.w, height: 25.h),
                ],
              )
            ],
          ),
        ),
        SizedBox(width: 0.0, height: 10.h),
        Container(
          // height: 80.h,
          width: 343.w,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12).r,
          decoration: BoxDecoration(
              color: AppColors.kBackgroundColor,
              border: Border.all(color: AppColors.kBackgroundColor, width: 0.5),
              borderRadius: 10.borderRadius),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  customShimmer(width: 40.w, height: 40.h, circle: true),
                  SizedBox(width: 10.w, height: 0.0),
                  Column(
                    children: [
                      customShimmer(width: 250.w, height: 25.h),
                      SizedBox(width: 0.0, height: 4.h),
                      customShimmer(width: 250.w, height: 10.h),
                    ],
                  )
                ],
              ),
              SizedBox(width: 0.0, height: 10.h),
              customShimmer(width: 300.w, height: 15.h),
              SizedBox(width: 0.0, height: 10.h),
              Row(
                children: [
                  customShimmer(width: 25.w, height: 25.h, circle: true),
                  SizedBox(width: 10.w, height: 0.0),
                  customShimmer(width: 100.w, height: 25.h),
                ],
              ),
              SizedBox(width: 0.0, height: 10.h),
              Row(
                children: [
                  customShimmer(width: 25.w, height: 25.h, circle: true),
                  SizedBox(width: 10.w, height: 0.0),
                  customShimmer(width: 100.w, height: 25.h),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
