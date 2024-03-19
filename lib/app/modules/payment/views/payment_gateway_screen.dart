import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shopperz/app/modules/cart/controller/cart_controller.dart';
import 'package:shopperz/app/modules/order/views/order_history_screen.dart';
import 'package:shopperz/app/modules/payment/views/payment_failed_screen.dart';
import 'package:shopperz/config/theme/app_color.dart';
import 'package:shopperz/utils/api_list.dart';
import 'package:shopperz/utils/images.dart';
import 'package:shopperz/utils/svg_icon.dart';
import 'package:shopperz/widgets/custom_snackbar.dart';
import 'package:shopperz/widgets/primary_button.dart';
import 'package:shopperz/widgets/textwidget.dart';

class PaymentView extends StatefulWidget {
  final int? orderId;
  final String? slug;
  const PaymentView({super.key, this.orderId,this.slug});
  @override
  _PaymentViewState createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  String? selectedUrl;
  double value = 0.0;
  bool isLoading = true;
  PullToRefreshController pullToRefreshController = PullToRefreshController();
  MyInAppBrowser? browser;

  @override
  void initState() {
    super.initState();
    selectedUrl = ApiList.baseUrl + "/payment/" + widget.slug.toString() + "/pay/" + widget.orderId.toString();
    _initData();
  }

  void _initData() async {
    browser = MyInAppBrowser();
    if (Platform.isAndroid) {
      await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);

      bool swAvailable = await AndroidWebViewFeature.isFeatureSupported(
          AndroidWebViewFeature.SERVICE_WORKER_BASIC_USAGE);
      bool swInterceptAvailable =
          await AndroidWebViewFeature.isFeatureSupported(
              AndroidWebViewFeature.SERVICE_WORKER_SHOULD_INTERCEPT_REQUEST);

      if (swAvailable && swInterceptAvailable) {
        AndroidServiceWorkerController serviceWorkerController =
            AndroidServiceWorkerController.instance();
        await serviceWorkerController
            .setServiceWorkerClient(AndroidServiceWorkerClient(
          shouldInterceptRequest: (request) async {
            return null;
          },
        ));
      }
    }

    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: AppColor.primaryColor,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          browser?.webViewController.reload();
        } else if (Platform.isIOS) {
          browser?.webViewController.loadUrl(
              urlRequest:
                  URLRequest(url: await browser?.webViewController.getUrl()));
        }
      },
    );
    browser?.pullToRefreshController = pullToRefreshController;

    await browser?.openUrlRequest(
      urlRequest: URLRequest(url: Uri.parse(selectedUrl!)),
      options: InAppBrowserClassOptions(
        crossPlatform:
            InAppBrowserOptions(hideUrlBar: true, hideToolbarTop: true),
        inAppWebViewGroupOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
              useShouldOverrideUrlLoading: true, useOnLoadResource: true),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: AppColor.whiteColor,
        body: Center(
          child: Container(
            child: Stack(
              children: [
                isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                AppColor.primaryColor)),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyInAppBrowser extends InAppBrowser {
  bool _canRedirect = true;

  @override
  Future onBrowserCreated() async {}

  @override
  Future onLoadStart(url) async {
    _pageRedirect(url.toString());
  }

  @override
  Future onLoadStop(url) async {
    pullToRefreshController?.endRefreshing();
    _pageRedirect(url.toString());
  }

  @override
  void onLoadError(url, code, message) {
    pullToRefreshController?.endRefreshing();
  }

  @override
  void onProgressChanged(progress) {
    if (progress == 100) {
      pullToRefreshController?.endRefreshing();
    }
  }

  @override
  void onExit() {
    if (_canRedirect) {
      showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              contentPadding: EdgeInsets.all(10.r),
              content: const PaymentFailedView(),
            ),
          );
        },
      );
    }
  }

  @override
  Future<NavigationActionPolicy> shouldOverrideUrlLoading(
      navigationAction) async {
    return NavigationActionPolicy.ALLOW;
  }

  @override
  void onLoadResource(response) {
  }

  @override
  void onConsoleMessage(consoleMessage) {}

  void _pageRedirect(String url) async {
    Future.delayed(const Duration(seconds: 3), () {
      if (_canRedirect) {
        bool isSuccess =
            url.contains('success') && url.contains(ApiList.baseUrl);
        bool isFailed = url.contains('fail') && url.contains(ApiList.baseUrl);
        bool isCancel =
            url.contains('cancel') && url.contains(ApiList.baseUrl);
        bool isBack = url.contains('checkout/payment') && url.contains(ApiList.baseUrl);
        if (isSuccess || isFailed || isCancel || isBack) {
          _canRedirect = false;
          close();
        }
        if (isSuccess) {
          _canRedirect = false;
          close();
          Get.back();

          Get.dialog(
            barrierDismissible: false,
            Dialog(
              insetPadding: EdgeInsets.all(10.r),
              backgroundColor: Colors.transparent,
              child: Stack(
                children: [
                  Container(
                    height: 318.h,
                    width: 328.w,
                    decoration: BoxDecoration(
                        color: AppColor.whiteColor,
                        borderRadius: BorderRadius.circular(16.r)),
                    child: Padding(
                      padding: EdgeInsets.all(16.r),
                      child: Column(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment:
                            CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 16.h,
                          ),
                          TextWidget(
                            text: 'Thank you for your order!'.tr,
                            color: AppColor.textColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Image.asset(
                            AppImages.oderConfirm,
                            height: 120.h,
                            width: 120.w,
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          TextWidget(
                            text: 'Your order is confirmed.'.tr,
                            color: AppColor.textColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          InkWell(
                            onTap: () {
                              Get.off(()=> OrderHistoryScreen());
                            },
                            child: PrimaryButton(
                                text: 'Go to order details'.tr),
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 16.h,
                    right: 16.w,
                    child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: SvgPicture.asset(
                        SvgIcon.close,
                        height: 24.h,
                        width: 24.w,
                      ),
                    ),
                  )
                ],
              ),
            ));
          customSnackbar("SUCCESS".tr,
              "YOUR_PAYMENT_HAS_BEEN_CONFIRMED".tr, AppColor.success);
          CartController cartController = Get.put(CartController());

          cartController.cartItems.clear();

        } else if (isFailed || isCancel || isBack) {
          Get.back();
          customSnackbar(
              "ERROR".tr, "PAYMENT_FAILED".tr, AppColor.error);
        }
      }
    });
  }
}