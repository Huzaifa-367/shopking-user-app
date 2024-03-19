import 'package:get/get.dart';
import 'package:shopperz/app/modules/home/model/product_section.dart';
import 'package:shopperz/data/remote_services/remote_services.dart';

class ProductSectionController extends GetxController {
  final isLoading = false.obs;
  final productSection = ProductSectionModel().obs;

  Future<void> fetchProductSection() async {
    isLoading(true);
    final data = await RemoteServices().fetchProductSection();
    isLoading(false);
    data.fold((error) => error.toString(), (sectionModel) {
      productSection.value = sectionModel;
    });
  }

  @override
  void onInit() {
    fetchProductSection();
    super.onInit();
  }
}
