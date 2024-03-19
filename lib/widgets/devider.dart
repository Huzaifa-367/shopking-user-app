import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../config/theme/app_color.dart';

class DeviderWidget extends StatelessWidget {
  const DeviderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.h,
      width: double.infinity,
      color: AppColor.borderColor,
    );
  }
}
