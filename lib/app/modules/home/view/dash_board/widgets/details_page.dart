import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../../common/util/exports.dart';
import '../../../../widgets/custom_svg.dart';

class DetailsPage extends StatelessWidget {
  final String iconL;
  final String iconR;
  final String titleL;
  final String titleR;
  final String contentL;
  final String contentR;
  final bool? noR;
  const DetailsPage(
      {Key? key,
      required this.iconL,
      required this.iconR,
      required this.titleL,
      required this.titleR,
      required this.contentL,
      required this.contentR,
      this.noR})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: noR != true ? 165.w : null,
          child: Row(
            children: [
              Container(
                width: 40.w,
                height: 40.h,
                padding: const EdgeInsets.all(7).r,
                decoration: BoxDecoration(
                  color: AppColors.kGray300Color,
                  borderRadius: BorderRadius.circular(40).r,
                ),
                child: CustomSvg(
                  image: iconL,
                  color: AppColors.kPurplePurpleColor,
                  width: 24.w,
                  height: 24.h,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 5.w, height: 0.0),
              SizedBox(
                width: noR != true ? 120.w : null,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      titleL,
                      style: AppTextStyle.textxsmallStyle
                          .copyWith(color: AppColors.kGray400Color),
                    ),
                    Text(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      contentL,
                      style: AppTextStyle.textxsmallStyle,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (noR != true)
          SizedBox(
            width: 165.w,
            child: Row(
              children: [
                Container(
                  width: 40.w,
                  height: 40.h,
                  padding: const EdgeInsets.all(7).r,
                  decoration: BoxDecoration(
                    color: AppColors.kGray300Color,
                    borderRadius: BorderRadius.circular(40).r,
                  ),
                  child: CustomSvg(
                    image: iconR,
                    color: AppColors.kPurplePurpleColor,
                    width: 24.w,
                    height: 24.h,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 5.w, height: 0.0),
                SizedBox(
                  width: 120.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        titleR,
                        style: AppTextStyle.textxsmallStyle
                            .copyWith(color: AppColors.kGray400Color),
                      ),
                      Text(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        contentR,
                        style: AppTextStyle.textxsmallStyle,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
