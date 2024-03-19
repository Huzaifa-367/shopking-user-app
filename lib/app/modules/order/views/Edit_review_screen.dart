import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopperz/app/modules/order/controller/review_controller.dart';
import 'package:shopperz/app/modules/profile/widgets/image_size_chekcer.dart';
import 'package:shopperz/data/model/order_details_model.dart';
import 'package:shopperz/utils/svg_icon.dart';
import 'package:shopperz/widgets/appbar3.dart';
import 'package:shopperz/widgets/custom_snackbar.dart';
import 'package:shopperz/widgets/devider.dart';
import 'package:shopperz/widgets/loader/loader.dart';
import 'package:shopperz/widgets/textwidget.dart';
import '../../../../config/theme/app_color.dart';

class EditReviewScreen extends StatefulWidget {
  const EditReviewScreen({super.key, required this.product});
  final OrderProducts? product;

  @override
  State<EditReviewScreen> createState() => _EditReviewScreenState();
}

class _EditReviewScreenState extends State<EditReviewScreen> {
  ReviewController review = Get.put(ReviewController());

  @override
  void initState() {
    super.initState();
    review.getReviewDetails(
        review_id: widget.product!.productUserReviewId.toString());
  }

  List<File?> images = [];

  File? selectedImage1;
  File? selectedImage2;
  File? selectedImage3;
  File? selectedImage4;
  File? selectedImage5;

  int? ratingStar;

  Future pickImage1() async {
    File image;
    final picker = ImagePicker();

    var pickedFile = await picker.pickImage(source: ImageSource.gallery);

    double imageSize = await ImageSize.getImageSize(pickedFile!);
    if (imageSize > 2) {
      customSnackbar(
          "ERROR".tr, "IMAGE_SHOULD_BE_LESS_THAN_2MB".tr, AppColor.error);
    } else {
      image = File(pickedFile.path);
      setState(() {});
      selectedImage1 = image;
      images.add(selectedImage1);
    }
  }

  Future pickImage2() async {
    File image;
    final picker = ImagePicker();

    var pickedFile = await picker.pickImage(source: ImageSource.gallery);

    double imageSize = await ImageSize.getImageSize(pickedFile!);
    if (imageSize > 2) {
      customSnackbar(
          "ERROR".tr, "IMAGE_SHOULD_BE_LESS_THAN_2MB".tr, AppColor.error);
    } else {
      image = File(pickedFile.path);
      setState(() {});
      selectedImage2 = image;
      images.add(selectedImage2);
    }
  }

  Future pickImage3() async {
    File image;
    final picker = ImagePicker();

    var pickedFile = await picker.pickImage(source: ImageSource.gallery);

    double imageSize = await ImageSize.getImageSize(pickedFile!);
    if (imageSize > 2) {
      customSnackbar(
          "ERROR".tr, "IMAGE_SHOULD_BE_LESS_THAN_2MB".tr, AppColor.error);
    } else {
      image = File(pickedFile.path);
      setState(() {});
      selectedImage3 = image;
      images.add(selectedImage3);
    }
  }

  Future pickImage4() async {
    File image;
    final picker = ImagePicker();

    var pickedFile = await picker.pickImage(source: ImageSource.gallery);

    double imageSize = await ImageSize.getImageSize(pickedFile!);
    if (imageSize > 2) {
      customSnackbar(
          "ERROR".tr, "IMAGE_SHOULD_BE_LESS_THAN_2MB".tr, AppColor.error);
    } else {
      image = File(pickedFile.path);
      setState(() {});
      selectedImage4 = image;
      images.add(selectedImage4);
    }
  }

  Future pickImage5() async {
    File image;
    final picker = ImagePicker();

    var pickedFile = await picker.pickImage(source: ImageSource.gallery);

    double imageSize = await ImageSize.getImageSize(pickedFile!);
    if (imageSize > 2) {
      customSnackbar(
          "ERROR".tr, "IMAGE_SHOULD_BE_LESS_THAN_2MB".tr, AppColor.error);
    } else {
      image = File(pickedFile.path);
      setState(() {});
      selectedImage5 = image;
      images.add(selectedImage5);
    }
  }

  final formkey = GlobalKey<FormState>();

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
      child: Obx(
        () => Stack(
          alignment: Alignment.center,
          children: [
            Scaffold(
              backgroundColor: AppColor.primaryBackgroundColor,
              appBar: AppBarWidget3(
                text: 'Edit Review'.tr,
              ),
              body: review.reviewDetailsMap.isNotEmpty
                  ? SingleChildScrollView(
                      child: Padding(
                        padding:
                            EdgeInsets.only(top: 16.h, left: 16.w, right: 16.w),
                        child: Column(
                          children: [
                            Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: AppColor.whiteColor,
                                    borderRadius: BorderRadius.circular(12.r),
                                    boxShadow: [
                                      BoxShadow(
                                          color: AppColor.blackColor
                                              .withOpacity(0.04),
                                          offset: const Offset(0, 0),
                                          blurRadius: 10.r)
                                    ]),
                                child: Padding(
                                    padding:
                                        EdgeInsets.only(top: 16.h, bottom: 16.h),
                                    child: Form(
                                      key: formkey,
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 16.w, right: 16.w),
                                              child: Container(
                                                height: 62.h,
                                                width: double.infinity,
                                                color: AppColor.whiteColor,
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      height: 62.h,
                                                      width: 52.w,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                4.r),
                                                        image: DecorationImage(
                                                            image: NetworkImage(
                                                                widget.product!
                                                                    .productImage
                                                                    .toString()),
                                                            fit: BoxFit.cover),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 12.w,
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          TextWidget(
                                                            text: widget.product!
                                                                .productName,
                                                            color: AppColor
                                                                .textColor,
                                                            fontSize: 12.sp,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            maxLines: 1,
                                                            overflow: TextOverflow
                                                                .ellipsis,
                                                          ),
                                                          TextWidget(
                                                            text: widget.product!
                                                                .variationNames,
                                                            color: AppColor
                                                                .textColor,
                                                            fontSize: 12.sp,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                          TextWidget(
                                                            text: widget.product!
                                                                .currencyPrice,
                                                            color: AppColor
                                                                .textColor,
                                                            fontSize: 12.sp,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 16.h,
                                            ),
                                            const DeviderWidget(),
                                            SizedBox(
                                              height: 16.h,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 16.w, right: 16.w),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  TextWidget(
                                                    text: 'Your Review'.tr,
                                                    color: AppColor.textColor,
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  SizedBox(
                                                    height: 12.h,
                                                  ),
                                                  RatingBar.builder(
                                                    initialRating: 
                                                        review.star!.toDouble(), 
                                                    minRating: 1,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: false,
                                                    itemCount: 5,
                                                    itemSize: 32.sp,
                                                    unratedColor:
                                                        AppColor.inactiveColor,
                                                    itemPadding: EdgeInsets.only(
                                                        right: 5.w),
                                                    itemBuilder: (context, _) =>
                                                        SvgPicture.asset(
                                                      SvgIcon.starRating,
                                                      color: AppColor.starColor,
                                                    ),
                                                    onRatingUpdate: (rating) {
                                                      review.star =
                                                          rating.toInt();
                                                    },
                                                  ),
                                                  SizedBox(
                                                    height: 16.h,
                                                  ),
                                                  TextWidget(
                                                    text: 'Review Details'.tr,
                                                    color: AppColor.textColor,
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  SizedBox(
                                                    height: 8.h,
                                                  ),
                                                  Container(
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
                                                      controller:
                                                          review.reviewText,
                                                      validator: (value) {
                                                        if (value!.isEmpty) {
                                                          return "Please write review details".tr;
                                                        }
                                                        return null;
                                                      },
                                                      maxLines: 6,
                                                      decoration: InputDecoration(
                                                          counter:
                                                              const Offstage(),
                                                          contentPadding:
                                                              EdgeInsets.symmetric(
                                                                  horizontal:
                                                                      10.h,
                                                                  vertical: 10.h),
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
                                                              borderSide:
                                                                  const BorderSide(
                                                                      color: Colors.transparent,
                                                                      width: 0)),
                                                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r), borderSide: const BorderSide(color: Colors.transparent, width: 0)),
                                                          disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r), borderSide: const BorderSide(color: Colors.transparent, width: 0)),
                                                          focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r), borderSide: const BorderSide(color: Colors.transparent, width: 0)),
                                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r), borderSide: const BorderSide(color: Colors.transparent, width: 0))),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 16.h,
                                                  ),
                                                  TextWidget(
                                                    text: 'Upload Images'.tr,
                                                    color: AppColor.textColor,
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  SizedBox(
                                                    height: 12.h,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      InkWell(
                                                        onTap: () async {
                                                          pickImage1()
                                                              .then((value) => {
                                                                    if (selectedImage1 !=
                                                                        null)
                                                                      {
                                                                        review.updateImage(
                                                                            selectedImage1,
                                                                            widget
                                                                                .product!
                                                                                .productUserReviewId
                                                                                .toString())
                                                                      }
                                                                  });
                                                        },
                                                        child: Stack(
                                                          children: [
                                                            Container(
                                                              height: 88.h,
                                                              width: 88.w,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: AppColor
                                                                    .borderColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.r),
                                                              ),
                                                              child: selectedImage1 ==
                                                                          null &&
                                                                      review.image1 ==
                                                                          ''
                                                                  ? Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        SvgPicture
                                                                            .asset(
                                                                          SvgIcon
                                                                              .gallery,
                                                                          colorFilter: const ColorFilter
                                                                              .mode(
                                                                              AppColor.deSelectedColor,
                                                                              BlendMode.srcIn),
                                                                          height:
                                                                              24.h,
                                                                          width:
                                                                              24.w,
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              6.h,
                                                                        ),
                                                                        TextWidget(
                                                                          text:
                                                                              'Add Image'.tr,
                                                                          color: AppColor
                                                                              .textColor1,
                                                                          fontSize:
                                                                              12.sp,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        )
                                                                      ],
                                                                    )
                                                                  : ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(8
                                                                              .r),
                                                                      child: selectedImage1 !=
                                                                              null
                                                                          ? Image
                                                                              .file(
                                                                              File(selectedImage1!.path),
                                                                              fit:
                                                                                  BoxFit.cover,
                                                                            )
                                                                          : Image
                                                                              .network(
                                                                              review.image1,
                                                                              fit:
                                                                                  BoxFit.cover,
                                                                            )),
                                                            ),
                                                            selectedImage1 ==
                                                                        null &&
                                                                    review.image1 ==
                                                                        ''
                                                                ? const SizedBox()
                                                                : Positioned(
                                                                    right: 0,
                                                                    child: InkWell(
                                                                        onTap: () {
                                                                          setState(
                                                                              () {
                                                                            selectedImage1 =
                                                                                null;
                                                                          });
                                                                          review.deleteImage(
                                                                              review_id:
                                                                                  widget.product!.productUserReviewId.toString(),
                                                                              index: '0');
                                                                        },
                                                                        child: SvgPicture.asset(SvgIcon.close)),
                                                                  )
                                                          ],
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          pickImage2()
                                                              .then((value) => {
                                                                    if (selectedImage2 !=
                                                                        null)
                                                                      {
                                                                        review.updateImage(
                                                                            selectedImage2,
                                                                            widget
                                                                                .product!
                                                                                .productUserReviewId
                                                                                .toString())
                                                                      }
                                                                  });
                                                        },
                                                        child: Stack(
                                                          children: [
                                                            Container(
                                                              height: 88.h,
                                                              width: 88.w,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: AppColor
                                                                    .borderColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.r),
                                                              ),
                                                              child: selectedImage2 ==
                                                                          null &&
                                                                      review.image2 ==
                                                                          ''
                                                                  ? Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        SvgPicture
                                                                            .asset(
                                                                          SvgIcon
                                                                              .gallery,
                                                                          colorFilter: const ColorFilter
                                                                              .mode(
                                                                              AppColor.deSelectedColor,
                                                                              BlendMode.srcIn),
                                                                          height:
                                                                              24.h,
                                                                          width:
                                                                              24.w,
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              6.h,
                                                                        ),
                                                                        TextWidget(
                                                                          text:
                                                                              'Add Image'.tr,
                                                                          color: AppColor
                                                                              .textColor1,
                                                                          fontSize:
                                                                              12.sp,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        )
                                                                      ],
                                                                    )
                                                                  : ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(8
                                                                              .r),
                                                                      child: selectedImage2 !=
                                                                              null
                                                                          ? Image
                                                                              .file(
                                                                              File(selectedImage2!.path),
                                                                              fit:
                                                                                  BoxFit.cover,
                                                                            )
                                                                          : Image
                                                                              .network(
                                                                              review.image2,
                                                                              fit:
                                                                                  BoxFit.cover,
                                                                            )),
                                                            ),
                                                            selectedImage2 ==
                                                                        null &&
                                                                    review.image2 ==
                                                                        ''
                                                                ? const SizedBox()
                                                                : Positioned(
                                                                    right: 0,
                                                                    child: InkWell(
                                                                        onTap: () {
                                                                          setState(
                                                                              () {
                                                                            selectedImage2 =
                                                                                null;
                                                                          });
                                                                          review.deleteImage(
                                                                              review_id:
                                                                                  widget.product!.productUserReviewId.toString(),
                                                                              index: '1');
                                                                        },
                                                                        child: SvgPicture.asset(SvgIcon.close)),
                                                                  )
                                                          ],
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          pickImage3()
                                                              .then((value) => {
                                                                    if (selectedImage3 !=
                                                                        null)
                                                                      {
                                                                        review.updateImage(
                                                                            selectedImage3,
                                                                            widget
                                                                                .product!
                                                                                .productUserReviewId
                                                                                .toString())
                                                                      }
                                                                  });
                                                        },
                                                        child: Stack(
                                                          children: [
                                                            Container(
                                                              height: 88.h,
                                                              width: 88.w,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: AppColor
                                                                    .borderColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.r),
                                                              ),
                                                              child: selectedImage3 ==
                                                                          null &&
                                                                      review.image3 ==
                                                                          ''
                                                                  ? Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        SvgPicture
                                                                            .asset(
                                                                          SvgIcon
                                                                              .gallery,
                                                                          colorFilter: const ColorFilter
                                                                              .mode(
                                                                              AppColor.deSelectedColor,
                                                                              BlendMode.srcIn),
                                                                          height:
                                                                              24.h,
                                                                          width:
                                                                              24.w,
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              6.h,
                                                                        ),
                                                                        TextWidget(
                                                                          text:
                                                                              'Add Image'.tr,
                                                                          color: AppColor
                                                                              .textColor1,
                                                                          fontSize:
                                                                              12.sp,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        )
                                                                      ],
                                                                    )
                                                                  : ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(8
                                                                              .r),
                                                                      child: selectedImage3 !=
                                                                              null
                                                                          ? Image
                                                                              .file(
                                                                              File(selectedImage3!.path),
                                                                              fit:
                                                                                  BoxFit.cover,
                                                                            )
                                                                          : Image
                                                                              .network(
                                                                              review.image3,
                                                                              fit:
                                                                                  BoxFit.cover,
                                                                            )),
                                                            ),
                                                            selectedImage3 ==
                                                                        null &&
                                                                    review.image3 ==
                                                                        ''
                                                                ? SizedBox()
                                                                : Positioned(
                                                                    right: 0,
                                                                    child: InkWell(
                                                                        onTap: () {
                                                                          setState(
                                                                              () {
                                                                            selectedImage3 =
                                                                                null;
                                                                          });
                                                                          review.deleteImage(
                                                                              review_id:
                                                                                  widget.product!.productUserReviewId.toString(),
                                                                              index: '2');
                                                                        },
                                                                        child: SvgPicture.asset(SvgIcon.close)),
                                                                  )
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 12.h,
                                                  ),
                                                  Row(
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          pickImage4()
                                                              .then((value) => {
                                                                    if (selectedImage4 !=
                                                                        null)
                                                                      {
                                                                        review.updateImage(
                                                                            selectedImage4,
                                                                            widget
                                                                                .product!
                                                                                .productUserReviewId
                                                                                .toString())
                                                                      }
                                                                  });
                                                        },
                                                        child: Stack(
                                                          children: [
                                                            Container(
                                                              height: 88.h,
                                                              width: 88.w,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: AppColor
                                                                    .borderColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.r),
                                                              ),
                                                              child: selectedImage4 ==
                                                                          null &&
                                                                      review.image4 ==
                                                                          ''
                                                                  ? Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        SvgPicture
                                                                            .asset(
                                                                          SvgIcon
                                                                              .gallery,
                                                                          colorFilter: const ColorFilter
                                                                              .mode(
                                                                              AppColor.deSelectedColor,
                                                                              BlendMode.srcIn),
                                                                          height:
                                                                              24.h,
                                                                          width:
                                                                              24.w,
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              6.h,
                                                                        ),
                                                                        TextWidget(
                                                                          text:
                                                                              'Add Image'.tr,
                                                                          color: AppColor
                                                                              .textColor1,
                                                                          fontSize:
                                                                              12.sp,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        )
                                                                      ],
                                                                    )
                                                                  : ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(8
                                                                              .r),
                                                                      child: selectedImage4 !=
                                                                              null
                                                                          ? Image
                                                                              .file(
                                                                              File(selectedImage4!.path),
                                                                              fit:
                                                                                  BoxFit.cover,
                                                                            )
                                                                          : Image
                                                                              .network(
                                                                              review.image4,
                                                                              fit:
                                                                                  BoxFit.cover,
                                                                            )),
                                                            ),
                                                            selectedImage4 ==
                                                                        null &&
                                                                    review.image4 ==
                                                                        ''
                                                                ? const SizedBox()
                                                                : Positioned(
                                                                    right: 0,
                                                                    child: InkWell(
                                                                        onTap: () {
                                                                          setState(
                                                                              () {
                                                                            selectedImage4 =
                                                                                null;
                                                                          });
                                                                          review.deleteImage(
                                                                              review_id:
                                                                                  widget.product!.productUserReviewId.toString(),
                                                                              index: '3');
                                                                        },
                                                                        child: SvgPicture.asset(SvgIcon.close)),
                                                                  )
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 16.w,
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          pickImage5()
                                                              .then((value) => {
                                                                    if (selectedImage5 !=
                                                                        null)
                                                                      {
                                                                        review.updateImage(
                                                                            selectedImage5,
                                                                            widget
                                                                                .product!
                                                                                .productUserReviewId
                                                                                .toString())
                                                                      }
                                                                  });
                                                        },
                                                        child: Stack(
                                                          children: [
                                                            Container(
                                                              height: 88.h,
                                                              width: 88.w,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: AppColor
                                                                    .borderColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.r),
                                                              ),
                                                              child: selectedImage5 ==
                                                                          null &&
                                                                      review.image5 ==
                                                                          ''
                                                                  ? Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        SvgPicture
                                                                            .asset(
                                                                          SvgIcon
                                                                              .gallery,
                                                                          colorFilter: const ColorFilter
                                                                              .mode(
                                                                              AppColor.deSelectedColor,
                                                                              BlendMode.srcIn),
                                                                          height:
                                                                              24.h,
                                                                          width:
                                                                              24.w,
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              6.h,
                                                                        ),
                                                                        TextWidget(
                                                                          text:
                                                                              'Add Image'.tr,
                                                                          color: AppColor
                                                                              .textColor1,
                                                                          fontSize:
                                                                              12.sp,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        )
                                                                      ],
                                                                    )
                                                                  : ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(8
                                                                              .r),
                                                                      child: selectedImage5 !=
                                                                              null
                                                                          ? Image
                                                                              .file(
                                                                              File(selectedImage5!.path),
                                                                              fit:
                                                                                  BoxFit.cover,
                                                                            )
                                                                          : Image
                                                                              .network(
                                                                              review.image5,
                                                                              fit:
                                                                                  BoxFit.cover,
                                                                            )),
                                                            ),
                                                            selectedImage5 ==
                                                                        null &&
                                                                    review.image5 ==
                                                                        ''
                                                                ? SizedBox()
                                                                : Positioned(
                                                                    right: 0,
                                                                    child: InkWell(
                                                                        onTap: () {
                                                                          setState(
                                                                              () {
                                                                            selectedImage5 =
                                                                                null;
                                                                          });
                                                                          review.deleteImage(
                                                                              review_id:
                                                                                  widget.product!.productUserReviewId.toString(),
                                                                              index: '4');
                                                                        },
                                                                        child: SvgPicture.asset(SvgIcon.close)),
                                                                  )
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 24.h,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      if (formkey.currentState!
                                                          .validate()) {
                                                        review.reviewUpdate(
                                                          review_id: widget
                                                              .product!
                                                              .productUserReviewId
                                                              .toString(),
                                                          product_id: widget
                                                              .product!.productId
                                                              .toString(),
                                                          star: review.star
                                                              .toString(),
                                                          review: review
                                                              .reviewText.text,
                                                        );
                                                      }
                                                    },
                                                    child: Container(
                                                      height: 48.h,
                                                      width: 157.w,
                                                      decoration: BoxDecoration(
                                                          color: AppColor
                                                              .primaryColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      24.r)),
                                                      child: Center(
                                                        child: TextWidget(
                                                          text: 'Submit Review'.tr,
                                                          color:
                                                              AppColor.whiteColor,
                                                          fontSize: 16.sp,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ]),
                                    )))
                          ],
                        ),
                      ),
                    )
                  : const Center(child: LoaderCircle()),
            ),
            review.isLoading.value ? const LoaderCircle() : const SizedBox()
          ],
        ),
      ),
    );
  }
}
