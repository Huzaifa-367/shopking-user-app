import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config/theme/app_color.dart';

// ignore: must_be_immutable
class TitleWidget extends StatelessWidget {
  TitleWidget({super.key, required this.text});
  String? text;

  @override
  Widget build(BuildContext context) {
    return Text(
      '$text',
      style: GoogleFonts.urbanist(
          color: AppColor.titleTextColor,
          fontWeight: FontWeight.w700,
          fontSize: 22.sp),
    );
  }
}
