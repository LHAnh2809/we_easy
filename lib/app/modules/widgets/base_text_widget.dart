import 'package:flutter/material.dart';

import '../../common/util/exports.dart';

class BaseText extends StatelessWidget {
  final String text;
  final bool isOptional;
  final TextStyle? textStyle;
  const BaseText(
      {Key? key, required this.text, this.isOptional = false, this.textStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(text, style: textStyle ?? AppTextStyle.textbodyStyle),
        if (!isOptional)
          Text(" *",
              style: AppTextStyle.textbodyStyle.copyWith(color: Colors.red))
        else
          Text('Lựa chọn', style: textStyle ?? AppTextStyle.textbodyStyle),
      ],
    );
  }
}
