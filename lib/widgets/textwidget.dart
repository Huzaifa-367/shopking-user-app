import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TextWidget extends StatelessWidget {
  const TextWidget(
      {super.key,
      required this.text,
      this.textAlign,
      this.color,
      this.fontSize,
      this.fontWeight,
      this.maxLines,
      this.overflow,
      this.decoration});
  final String? text;
  final Color? color;
  final FontWeight? fontWeight;
  final double? fontSize;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return Text(
      '$text',
      textAlign: textAlign,
      style: GoogleFonts.urbanist(
          color: color,
          fontWeight: fontWeight,
          fontSize: fontSize,
          decoration: decoration,
          height: 1.h,
          decorationThickness: 5),
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
