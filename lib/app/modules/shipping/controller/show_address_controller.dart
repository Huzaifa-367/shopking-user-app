import 'package:get/get.dart';
import 'package:shopperz/app/modules/shipping/model/outlet_model.dart';
import 'package:shopperz/app/modules/shipping/model/show_address.dart';
import 'package:shopperz/data/remote_services/remote_services.dart';
import 'package:shopperz/main.dart';
import '../model/area_shipping.dart';

class ShowAddressController extends GetxController {
  final addressSelected = false.obs;
  final billingAddressSelected = true.obs;
  final isLoading = false.obs;
  final addressList = ShowAddressModel().obs;
  final outlestModel = OutletModel().obs;
  final areaShippingModel = AreaShippingModel().obs;

  final selectedAddressIndex = RxInt(-1);
  final selectedBillingAddressIndex = RxInt(-1);

  final selectedOutletIndex = RxInt(-1);

  final selectedPickUp = false.obs;

  Future<void> showAdresses() async {
    isLoading(true);
    final result = await RemoteServices().fetchAddress();
    isLoading(false);

    result.fold(
      (error) {
        isLoading(false);
      },
      (address) {
        isLoading(false);
        addressList.value = address;

        return addressList.value;
      },
    );
  }

  Future<void> fetchOutlets() async {
    final result = await RemoteServices().fetchOutlets();

    result.fold((error) => error, (outlet) {
      outlestModel.value = outlet;
    });
  }

  void setSelectedAddressIndex(int index) {
    selectedAddressIndex.value = index;
  }

  void setSelectedBillingAddressIndex(int index) {
    selectedBillingAddressIndex.value = index;
  }

  void setoutletIndex(int index) {
    selectedOutletIndex.value = index;
  }

  Future<void> fetchShippingArea() async {
    final result = await RemoteServices().fetchShippingArea();
    result.fold((l) => null, (shippingArea) {
      areaShippingModel.value = shippingArea;
    });
  }

  @override
  void onInit() {
    if (box.read('isLogedIn') != false) {
      showAdresses();
      fetchOutlets();
      fetchShippingArea();
    }
    super.onInit();
  }
}
