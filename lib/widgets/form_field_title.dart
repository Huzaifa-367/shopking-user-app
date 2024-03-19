import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_text.dart';

class FormFieldTitle extends StatelessWidget {
  const FormFieldTitle({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      CustomText(
        text: title,
        size: 14.sp,
        weight: FontWeight.w500,
      ),
    ]);
  }
}
