import 'package:get/get.dart';
import 'package:shopperz/app/modules/home/model/category_model.dart';
import 'package:shopperz/data/remote_services/remote_services.dart';

class CategoryController extends GetxController {
  final isLoading = false.obs;
  final categoryModel = CategoryModel().obs;

  Future<void> fetchCategory() async {
    isLoading(true);
    final data = await RemoteServices().fetchCategory();
    isLoading(false);
    data.fold((error) => error.toString(), (category) {
      categoryModel.value = category;
    });
  }

  @override
  void onInit() {
    fetchCategory();
    super.onInit();
  }
}
