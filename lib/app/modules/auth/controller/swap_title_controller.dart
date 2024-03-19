import 'package:get/get.dart';

class SwapTitleController extends GetxController {
  final isShowEmailField = false.obs;

  bool showEmailField() {
    isShowEmailField.value = !isShowEmailField.value;
    return isShowEmailField.value;
  }
}
