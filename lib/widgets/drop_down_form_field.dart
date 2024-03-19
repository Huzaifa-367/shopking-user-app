import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropDownField extends StatefulWidget {
  const CustomDropDownField({super.key});

  @override
  State<CustomDropDownField> createState() => _CustomDropDownFieldState();
}

class _CustomDropDownFieldState extends State<CustomDropDownField> {
  String? selectedValue;
  final items = <String>["Dhaka", "Munshiganj", "Sirajganj", "Sylhet"];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: Colors.black12)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: DropdownButtonFormField<String>(
          value: selectedValue,
          items: items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              selectedValue = newValue;
            });
          },
          decoration: const InputDecoration(
            border: UnderlineInputBorder(
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}
