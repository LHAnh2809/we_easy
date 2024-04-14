import 'package:flutter/material.dart';

import '../../../../../common/util/exports.dart';

class InformationPage extends StatelessWidget {
  final String title;
  final String content;
  const InformationPage({Key? key, required this.title, required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: AppTextStyle.textbodyStyle,
        ),
        SizedBox(width: 5.w, height: 0.0),
        Text(
          content,
          style: AppTextStyle.textsmallStyle,
        ),
      ],
    );
  }
}
