import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopperz/config/theme/app_color.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:shopperz/data/model/order_details_model.dart' as order;
import 'package:shopperz/data/model/setting_model.dart' as info;

class PrintInvoice extends StatefulWidget {
  final info.Data? comapnyInfo;
  final order.Data? orderDetails;
  final address;
  const PrintInvoice(
      {super.key,
      required this.comapnyInfo,
      required this.orderDetails,
      this.address});

  @override
  State<PrintInvoice> createState() => _PrintInvoiceState();
}

class _PrintInvoiceState extends State<PrintInvoice> {
  final GlobalKey<State<StatefulWidget>> keys = GlobalKey();
  final box = GetStorage();
  @override
  void initState() {
    super.initState();
  }

  void _printScreen() {
    Printing.layoutPdf(onLayout: (PdfPageFormat format) async {
      final doc = pw.Document();

      final image = await WidgetWraper.fromKey(
        key: keys,
        pixelRatio: 2.0,
      );

      doc.addPage(pw.Page(
          pageFormat: format,
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Expanded(
                child: pw.Image(image),
              ),
            );
          }));

      return doc.save();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value:const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SingleChildScrollView(
              child: RepaintBoundary(
                key: keys,
                child: Padding(
                  padding: EdgeInsets.only(top: 40.h,left: 16.w,right: 16.w,bottom: 16.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          widget.comapnyInfo!.companyName.toString(),
                          textAlign: TextAlign.center,
                          style: GoogleFonts.ptSans(
                              color: AppColor.textColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 24.sp),
                        ),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Center(
                        child: Text(
                          widget.comapnyInfo!.companyAddress.toString(),
                          textAlign: TextAlign.center,
                          style: GoogleFonts.ptSans(
                              color: AppColor.textColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp),
                        ),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Center(
                        child: Text(
                          "Tel:".tr + " ${widget.comapnyInfo!.companyCallingCode.toString() + widget.comapnyInfo!.companyPhone.toString()}",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.ptSans(
                              color: AppColor.textColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp),
                        ),
                      ),
                      Center(
                        child: FittedBox(
                          child: Text(
                            "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.ptSans(
                                color: AppColor.textColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 14.sp),
                          ),
                        ),
                      ),
                      Text(
                        "Order#".tr + "${widget.orderDetails!.orderSerialNo.toString()}",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.ptSans(
                            color: AppColor.textColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.orderDetails!.orderDate.toString(),
                            textAlign: TextAlign.left,
                            style: GoogleFonts.ptSans(
                                color: AppColor.textColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 12.sp),
                          ),
                          Text(
                            widget.orderDetails!.orderTime.toString(),
                            textAlign: TextAlign.left,
                            style: GoogleFonts.ptSans(
                                color: AppColor.textColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 12.sp),
                          ),
                        ],
                      ),
                      Center(
                        child: FittedBox(
                          child: Text(
                            "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.ptSans(
                                color: AppColor.textColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 14.sp),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              "Qty".tr,
                              textAlign: TextAlign.left,
                              style: GoogleFonts.ptSans(
                                  color: AppColor.textColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 11.sp),
                            ),
                          ),
                          Expanded(
                            flex: 10,
                            child: Text(
                              "Product Description".tr,
                              textAlign: TextAlign.left,
                              style: GoogleFonts.ptSans(
                                  color: AppColor.textColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 11.sp),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              "Price".tr,
                              textAlign: TextAlign.left,
                              style: GoogleFonts.ptSans(
                                  color: AppColor.textColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 11.sp),
                            ),
                          ),
                        ],
                      ),
                      Center(
                        child: FittedBox(
                          child: Text(
                            "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.ptSans(
                                color: AppColor.textColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 14.sp),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      ListView.builder(
                        primary: false,
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: widget.orderDetails!.orderProducts!.length,
                        itemBuilder: (BuildContext context, index) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: 10.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    widget.orderDetails!.orderProducts![index]
                                        .quantity
                                        .toString(),
                                    style: const TextStyle(
                                        color: AppColor.textColor),
                                  ),
                                ),
                                Expanded(
                                  flex: 11,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            widget.orderDetails!
                                                .orderProducts![index].productName
                                                .toString(),
                                            style: GoogleFonts.ptSans(
                                                color: AppColor.textColor,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14.sp),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(
                                            height: 2.h,
                                          ),
                                          Text(
                                            widget
                                                .orderDetails!
                                                .orderProducts![index]
                                                .variationNames
                                                .toString(),
                                            style: GoogleFonts.ptSans(
                                                color: AppColor.textColor,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 11.sp),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 4.w,
                                      ),
                                      Text(
                                        widget.orderDetails!.orderProducts![index]
                                            .subtotalCurrencyPrice
                                            .toString(),
                                        style: GoogleFonts.ptSans(
                                            color: AppColor.textColor,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 11.sp),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      Center(
                        child: FittedBox(
                          child: Text(
                            "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.ptSans(
                                color: AppColor.textColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 14.sp),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Expanded(
                                flex: 1,
                                child: SizedBox(),
                              ),
                              Expanded(
                                flex: 11,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Subtotal'.tr,
                                      style: GoogleFonts.ptSans(
                                          color: AppColor.textColor,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 11.sp),
                                    ),
                                    SizedBox(
                                      width: 4.w,
                                    ),
                                    Text(
                                      widget.orderDetails!.subtotalCurrencyPrice
                                          .toString(),
                                      style: GoogleFonts.ptSans(
                                          color: AppColor.textColor,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 11.sp),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Expanded(
                                flex: 1,
                                child: SizedBox(),
                              ),
                              Expanded(
                                flex: 11,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Tax'.tr,
                                      style: GoogleFonts.ptSans(
                                          color: AppColor.textColor,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 11.sp),
                                    ),
                                    SizedBox(
                                      width: 4.w,
                                    ),
                                    Text(
                                      widget.orderDetails!.taxCurrencyPrice
                                          .toString(),
                                      style: GoogleFonts.ptSans(
                                          color: AppColor.textColor,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 11.sp),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Expanded(
                                flex: 1,
                                child: SizedBox(),
                              ),
                              Expanded(
                                flex: 11,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Discount'.tr,
                                      style: GoogleFonts.ptSans(
                                          color: AppColor.textColor,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 11.sp),
                                    ),
                                    SizedBox(
                                      width: 4.w,
                                    ),
                                    Text(
                                      widget.orderDetails!.discountCurrencyPrice
                                          .toString(),
                                      style: GoogleFonts.ptSans(
                                          color: AppColor.textColor,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 11.sp),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          widget.orderDetails!.orderType == 10
                              ? const SizedBox()
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Expanded(
                                      flex: 1,
                                      child: SizedBox(),
                                    ),
                                    Expanded(
                                      flex: 11,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Shipping Charge'.tr,
                                            style: GoogleFonts.ptSans(
                                                color: AppColor.textColor,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 11.sp),
                                          ),
                                          SizedBox(
                                            width: 4.w,
                                          ),
                                          Text(
                                            widget.orderDetails!
                                                .shippingChargeCurrencyPrice
                                                .toString(),
                                            style: GoogleFonts.ptSans(
                                                color: AppColor.textColor,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 11.sp),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                          SizedBox(
                            height: 4.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Expanded(
                                flex: 1,
                                child: SizedBox(),
                              ),
                              Expanded(
                                flex: 11,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Total'.tr,
                                      style: GoogleFonts.ptSans(
                                          color: AppColor.textColor,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 11.sp),
                                    ),
                                    SizedBox(
                                      width: 4.w,
                                    ),
                                    Text(
                                      widget.orderDetails!.totalCurrencyPrice
                                          .toString(),
                                      style: GoogleFonts.ptSans(
                                          color: AppColor.textColor,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 11.sp),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Center(
                            child: FittedBox(
                              child: Text(
                                "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.ptSans(
                                    color: AppColor.textColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.sp),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                  flex:
                                      box.read('languageCode') == 'fr' ? 5 : 3,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'Order Type'.tr,
                                            style: GoogleFonts.ptSans(
                                                color: AppColor.textColor,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 11.sp),
                                          ),
                                          Text(
                                            ':',
                                            style: GoogleFonts.ptSans(
                                                color: AppColor.textColor,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 11.sp),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 4.h,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Payment Type'.tr,
                                            style: GoogleFonts.ptSans(
                                                color: AppColor.textColor,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 11.sp),
                                          ),
                                          Text(
                                            ':',
                                            style: GoogleFonts.ptSans(
                                                color: AppColor.textColor,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 11.sp),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 4.h,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Order Date Time'.tr,
                                            style: GoogleFonts.ptSans(
                                                color: AppColor.textColor,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 11.sp),
                                          ),
                                          Text(
                                            ':',
                                            style: GoogleFonts.ptSans(
                                                color: AppColor.textColor,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 11.sp),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                              SizedBox(
                                width: 4.w,
                              ),
                              Expanded(
                                  flex: 8,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.orderDetails!.orderType == 5
                                            ? 'Delivery'.tr
                                            : widget.orderDetails!.orderType ==
                                                    10
                                                ? 'Pickup'.tr
                                                : widget.orderDetails!
                                                            .orderType ==
                                                        15
                                                    ? 'POS'.tr
                                                    : '',
                                        style: GoogleFonts.ptSans(
                                            color: AppColor.textColor,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 11.sp),
                                      ),
                                      SizedBox(
                                        height: 4.h,
                                      ),
                                      Text(
                                        widget.orderDetails!.paymentMethodName
                                            .toString(),
                                        style: GoogleFonts.ptSans(
                                            color: AppColor.textColor,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 11.sp),
                                      ),
                                      SizedBox(
                                        height: 4.h,
                                      ),
                                      Text(
                                        widget.orderDetails!.orderDatetime
                                            .toString(),
                                        style: GoogleFonts.ptSans(
                                            color: AppColor.textColor,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 11.sp),
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                          Center(
                            child: FittedBox(
                              child: Text(
                                "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.ptSans(
                                    color: AppColor.textColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.sp),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                  flex:
                                      box.read('languageCode') == 'fr' ? 5 : 3,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'Customer'.tr,
                                            style: GoogleFonts.ptSans(
                                                color: AppColor.textColor,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 11.sp),
                                          ),
                                          Text(
                                            ':',
                                            style: GoogleFonts.ptSans(
                                                color: AppColor.textColor,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 11.sp),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 4.h,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Phone'.tr,
                                            style: GoogleFonts.ptSans(
                                                color: AppColor.textColor,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 11.sp),
                                          ),
                                          Text(
                                            ':',
                                            style: GoogleFonts.ptSans(
                                                color: AppColor.textColor,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 11.sp),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 4.h,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            widget.orderDetails!.outletAddress == null ? 'Address'.tr : 'Outlet'.tr,
                                            style: GoogleFonts.ptSans(
                                                color: AppColor.textColor,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 11.sp),
                                          ),
                                          Text(
                                            ':',
                                            style: GoogleFonts.ptSans(
                                                color: AppColor.textColor,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 11.sp),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                              SizedBox(
                                width: 4.w,
                              ),
                              widget.orderDetails!.outletAddress != null ?
                              Expanded(
                                  flex: 8,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.orderDetails!.outletAddress!
                                            .name
                                            .toString(),
                                        style: GoogleFonts.ptSans(
                                            color: AppColor.textColor,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 11.sp),
                                      ),
                                      SizedBox(
                                        height: 4.h,
                                      ),
                                      Text(
                                        widget.orderDetails!.outletAddress!
                                                .countryCode
                                                .toString() +
                                            widget.orderDetails!
                                                .outletAddress!.phone
                                                .toString(),
                                        style: GoogleFonts.ptSans(
                                            color: AppColor.textColor,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 11.sp),
                                      ),
                                      SizedBox(
                                        height: 4.h,
                                      ),
                                      Text(
                                        widget.address.toString(),
                                        style: GoogleFonts.ptSans(
                                            color: AppColor.textColor,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 11.sp),
                                      ),
                                    ],
                                  )):
                              Expanded(
                                  flex: 8,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.orderDetails!.orderAddress![0]
                                            .fullName
                                            .toString(),
                                        style: GoogleFonts.ptSans(
                                            color: AppColor.textColor,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 11.sp),
                                      ),
                                      SizedBox(
                                        height: 4.h,
                                      ),
                                      Text(
                                        widget.orderDetails!.orderAddress![0]
                                                .countryCode
                                                .toString() +
                                            widget.orderDetails!
                                                .orderAddress![0].phone
                                                .toString(),
                                        style: GoogleFonts.ptSans(
                                            color: AppColor.textColor,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 11.sp),
                                      ),
                                      SizedBox(
                                        height: 4.h,
                                      ),
                                      Text(
                                        widget.address.toString(),
                                        style: GoogleFonts.ptSans(
                                            color: AppColor.textColor,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 11.sp),
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                          Center(
                            child: FittedBox(
                              child: Text(
                                "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.ptSans(
                                    color: AppColor.textColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.sp),
                              ),
                            ),
                          ),
                          Center(
                            child: FittedBox(
                              child: Text(
                                "Thank You".tr,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.ptSans(
                                    color: AppColor.textColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 11.sp),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 14.h,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Powered by".tr,
                                textAlign: TextAlign.right,
                                style: GoogleFonts.ptSans(
                                    color: AppColor.textColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 9.sp),
                              ),
                              Text(
                                widget.comapnyInfo!.companyName.toString(),
                                textAlign: TextAlign.right,
                                style: GoogleFonts.ptSans(
                                    color: AppColor.textColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.sp),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 50.h,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: SizedBox(
                  child: Padding(
                    padding: EdgeInsets.all(20.r),
                    child: InkWell(
                      onTap: () {
                        _printScreen();
                      },
                      child: Container(
                        height: 40.h,
                        decoration: BoxDecoration(
                          color: AppColor.primaryColor,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Center(
                          child: Text(
                            "Print Invoice".tr,
                            textAlign: TextAlign.right,
                            style: GoogleFonts.ptSans(
                                color: AppColor.whiteColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 12.sp),
                          ),
                        ),
                      ),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
