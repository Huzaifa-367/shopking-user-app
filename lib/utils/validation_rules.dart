import 'package:get/get.dart';
import 'package:shopperz/utils/constant.dart';

class ValidationRules {
  String? normal(String? value) {
    if (value == null || value.isEmpty) {
      return "This field is required";
    }
    return null;
  }

  email(String? value) {
    RegExp regExp = RegExp(regularExpressionEmail);
    if (value == null || value.isEmpty) {
      return "Email is required";
    } 
    else if(!regExp.hasMatch(value))
    {
      return 'Enter Valid Email Address'.tr;
    }
    else if (!value.contains('@')) {
      return "Enter a valid email please";
    } else {
      return null;
    }
  }

  password(String? value) {
    if (value == null || value.isEmpty) {
      return "Passord is required";
    } else if (value.length <= 5) {
      return "Password is short";
    } else {
      return null;
    }
  }
}
