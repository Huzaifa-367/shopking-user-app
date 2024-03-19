import 'package:get/get.dart';
import 'package:shopperz/app/modules/home/model/slider_model.dart';
import 'package:shopperz/data/remote_services/remote_services.dart';

class SliderController extends GetxController {
  final isLoading = false.obs;
  final sliderData = SliderModel().obs;
  final dotIndex = 0.obs;

  Future<void> fetchSlider() async {
    isLoading(true);
    final data = await RemoteServices().fetchSlider();
    isLoading(false);
    data.fold((error) => error.toString(), (dataModel) {
      sliderData.value = dataModel;
    });
  }

  void handleSliderDots(int index) {
    dotIndex.value = index;
  }

  @override
  void onInit() {
    fetchSlider();
    super.onInit();
  }
}
