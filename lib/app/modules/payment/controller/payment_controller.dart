import 'package:get/get.dart';
import 'package:shopperz/app/modules/auth/controller/auth_controler.dart';
import 'package:shopperz/app/modules/payment/model/paymet_method.dart';
import 'package:shopperz/app/modules/payment/views/payment_gateway_screen.dart';
import 'package:shopperz/config/theme/app_color.dart';
import 'package:shopperz/data/remote_services/remote_services.dart';
import 'package:shopperz/widgets/custom_snackbar.dart';

class PaymentControllr extends GetxController {
  final paymentModel = PaymentMethodModel().obs;
  final paymentList = <Datum>[].obs;
  final paymentMethodIndex = RxInt(-1);
  final paymentMethodId = 1.obs;

  final isLoading = false.obs;

  final authController = Get.put(AuthController());

  Future<void> fetchPaymentMethods() async {
    final result = await RemoteServices().fetchPaymentMethods();

    result.fold((error) => error, (payment) {
      if(authController.cashOnDelivery == '5')
      {
        paymentList.clear();
        paymentList.add(payment.data![0]);
        paymentModel.value.data = paymentList;
      }

      if(authController.cashOnDelivery == '10')
      {
        paymentList.clear();
        for(var i =1; i<payment.data!.length; i++)
        {
          paymentList.add(payment.data![i]);
          paymentModel.value.data = paymentList;
        }
      }

      if(authController.onlinePayment == '5')
      {
        paymentList.clear();
        for(var i = 0; i<payment.data!.length; i++)
        {
          paymentList.add(payment.data![i]);
          paymentModel.value.data = paymentList;
        }
      }

      if(authController.cashOnDelivery == '10' && authController.onlinePayment == '5')
      {
        paymentList.clear();
        for(var i = 1; i<payment.data!.length; i++)
        {
          paymentList.add(payment.data![i]);
          paymentModel.value.data = paymentList;
        }
      }

      if(authController.onlinePayment == '10')
      {
        paymentList.clear();
        paymentList.add(payment.data![0]);
        paymentList.add(payment.data![1]);
        paymentModel.value.data = paymentList;
      }

      if(authController.cashOnDelivery == '10' && authController.onlinePayment == '10')
      {
        paymentList.clear();
        paymentList.add(payment.data![1]);
        paymentModel.value.data = paymentList;
      }
    });
  }

  confirmOrder({
    required String slug,
    required double subTotal,
    required double shippingCharge,
    required double tax,
    required double total,
    required int shippingId,
    required int billingId,
    required int outletId,
    required int couponId,
    required int orderType,
    required int source,
    required int paymentMethod,
    required String products,
    required double discount,
  }) async {
  isLoading(true);
   var response = await RemoteServices().confirmOrder(
        subTotal: subTotal,
        shippingCharge: shippingCharge,
        tax: tax,
        total: total,
        shippingId: shippingId,
        billingId: billingId,
        outletId: outletId,
        couponId: couponId,
        orderType: orderType,
        source: source,
        discount: discount,
        paymentMethod: paymentMethod,
        products: products);


    if (response != null && response.statusCode == 201) {
        isLoading(false);
        int orderId = response.data['data']['id'];
        Get.to(()=> PaymentView(
          orderId: orderId,
          slug: slug,
        ));

      } else {
        isLoading(false);
        Get.back();
        Future.delayed(const Duration(milliseconds: 10), () {
          customSnackbar("ERROR".tr, "SOMETHING_WRONG".tr, AppColor.error);
          update();
        });
      }
  }

  @override
  void onInit() {
    fetchPaymentMethods();
    authController.getSetting();
    super.onInit();
  }
}
