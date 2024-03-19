import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopperz/app/modules/order/controller/return_controller.dart';
import 'package:shopperz/app/modules/order/widgets/order3.dart';
import 'package:shopperz/app/modules/profile/widgets/image_size_chekcer.dart';
import 'package:shopperz/data/model/order_details_model.dart';
import 'package:shopperz/main.dart';
import 'package:shopperz/utils/svg_icon.dart';
import 'package:shopperz/widgets/appbar3.dart';
import 'package:shopperz/widgets/custom_snackbar.dart';
import 'package:shopperz/widgets/devider.dart';
import 'package:shopperz/widgets/loader/loader.dart';
import 'package:shopperz/widgets/textwidget.dart';

import '../../../../config/theme/app_color.dart';

class ReturnRequestScreen extends StatefulWidget {
  const ReturnRequestScreen({super.key, required this.order});
  final Data? order;

  @override
  State<ReturnRequestScreen> createState() => _ReturnRequestScreenState();
}

class _ReturnRequestScreenState extends State<ReturnRequestScreen> {
  ReturnController returnController = Get.put(ReturnController());
  TextEditingController imagePathController = TextEditingController();
  TextEditingController reason = TextEditingController();
  TextEditingController returnNote = TextEditingController();

  List<File> selectedImages = [];

  Future pickImage() async {
    final picker = ImagePicker();
    var pickedFile = await picker.pickMultiImage();
    List<XFile> xfilePick = pickedFile;
    if (xfilePick.isNotEmpty) {
      for (var i = 0; i < xfilePick.length; i++) {
        double imageSize = await ImageSize.getImageSize(xfilePick[i]);
        if (imageSize > 2) {
          customSnackbar(
              "ERROR".tr, "IMAGE_SHOULD_BE_LESS_THAN_2MB".tr, AppColor.error);
        } else {
          selectedImages.add(File(xfilePick[i].path));
        }
      }
      setState(
        () {},
      );
      imagePathController.text = '${selectedImages.length} files';
      setState(() {});
    } else {
      selectedImages.clear();
      imagePathController.text = '';
      setState(() {});
      customSnackbar("ERROR".tr, "Nothing is selected".tr, AppColor.error);
    }
  }

  final formkey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (box.read('isLogedIn') != false) {
      returnController.getReturnReason();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    returnController.selectedReason.clear();
    returnController.selectedReasonId = '';
    returnNote.clear();
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
      child: Obx(
        () => Stack(
          alignment: Alignment.center,
          children: [
            Scaffold(
              backgroundColor: AppColor.primaryBackgroundColor,
              appBar: AppBarWidget3(
                text: 'Request Return'.tr,
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(top: 16.h, left: 16.w, right: 16.w),
                  child: Form(
                    key: formkey,
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: AppColor.whiteColor,
                              borderRadius: BorderRadius.circular(12.r),
                              boxShadow: [
                                BoxShadow(
                                    color:
                                        AppColor.blackColor.withOpacity(0.04),
                                    offset: const Offset(0, 0),
                                    blurRadius: 10.r)
                              ]),
                          child: Padding(
                            padding: EdgeInsets.only(top: 12.h, bottom: 12.h),
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: 12.w, right: 12.w),
                                  child: Row(
                                    children: [
                                      TextWidget(
                                        text: 'Order ID: '.tr,
                                        color: AppColor.textColor,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      TextWidget(
                                        text: '#${widget.order!.orderSerialNo}',
                                        color: AppColor.textColor,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 12.h,
                                ),
                                const DeviderWidget(),
                                ListView.builder(
                                  itemCount:
                                      widget.order!.orderProducts!.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return OrderWidget3(
                                      product:
                                          widget.order!.orderProducts![index],
                                      index: index,
                                    );
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: AppColor.whiteColor,
                              borderRadius: BorderRadius.circular(12.r),
                              boxShadow: [
                                BoxShadow(
                                    color:
                                        AppColor.blackColor.withOpacity(0.04),
                                    offset: const Offset(0, 0),
                                    blurRadius: 10.r)
                              ]),
                          child: Padding(
                            padding: EdgeInsets.all(16.r),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextWidget(
                                    text: 'Return Reason'.tr,
                                    color: AppColor.textColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  SizedBox(
                                    height: 4.h,
                                  ),
                                  Obx(
                                    () => returnController
                                            .returnReasonMap.isNotEmpty
                                        ? PopupMenuButton(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10.r),
                                              ),
                                            ),
                                            position: PopupMenuPosition.under,
                                            itemBuilder: (ctx) => List.generate(
                                                returnController
                                                    .returnReasonModel!
                                                    .data!
                                                    .length,
                                                (index) => PopupMenuItem(
                                                      height: 32.h,
                                                      onTap: () async {
                                                        setState(() {
                                                          returnController
                                                                  .selectedReason
                                                                  .text =
                                                              returnController
                                                                  .returnReasonModel!
                                                                  .data![index]
                                                                  .title
                                                                  .toString();
                                                          returnController
                                                                  .selectedReasonId =
                                                              returnController
                                                                  .returnReasonModel!
                                                                  .data![index]
                                                                  .id
                                                                  .toString();
                                                        });
                                                      },
                                                      child: Padding(
                                                        padding: EdgeInsets.only(bottom: 10.h),
                                                        child: Text(
                                                          returnController
                                                              .returnReasonModel!
                                                              .data![index]
                                                              .title
                                                              .toString(),
                                                          style: GoogleFonts
                                                              .urbanist(
                                                                  color: AppColor
                                                                      .textColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize:
                                                                      16.sp),
                                                        ),
                                                      ),
                                                    )),
                                            child: Stack(
                                              children: [
                                                Container(
                                                  height: 48.h,
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.r),
                                                      border: Border.all(
                                                          color: AppColor
                                                              .borderColor,
                                                          width: 1.r)),
                                                  child: TextFormField(
                                                    style: GoogleFonts.urbanist(
                                                        color:
                                                            AppColor.textColor,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 16.sp),
                                                    controller: returnController
                                                        .selectedReason,
                                                    enabled: false,
                                                    validator: (value) {
                                                      if (value!.isEmpty)
                                                        return "Please select return reason"
                                                            .tr;
                                                      else if (value == '')
                                                        return "Please select return reason"
                                                            .tr;
                                                      else return null;
                                                    },
                                                    decoration: InputDecoration(
                                                        filled: true,
                                                        suffix: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  right: 20.w),
                                                        ),
                                                        contentPadding:
                                                            EdgeInsets.symmetric(
                                                                horizontal:
                                                                    10.h),
                                                        fillColor:
                                                            AppColor.whiteColor,
                                                        focusedBorder: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    8.r),
                                                            borderSide: const BorderSide(
                                                                color: Colors
                                                                    .transparent,
                                                                width: 0)),
                                                        errorBorder: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    8.r),
                                                            borderSide: const BorderSide(
                                                                color: Colors
                                                                    .transparent,
                                                                width: 0)),
                                                        enabledBorder: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius.circular(8.r),
                                                            borderSide: const BorderSide(color: Colors.transparent, width: 0)),
                                                        disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r), borderSide: const BorderSide(color: Colors.transparent, width: 0)),
                                                        focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r), borderSide: const BorderSide(color: Colors.transparent, width: 0)),
                                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r), borderSide: const BorderSide(color: Colors.transparent, width: 0))),
                                                  ),
                                                ),
                                                Positioned(
                                                  bottom: 14.h,
                                                  top: 14.h,
                                                  right: 14.h,
                                                  child: SvgPicture.asset(
                                                    SvgIcon.down,
                                                    height: 20.h,
                                                    width: 20.w,
                                                  ),
                                                )
                                              ],
                                            ))
                                        : Stack(
                                            children: [
                                              Container(
                                                height: 48.h,
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.r),
                                                    border: Border.all(
                                                        color: AppColor
                                                            .borderColor,
                                                        width: 1.r)),
                                                child: TextFormField(
                                                  controller: reason,
                                                  enabled: false,
                                                  validator: (value) {
                                                    if (value!.isEmpty)
                                                      return "Please write review details"
                                                          .tr;
                                                    else return null;
                                                  },
                                                  decoration: InputDecoration(
                                                    filled: true,
                                                    suffix: Padding(
                                                      padding: EdgeInsets.only(
                                                          right: 20.w),
                                                    ),
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10.h),
                                                    fillColor:
                                                        AppColor.whiteColor,
                                                    focusedBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.r),
                                                        borderSide:
                                                            const BorderSide(
                                                                color: Colors
                                                                    .transparent,
                                                                width: 0)),
                                                    errorBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.r),
                                                        borderSide:
                                                            const BorderSide(
                                                                color: Colors
                                                                    .transparent,
                                                                width: 0)),
                                                    enabledBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.r),
                                                        borderSide:
                                                            const BorderSide(
                                                                color: Colors
                                                                    .transparent,
                                                                width: 0)),
                                                    disabledBorder:
                                                        OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.r),
                                                            borderSide:
                                                                const BorderSide(
                                                                    color: Colors
                                                                        .transparent,
                                                                    width: 0)),
                                                    focusedErrorBorder:
                                                        OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(8
                                                                        .r),
                                                            borderSide:
                                                                const BorderSide(
                                                                    color: Colors
                                                                        .transparent,
                                                                    width: 0)),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.r),
                                                      borderSide:
                                                          const BorderSide(
                                                              color: Colors
                                                                  .transparent,
                                                              width: 0),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                bottom: 14.h,
                                                top: 14.h,
                                                right: 14.h,
                                                child: SvgPicture.asset(
                                                  SvgIcon.down,
                                                  height: 20.h,
                                                  width: 20.w,
                                                ),
                                              )
                                            ],
                                          ),
                                  ),
                                  SizedBox(
                                    height: 16.h,
                                  ),
                                  TextWidget(
                                    text: 'Return Note'.tr,
                                    color: AppColor.textColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  SizedBox(
                                    height: 4.h,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        border: Border.all(
                                            color: AppColor.borderColor,
                                            width: 1.r)),
                                    child: TextFormField(
                                      controller: returnNote,
                                      maxLines: 8,
                                      validator: (value) {
                                        if (value!.isEmpty)
                                          return "Please write return note".tr;
                                        else return null;
                                      },
                                      decoration: InputDecoration(
                                          counter: const Offstage(),
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 10.h, vertical: 10.h),
                                          fillColor: AppColor.whiteColor,
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                              borderSide: const BorderSide(
                                                  color: Colors.transparent,
                                                  width: 0)),
                                          errorBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                              borderSide: const BorderSide(
                                                  color: Colors.transparent,
                                                  width: 0)),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                              borderSide: const BorderSide(
                                                  color: Colors.transparent,
                                                  width: 0)),
                                          disabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                              borderSide: const BorderSide(
                                                  color: Colors.transparent,
                                                  width: 0)),
                                          focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r), borderSide: const BorderSide(color: Colors.transparent, width: 0)),
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r), borderSide: const BorderSide(color: Colors.transparent, width: 0))),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16.h,
                                  ),
                                  TextWidget(
                                    text: 'Attachment'.tr,
                                    color: AppColor.textColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  SizedBox(
                                    height: 4.h,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      selectedImages.clear();
                                      pickImage();
                                    },
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: 48.h,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                              border: Border.all(
                                                  color: AppColor.borderColor,
                                                  width: 1.r)),
                                          child: TextFormField(
                                            controller: imagePathController,
                                            enabled: false,
                                            decoration: InputDecoration(
                                              filled: true,
                                              suffix: Padding(
                                                padding: EdgeInsets.only(
                                                    right: 20.w),
                                              ),
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 10.h),
                                              fillColor: AppColor.whiteColor,
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.r),
                                                  borderSide: const BorderSide(
                                                      color: Colors.transparent,
                                                      width: 0)),
                                              errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.r),
                                                  borderSide: const BorderSide(
                                                      color: Colors.transparent,
                                                      width: 0)),
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.r),
                                                  borderSide: const BorderSide(
                                                      color: Colors.transparent,
                                                      width: 0)),
                                              disabledBorder:
                                                  OutlineInputBorder(
                                                      borderRadius: BorderRadius
                                                          .circular(8.r),
                                                      borderSide:
                                                          const BorderSide(
                                                              color: Colors
                                                                  .transparent,
                                                              width: 0)),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.r),
                                                      borderSide:
                                                          const BorderSide(
                                                              color: Colors
                                                                  .transparent,
                                                              width: 0)),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.r),
                                                borderSide: const BorderSide(
                                                    color: Colors.transparent,
                                                    width: 0),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          right: 0,
                                          top: 0,
                                          bottom: 0,
                                          child: Container(
                                            height: 48.h,
                                            width: 52.w,
                                            decoration: BoxDecoration(
                                                color: AppColor.borderColor,
                                                borderRadius:
                                                    BorderRadius.circular(8.r)),
                                            child: Center(
                                              child: SvgPicture.asset(
                                                SvgIcon.gallery,
                                                height: 20.h,
                                                width: 20.h,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 24.h,
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      if (formkey.currentState!.validate()) {
                                        if (returnController
                                            .returnItems.isNotEmpty) {
                                          if (returnController.selectedReason
                                                  .toString() !=
                                              '') {
                                            var jsonFile = returnController
                                                .returnItems
                                                .map((e) {
                                              return {
                                                "product_id": e.id.toInt(),
                                                "quantity": e.quantity.toInt(),
                                                "price": e.price.toDouble(),
                                                "total": e.total.toDouble(),
                                                "tax": e.tax.toDouble(),
                                                "order_quantity":
                                                    e.order_quantity.toInt(),
                                                "return_price":
                                                    e.price.toDouble() *
                                                        e.quantity.toInt(),
                                                "has_variation":
                                                    e.has_variation,
                                                "variation_id": e
                                                            .has_variation ==
                                                        false
                                                    ? ''
                                                    : int.parse(e.variation_id),
                                                "variation_names":
                                                    e.has_variation == false
                                                        ? ''
                                                        : e.variation_names
                                                            .toString(),
                                              };
                                            }).toList();

                                            var data = jsonEncode(jsonFile);

                                            await returnController
                                                .returnRequest(
                                                    order_id: widget.order!.id
                                                        .toString(),
                                                    order_serial_no: widget
                                                        .order!.orderSerialNo
                                                        .toString(),
                                                    return_reason_id:
                                                        returnController
                                                            .selectedReasonId,
                                                    images: selectedImages,
                                                    note: returnNote.text,
                                                    jsonFile: data.toString());
                                          } else {
                                            customSnackbar(
                                                "ERROR".tr,
                                                'Please select return reason'
                                                    .tr
                                                    .toString(),
                                                AppColor.error);
                                          }
                                        } else {
                                          customSnackbar(
                                              "ERROR".tr,
                                              'Please select an item'.toString().tr,
                                              AppColor.error);
                                        }
                                      }
                                    },
                                    child: Container(
                                      height: 48.h,
                                      width: 157.w,
                                      decoration: BoxDecoration(
                                          color: AppColor.primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(24.r)),
                                      child: Center(
                                        child: TextWidget(
                                          text: 'Request Return'.tr,
                                          color: AppColor.whiteColor,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            returnController.isLoading.value ? LoaderCircle() : SizedBox()
          ],
        ),
      ),
    );
  }
}
