import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shopperz/app/modules/product_details/controller/product_details_controller.dart';
import 'package:shopperz/app/modules/product_details/model/related_product.dart';
import 'package:shopperz/app/modules/wishlist/model/fav_model.dart';
import 'package:shopperz/config/theme/app_color.dart';
import 'package:shopperz/utils/svg_icon.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:shopperz/app/modules/category/model/category_wise_product.dart'
    as category_product;
import 'package:shopperz/app/modules/home/model/product_section.dart'
    as section_product;
import '../app/modules/search/model/all_product.dart';
import 'custom_text.dart';

class CustomTabBar extends StatefulWidget {
  const CustomTabBar({
    super.key,
    this.productModel,
    this.sectionModel,
    this.categoryWiseProduct,
    this.allProductModel,
    this.favoriteItem,
    this.relatedProduct,
  });
  final category_product.Product? categoryWiseProduct;
  final section_product.Product? productModel;
  final section_product.Datum? sectionModel;
  final Datum? allProductModel;
  final FavoriteItem? favoriteItem;
  final RelatedProduct? relatedProduct;

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
  }

  final itemList = [
    "DETAILS".tr,
    "VIDEOS".tr,
    "REVIEW".tr,
    "SHIPPING_AND_RETURN".tr
  ];
  int currentIndex = 0;

  late final itemView = [
    const DetailsView(),
    const VideosView(),
    ReviewView(
      allProductModel: widget.allProductModel,
      categoryWiseProduct: widget.categoryWiseProduct,
      favoriteItem: widget.favoriteItem,
      productModel: widget.productModel,
      relatedProduct: widget.relatedProduct,
      sectionModel: widget.sectionModel,
    ),
    const ShippingReturnView()
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          SizedBox(
            height: 36.h,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: itemList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 10.w),
                      height: 36.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24.r),
                        border: Border.all(color: AppColor.grayColor),
                        color: currentIndex == index
                            ? AppColor.textColor
                            : Colors.white,
                      ),
                      child: Center(
                          child: Padding(
                        padding: EdgeInsets.only(
                            left: 16.w, right: 16.w, top: 8.h, bottom: 8.h),
                        child: CustomText(
                          text: itemList[index].tr,
                          color: currentIndex == index
                              ? Colors.white
                              : Colors.black,
                        ),
                      )),
                    ),
                  );
                }),
          ),
          SizedBox(height: 20.h),
          itemView[currentIndex],
        ],
      ),
    );
  }
}

class DetailsView extends StatelessWidget {
  const DetailsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final productDetailsController = Get.put(ProductDetailsController());
    return Container(
      width: 328.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColor.grayColor),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
                text: "Product Details".tr,
                size: 22.sp,
                weight: FontWeight.w700),
            productDetailsController.productModel.value.data?.details == '' ||
                    productDetailsController.productModel.value.data?.details ==
                        null
                ? SizedBox()
                : Html(
                    data: productDetailsController
                        .productModel.value.data?.details,
                    style: {
                      "p.fancy": Style(
                        fontFamily: 'urbanist',
                        textAlign: TextAlign.center,
                        backgroundColor: AppColor.textColor,
                        fontWeight: FontWeight.normal,
                      ),
                    },
                  ),
          ],
        ),
      ),
    );
  }
}

class VideosView extends StatefulWidget {
  const VideosView({
    super.key,
  });

  @override
  State<VideosView> createState() => _VideosViewState();
}

class _VideosViewState extends State<VideosView> {
  final productDetailsController = Get.put(ProductDetailsController());
  WebViewController controllerWeb = WebViewController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 328.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColor.grayColor),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
                text: "Product Videos".tr,
                size: 22.sp,
                weight: FontWeight.w700),
            SizedBox(
              height: 16.h,
            ),
            productDetailsController.productModel.value.data!.videos!.isEmpty ||
                    productDetailsController.productModel.value.data?.videos ==
                        null
                ? SizedBox()
                : ListView.builder(
                    itemCount: productDetailsController
                        .productModel.value.data!.videos!.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      controllerWeb = WebViewController()
                        ..setJavaScriptMode(JavaScriptMode.unrestricted)
                        ..loadRequest(Uri.parse(productDetailsController
                            .productModel.value.data!.videos![index].link
                            .toString()));
                      return Padding(
                          padding: EdgeInsets.only(bottom: 16.h),
                          child: Container(
                            height: 165.h,
                            width: double.infinity,
                            decoration:
                                BoxDecoration(color: AppColor.whiteColor),
                            child: WebViewWidget(
                              controller: controllerWeb,
                            ),
                          ));
                    },
                  )
          ],
        ),
      ),
    );
  }
}

class ReviewView extends StatefulWidget {
  ReviewView({
    super.key,
    this.productModel,
    this.sectionModel,
    this.categoryWiseProduct,
    this.allProductModel,
    this.favoriteItem,
    this.relatedProduct,
  });
  final category_product.Product? categoryWiseProduct;
  final section_product.Product? productModel;
  final section_product.Datum? sectionModel;
  final Datum? allProductModel;
  final FavoriteItem? favoriteItem;
  final RelatedProduct? relatedProduct;

  @override
  State<ReviewView> createState() => _ReviewViewState();
}

class _ReviewViewState extends State<ReviewView> {
  @override
  Widget build(BuildContext context) {
    final productDetailsController = Get.put(ProductDetailsController());
    return Obx(
      () => productDetailsController.productModel.value.data != null
          ? Container(
              width: 328.w,
              decoration: BoxDecoration(
                color: AppColor.whiteColor,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: AppColor.grayColor),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                        text: "Product Reviews".tr,
                        size: 22.sp,
                        weight: FontWeight.w700),
                    SizedBox(
                      height: 16.h,
                    ),
                    Row(
                      children: [
                        RatingBarIndicator(
                          rating: double.parse(
                              '${productDetailsController.productModel.value.data!.ratingStar.toString() == 'null' ? '0' : double.parse(productDetailsController.productModel.value.data!.ratingStar.toString()) / productDetailsController.productModel.value.data!.ratingStarCount!.toInt()}'),
                          itemSize: 10.h,
                          itemBuilder: (context, index) => Container(
                            margin: EdgeInsets.symmetric(horizontal: 1.w),
                            child: SvgPicture.asset(
                              SvgIcon.star,
                              colorFilter: const ColorFilter.mode(
                                  AppColor.yellowColor, BlendMode.srcIn),
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        SizedBox(
                          child: Row(
                            children: [
                              CustomText(
                                  text:
                                      '${productDetailsController.productModel.value.data!.ratingStar.toString() == 'null' ? '0' : double.parse(productDetailsController.productModel.value.data!.ratingStar.toString()) / productDetailsController.productModel.value.data!.ratingStarCount!.toInt()}'),
                              SizedBox(
                                width: 5.w,
                              ),
                              CustomText(
                                  text:
                                      "(${productDetailsController.productModel.value.data!.ratingStarCount} ${' Reviews'.tr})")
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    productDetailsController
                                .productModel.value.data!.reviews!.isEmpty ||
                            productDetailsController
                                    .productModel.value.data!.reviews ==
                                null
                        ? SizedBox()
                        : ListView.builder(
                            itemCount: productDetailsController
                                .productModel.value.data!.reviews!.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: 16.h),
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: AppColor.whiteColor),
                                    child: Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomText(
                                            text: productDetailsController
                                                .productModel
                                                .value
                                                .data!
                                                .reviews?[index]
                                                .name
                                                .toString(),
                                            size: 18.sp,
                                            weight: FontWeight.w600,
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          RatingBarIndicator(
                                            rating: double.parse(
                                                productDetailsController
                                                        .productModel
                                                        .value
                                                        .data!
                                                        .reviews?[index]
                                                        .star
                                                        .toString() ??
                                                    "0"),
                                            itemSize: 10.h,
                                            itemBuilder: (context, index) =>
                                                Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 1.w),
                                              child: SvgPicture.asset(
                                                SvgIcon.star,
                                                colorFilter:
                                                    const ColorFilter.mode(
                                                        AppColor.yellowColor,
                                                        BlendMode.srcIn),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 16.h,
                                          ),
                                          CustomText(
                                            text: productDetailsController
                                                .productModel
                                                .value
                                                .data!
                                                .reviews?[index]
                                                .review
                                                .toString(),
                                            size: 14.sp,
                                            weight: FontWeight.w400,
                                          ),
                                          productDetailsController
                                                          .productModel
                                                          .value
                                                          .data!
                                                          .reviews![index]
                                                          .images!
                                                          .isEmpty &&
                                                      productDetailsController
                                                              .productModel
                                                              .value
                                                              .data!
                                                              .reviews?[index]
                                                              .images ==
                                                          null ||
                                                  productDetailsController
                                                          .productModel
                                                          .value
                                                          .data!
                                                          .reviews![index]
                                                          .images!
                                                          .length <
                                                      1
                                              ? SizedBox()
                                              : SizedBox(
                                                  height: 16.h,
                                                ),
                                          productDetailsController
                                                          .productModel
                                                          .value
                                                          .data!
                                                          .reviews![index]
                                                          .images!
                                                          .isEmpty &&
                                                      productDetailsController
                                                              .productModel
                                                              .value
                                                              .data!
                                                              .reviews?[index]
                                                              .images ==
                                                          null ||
                                                  productDetailsController
                                                          .productModel
                                                          .value
                                                          .data!
                                                          .reviews![index]
                                                          .images!
                                                          .length <
                                                      1
                                              ? SizedBox()
                                              : SizedBox(
                                                  height: 52.h,
                                                  child: ListView.builder(
                                                    shrinkWrap: true,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemCount:
                                                        productDetailsController
                                                            .productModel
                                                            .value
                                                            .data!
                                                            .reviews?[index]
                                                            .images!
                                                            .length,
                                                    itemBuilder: (context, i) {
                                                      return Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                right: 10.w),
                                                        child: InkWell(
                                                          onTap: () {
                                                            Get.dialog(Dialog(
                                                              child: Image.network(
                                                                  productDetailsController
                                                                      .productModel
                                                                      .value
                                                                      .data!
                                                                      .reviews![
                                                                          index]
                                                                      .images![
                                                                          i]
                                                                      .toString()),
                                                            ));
                                                          },
                                                          child: Container(
                                                            height: 52.h,
                                                            width: 52.w,
                                                            decoration: BoxDecoration(
                                                                color: AppColor
                                                                    .whiteColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(8
                                                                            .r),
                                                                image: DecorationImage(
                                                                    image: NetworkImage(productDetailsController
                                                                        .productModel
                                                                        .value
                                                                        .data!
                                                                        .reviews![
                                                                            index]
                                                                        .images![
                                                                            i]
                                                                        .toString()),
                                                                    fit: BoxFit
                                                                        .cover)),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ))
                                        ],
                                      ),
                                    )),
                              );
                            },
                          ),
                    productDetailsController
                                .productModel.value.data!.reviews!.length <
                            productDetailsController
                                .productModel.value.data!.ratingStarCount!
                                .toInt()
                        ? SizedBox(
                            height: 10.h,
                          )
                        : SizedBox(),
                    productDetailsController
                                .productModel.value.data!.reviews!.length <
                            productDetailsController
                                .productModel.value.data!.ratingStarCount!
                                .toInt()
                        ? Center(
                            child: InkWell(
                                onTap: () {
                                  print('tapped');
                                  setState(() {
                                    productDetailsController
                                        .reviewLimit.value++;
                                    productDetailsController
                                        .fetchProductDetails(
                                            slug: widget.productModel?.slug ??
                                                widget.categoryWiseProduct
                                                    ?.slug ??
                                                widget.allProductModel?.slug ??
                                                widget.favoriteItem?.slug ??
                                                widget.relatedProduct?.slug ??
                                                "");
                                  });
                                },
                                child: CustomText(
                                  text: 'Read More',
                                  color: AppColor.primaryColor,
                                  size: 16.sp,
                                  weight: FontWeight.w500,
                                )))
                        : SizedBox()
                  ],
                ),
              ),
            )
          : SizedBox(),
    );
  }
}

class ShippingReturnView extends StatelessWidget {
  const ShippingReturnView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final productDetailsController = Get.put(ProductDetailsController());
    return Container(
      width: 328.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColor.grayColor),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
                text: "Shipping & Return".tr,
                size: 22.sp,
                weight: FontWeight.w700),
            productDetailsController
                            .productModel.value.data?.shippingAndReturn ==
                        '' ||
                    productDetailsController
                            .productModel.value.data?.shippingAndReturn ==
                        null
                ? SizedBox()
                : Html(
                    data: productDetailsController
                        .productModel.value.data?.shippingAndReturn,
                    style: {
                      "p.fancy": Style(
                        textAlign: TextAlign.center,
                        backgroundColor: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
