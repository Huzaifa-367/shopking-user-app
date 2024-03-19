import 'package:get/get.dart';
import 'package:shopperz/app/modules/home/model/promotion_model.dart';
import 'package:shopperz/data/remote_services/remote_services.dart';

class PromotionalController extends GetxController {
  final isLoading = false.obs;
  final loading = false.obs;
  final promotionModel = PromotionModel().obs;
  final multiPromotionModel = PromotionModel().obs;

  Future<void> fetchPromotion() async {
    isLoading(true);
    final data = await RemoteServices().fetchPromotion();
    isLoading(false);
    data.fold((error) => error.toString(), (promotion) {
      promotionModel.value = promotion;
    });
  }

  Future<void> fetchMultiPromotion() async {
    loading(true);
    final data = await RemoteServices().fetchMultiPromotion();
    loading(false);
    data.fold((error) => error.toString(), (promotion) {
      multiPromotionModel.value = promotion;
    });
  }

  @override
  void onInit() {
    fetchPromotion();
    fetchMultiPromotion();
    super.onInit();
  }
}
