import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../config/theme/app_color.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField(
      {super.key, this.controller, this.validator, this.obsecure, this.keyboardType});

  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool? obsecure;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        style: GoogleFonts.urbanist(
            color: AppColor.textColor,
            fontWeight: FontWeight.w500,
            fontSize: 16.sp),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: obsecure ?? false,
        cursorColor: AppColor.textColor,
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          prefix: SizedBox(
            width: 10.w,
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColor.inactiveColor), 
            borderRadius: BorderRadius.circular(8.r),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColor.inactiveColor),
            borderRadius: BorderRadius.circular(8.r),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColor.inactiveColor),
            borderRadius: BorderRadius.circular(8.r),
          ),
          hintStyle: GoogleFonts.urbanist(
                  color: AppColor.textColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp),
        ),
        validator: validator,
      ),
    );
  }
}
