import 'package:get/get.dart';

class SwapTitleController extends GetxController {
  final isShowEmailField = true.obs;

  bool showEmailField() {
    isShowEmailField.value = !isShowEmailField.value;
    return isShowEmailField.value;
  }
}
