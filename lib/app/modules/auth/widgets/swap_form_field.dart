import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/custom_form_field.dart';
import '../../../../widgets/custom_phone_form_field.dart';
import '../controller/swap_title_controller.dart';

class SwapFormField extends StatelessWidget {
  const SwapFormField(
      {super.key,
      this.phoneController,
      this.emailController,
      this.phoneValidator,
      this.prefix,
      this.emailValidator});

  final TextEditingController? phoneController;
  final TextEditingController? emailController;

  final String? Function(String?)? phoneValidator;
  final String? Function(String?)? emailValidator;

  final Widget? prefix;

  @override
  Widget build(BuildContext context) {
    final swapTitleController = Get.find<SwapTitleController>();
    return Obx(
      () {
        return swapTitleController.isShowEmailField.value
            ? CustomFormField(
                controller: emailController,
                validator: emailValidator,
              )
            : CustomPhoneFormField(
                phoneController: phoneController,
                validator: phoneValidator,
                prefix: prefix,
              );
      },
    );
  }
}
