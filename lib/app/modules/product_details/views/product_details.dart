import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shopperz/app/modules/auth/controller/auth_controler.dart';
import 'package:shopperz/app/modules/auth/views/sign_in.dart';
import 'package:shopperz/app/modules/cart/controller/cart_controller.dart';
import 'package:shopperz/app/modules/category/controller/category_wise_product_controller.dart';
import 'package:shopperz/app/modules/home/model/product_section.dart';
import 'package:shopperz/app/modules/navbar/controller/navbar_controller.dart';
import 'package:shopperz/app/modules/navbar/views/navbar_view.dart';
import 'package:shopperz/app/modules/product/widgets/product.dart';
import 'package:shopperz/app/modules/product_details/controller/product_details_controller.dart';
import 'package:shopperz/app/modules/product_details/model/Product_model.dart';
import 'package:shopperz/app/modules/wishlist/controller/wishlist_controller.dart';
import 'package:shopperz/main.dart';
import 'package:shopperz/widgets/custom_snackbar.dart';
import 'package:shopperz/widgets/custom_tabbar.dart';
import 'package:shopperz/widgets/devider.dart';
import 'package:shopperz/widgets/secondary_button.dart';
import 'package:shopperz/widgets/shimmer/product_details_shimmer.dart';
import 'package:shopperz/widgets/textwidget.dart';
import '../../../../config/theme/app_color.dart';
import '../../../../utils/svg_icon.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/secondary_appbar.dart';
import '../../search/views/search_screen.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen(
      {super.key,
      this.productModel,
      this.sectionModel,
      this.categoryWiseProduct,
      this.allProductModel,
      this.favoriteItem,
      this.relatedProduct,
      this.product,
      this.individualProduct});
  final Product? categoryWiseProduct;
  final Product? productModel;
  final DatumSection? sectionModel;
  final Product? allProductModel;
  final Product? favoriteItem;
  final Product? relatedProduct;
  final Product? product;
  final Product? individualProduct;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final navController = Get.put(NavbarController());
  final productDetailsController = Get.put(ProductDetailsController());
  final cartController = Get.put(CartController());
  final wishlistController = Get.find<WishlistController>();
  final authController = Get.put(AuthController());
  final categoryWiseProductController =
      Get.put(CategoryWiseProductController());

  int quantity = 1;
  bool isClicked = false;
  int isSelected = 0;

  @override
  void initState() {
    cartController.numOfItems.value = 1;
    productDetailsController.fetchProductDetails(
        slug: widget.productModel?.slug ??
            widget.categoryWiseProduct?.slug ??
            widget.allProductModel?.slug ??
            widget.favoriteItem?.slug ??
            widget.relatedProduct?.slug ??
            widget.individualProduct?.slug ??
            "");

    productDetailsController.fetchRelatedProduct(
        slug: widget.productModel?.slug ??
            widget.categoryWiseProduct?.slug ??
            widget.allProductModel?.slug ??
            widget.favoriteItem?.slug ??
            widget.individualProduct?.slug ??
            "");

    productDetailsController.fetchInitialVariation(
        productId: widget.productModel?.id.toString() ??
            widget.categoryWiseProduct?.id.toString() ??
            widget.allProductModel?.id.toString() ??
            widget.favoriteItem?.id.toString() ??
            widget.individualProduct?.id.toString() ??
            "0");

    authController.getSetting();

    super.initState();
  }

  @override
  void dispose() {
    productDetailsController.resetProductState();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    productDetailsController.fetchProductDetails(
        slug: widget.productModel?.slug ??
            widget.categoryWiseProduct?.slug ??
            widget.allProductModel?.slug ??
            widget.favoriteItem?.slug ??
            widget.relatedProduct?.slug ??
            widget.individualProduct?.slug ??
            "");
    super.didChangeDependencies();
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
      child: GetBuilder<ProductDetailsController>(
        builder: (productDetailsController) {
          Future.delayed(Duration.zero, () {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (productDetailsController.initialVariationModel.value.data !=
                      null &&
                  productDetailsController
                      .initialVariationModel.value.data!.isNotEmpty) {
                productDetailsController.variationProductId.value = '';
                productDetailsController.variationProductPrice.value = '';
                productDetailsController.variationProductCurrencyPrice.value =
                    '';
                productDetailsController.variationProductOldPrice.value = '';
                productDetailsController
                    .variationProductOldCurrencyPrice.value = '';
                productDetailsController.variationsku.value = '';
                productDetailsController.variationsStock.value = -1;
              } else {
                productDetailsController.variationProductId.value =
                    productDetailsController.productModel.value.data?.id
                            .toString() ??
                        '';
                productDetailsController.variationProductPrice.value =
                    productDetailsController.productModel.value.data?.price
                            .toString() ??
                        '';
                productDetailsController.variationProductCurrencyPrice.value =
                    productDetailsController
                            .productModel.value.data?.currencyPrice
                            .toString() ??
                        '';
                productDetailsController.variationProductOldPrice.value =
                    productDetailsController.productModel.value.data?.oldPrice
                            .toString() ??
                        '';
                productDetailsController.variationProductOldCurrencyPrice
                    .value = productDetailsController
                        .productModel.value.data?.oldCurrencyPrice
                        .toString() ??
                    '';
                productDetailsController.variationsku.value =
                    productDetailsController.productModel.value.data?.sku
                            .toString() ??
                        '';
                productDetailsController.variationsStock.value =
                    productDetailsController.productModel.value.data?.stock!
                            .toInt() ??
                        -1;
              }
            });
          });
          return Scaffold(
            backgroundColor: AppColor.whiteColor,
            appBar: SecondaryAppBar(onTap: () {
              Get.to(() => const SearchScreen());
            }),
            floatingActionButton: Obx(
              () => InkWell(
                borderRadius: BorderRadius.circular(56.r),
                onTap: () {
                  Get.to(() => const NavBarView());
                  navController.selectedIndex(2);
                },
                child: Container(
                  height: 56.r,
                  width: 56.r,
                  decoration: BoxDecoration(
                      color: AppColor.primaryColor,
                      borderRadius: BorderRadius.circular(56.r),
                      boxShadow: [
                        BoxShadow(
                            color: AppColor.primaryColor.withOpacity(0.34),
                            blurRadius: 10.r,
                            offset: const Offset(0, 6))
                      ]),
                  child: Stack(
                    children: [
                      SizedBox(
                        height: 60.h,
                        width: 60.w,
                        child: CircleAvatar(
                            backgroundColor: AppColor.primaryColor,
                            child: SvgPicture.asset(
                              SvgIcon.catBag,
                              height: 24.h,
                              width: 24.w,
                              color: AppColor.whiteColor,
                            )),
                      ),
                      cartController.totalItems > 0
                          ? Positioned(
                              top: 12.h,
                              right: 10.w,
                              child: Container(
                                height: 10.r,
                                width: 10.r,
                                decoration: BoxDecoration(
                                    color: AppColor.yellowColor,
                                    borderRadius: BorderRadius.circular(10.r)),
                              ),
                            )
                          : Container()
                    ],
                  ),
                ),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: RefreshIndicator(
                color: AppColor.primaryColor,
                onRefresh: () async {
                  productDetailsController.fetchProductDetails(
                      slug: widget.productModel?.slug ??
                          widget.categoryWiseProduct?.slug ??
                          widget.allProductModel?.slug ??
                          widget.favoriteItem?.slug ??
                          widget.relatedProduct?.slug ??
                          widget.individualProduct?.slug ??
                          "");

                  productDetailsController.fetchRelatedProduct(
                      slug: widget.productModel?.slug ??
                          widget.categoryWiseProduct?.slug ??
                          widget.allProductModel?.slug ??
                          widget.favoriteItem?.slug ??
                          widget.individualProduct?.slug ??
                          "");

                  productDetailsController.fetchInitialVariation(
                      productId: widget.productModel?.id.toString() ??
                          widget.categoryWiseProduct?.id.toString() ??
                          widget.allProductModel?.id.toString() ??
                          widget.favoriteItem?.id.toString() ??
                          widget.individualProduct?.id.toString() ??
                          "0");

                  productDetailsController.variationProductId.value = '';
                  productDetailsController.variationProductPrice.value = '';
                  productDetailsController.variationProductCurrencyPrice.value =
                      '';
                  productDetailsController.variationProductOldPrice.value = '';
                  productDetailsController
                      .variationProductOldCurrencyPrice.value = '';
                  productDetailsController.variationsku.value = '';
                  productDetailsController.variationsStock.value = -1;
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Obx(
                    () => productDetailsController.isLaoding.value == 1
                        ? const ProductDetailsShimmer()
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CachedNetworkImage(
                                imageUrl: isClicked
                                    ? productDetailsController.productModel
                                            .value.data?.images![isSelected] ??
                                        ""
                                    : productDetailsController
                                            .productModel.value.data?.image ??
                                        "",
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  height: 346.h,
                                  width: 328.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16.r),
                                    image: DecorationImage(
                                        image: imageProvider, fit: BoxFit.fill),
                                  ),
                                ),
                                placeholder: (context, imageProvider) =>
                                    Container(
                                  height: 160.h,
                                  width: 140.w,
                                  decoration: BoxDecoration(
                                    color: AppColor.whiteColor,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.07),
                                        offset: const Offset(0, 0),
                                        blurRadius: 7.r,
                                        spreadRadius: 0,
                                      ),
                                    ],
                                    image: const DecorationImage(
                                      image:
                                          AssetImage("assets/images/empty.gif"),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.h),
                              productDetailsController
                                      .productModel.value.data!.images!.isEmpty
                                  ? const SizedBox()
                                  : SizedBox(
                                      height: 80.h,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        itemCount: productDetailsController
                                                .productModel
                                                .value
                                                .data
                                                ?.images
                                                ?.length ??
                                            0,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                isSelected = index;
                                                isClicked = true;
                                              });
                                            },
                                            child: CachedNetworkImage(
                                              imageUrl: productDetailsController
                                                  .productModel
                                                  .value
                                                  .data!
                                                  .images![index],
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      Container(
                                                margin:
                                                    EdgeInsets.only(right: 8.w),
                                                height: 76.h,
                                                width: 76.w,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.r),
                                                  border: Border.all(
                                                      color: isSelected == index
                                                          ? Colors.black
                                                          : Colors.transparent,
                                                      width: 1),
                                                  image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.cover),
                                                ),
                                              ),
                                              placeholder:
                                                  (context, imageProvider) =>
                                                      Container(
                                                height: 76.h,
                                                width: 76.w,
                                                decoration: BoxDecoration(
                                                  color: AppColor.whiteColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.r),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.07),
                                                      offset:
                                                          const Offset(0, 0),
                                                      blurRadius: 7.r,
                                                      spreadRadius: 0,
                                                    ),
                                                  ],
                                                  image: const DecorationImage(
                                                    image: AssetImage(
                                                        "assets/images/empty.gif"),
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                              SizedBox(height: 10.h),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    textAlign: TextAlign.left,
                                    text: productDetailsController
                                        .productModel.value.data!.name,
                                    size: 22.sp,
                                    weight: FontWeight.w700,
                                  ),
                                  SizedBox(height: 2.h),
                                  Row(
                                    children: [
                                      Obx(() {
                                        if (productDetailsController
                                                .initialVariationModel
                                                .value
                                                .data !=
                                            null) {
                                          return CustomText(
                                            text:
                                                productDetailsController
                                                            .variationProductCurrencyPrice
                                                            .toString() ==
                                                        ''
                                                    ? productDetailsController
                                                            .productModel
                                                            .value
                                                            .data
                                                            ?.currencyPrice
                                                            .toString() ??
                                                        ''
                                                    : productDetailsController
                                                        .variationProductCurrencyPrice
                                                        .toString(),
                                            size: 18.sp,
                                            weight: FontWeight.w700,
                                          );
                                        }
                                        return const SizedBox();
                                      }),
                                      SizedBox(width: 16.w),
                                      Obx(() {
                                        if (productDetailsController
                                                    .initialVariationModel
                                                    .value
                                                    .data !=
                                                null &&
                                            productDetailsController
                                                    .productModel
                                                    .value
                                                    .data!
                                                    .isOffer ==
                                                true) {
                                          return CustomText(
                                            text: productDetailsController
                                                        .variationProductOldCurrencyPrice
                                                        .toString() ==
                                                    ''
                                                ? productDetailsController
                                                    .productModel
                                                    .value
                                                    .data
                                                    ?.oldCurrencyPrice
                                                    .toString()
                                                : productDetailsController
                                                    .variationProductOldCurrencyPrice
                                                    .toString(),
                                            textDecoration:
                                                TextDecoration.lineThrough,
                                            color: AppColor.primaryColor,
                                            size: 14.sp,
                                            weight: FontWeight.w700,
                                          );
                                        }

                                        return const SizedBox();
                                      })
                                    ],
                                  ),
                                  SizedBox(height: 2.h),
                                  Row(
                                    children: [
                                      RatingBarIndicator(
                                        rating: double.parse(
                                            '${productDetailsController.productModel.value.data!.ratingStar.toString() == 'null' ? '0' : double.parse(productDetailsController.productModel.value.data!.ratingStar.toString()) / productDetailsController.productModel.value.data!.ratingStarCount!.toInt()}'),
                                        itemSize: 15.h,
                                        unratedColor: AppColor.inactiveColor,
                                        itemBuilder: (context, index) =>
                                            Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 1.w),
                                          child: SvgPicture.asset(
                                            SvgIcon.star,
                                            colorFilter: const ColorFilter.mode(
                                                AppColor.yellowColor,
                                                BlendMode.srcIn),
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
                                  )
                                ],
                              ),
                              SizedBox(height: 7.h),
                              Divider(
                                height: 1.h,
                                color: const Color(0xFFEFF0F6),
                              ),
                              SizedBox(height: 7.h),
                              productDetailsController.initialIndex.value ==
                                          -1 &&
                                      productDetailsController
                                              .initialVariationModel
                                              .value
                                              .data ==
                                          null
                                  ? const SizedBox()
                                  : Column(
                                      children: [
                                        productDetailsController
                                                        .initialVariationModel
                                                        .value
                                                        .data !=
                                                    null &&
                                                productDetailsController
                                                    .initialVariationModel
                                                    .value
                                                    .data!
                                                    .isNotEmpty
                                            ? Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  productDetailsController
                                                                  .initialVariationModel
                                                                  .value
                                                                  .data !=
                                                              null &&
                                                          productDetailsController
                                                              .initialVariationModel
                                                              .value
                                                              .data!
                                                              .isNotEmpty
                                                      ? CustomText(
                                                          text:
                                                              '${productDetailsController.initialVariationModel.value.data?[0].productAttributeName.toString().tr}:',
                                                          size: 14.sp,
                                                          weight:
                                                              FontWeight.w600,
                                                        )
                                                      : const SizedBox(),
                                                  productDetailsController
                                                                  .initialVariationModel
                                                                  .value
                                                                  .data !=
                                                              null &&
                                                          productDetailsController
                                                              .initialVariationModel
                                                              .value
                                                              .data!
                                                              .isNotEmpty
                                                      ? SizedBox(height: 8.h)
                                                      : const SizedBox(),
                                                  productDetailsController
                                                                  .initialVariationModel
                                                                  .value
                                                                  .data !=
                                                              null &&
                                                          productDetailsController
                                                              .initialVariationModel
                                                              .value
                                                              .data!
                                                              .isNotEmpty
                                                      ? SizedBox(
                                                          height: 32.h,
                                                          child:
                                                              ListView.builder(
                                                                  itemCount: productDetailsController
                                                                          .initialVariationModel
                                                                          .value
                                                                          .data
                                                                          ?.length ??
                                                                      0,
                                                                  scrollDirection:
                                                                      Axis
                                                                          .horizontal,
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    return GestureDetector(
                                                                      onTap:
                                                                          () async {
                                                                        cartController
                                                                            .numOfItems
                                                                            .value = 1;

                                                                        productDetailsController
                                                                            .selectedIndex1
                                                                            .value = index;

                                                                        productDetailsController
                                                                            .selectedIndex2
                                                                            .value = -1;
                                                                        productDetailsController
                                                                            .selectedIndex3
                                                                            .value = -1;
                                                                        productDetailsController
                                                                            .selectedIndex4
                                                                            .value = -1;
                                                                        productDetailsController
                                                                            .selectedIndex5
                                                                            .value = -1;
                                                                        productDetailsController
                                                                            .selectedIndex6
                                                                            .value = -1;
                                                                        productDetailsController
                                                                            .selectedIndex7
                                                                            .value = -1;

                                                                        productDetailsController
                                                                            .childrenVariationModel2
                                                                            .value
                                                                            .data
                                                                            ?.clear();
                                                                        productDetailsController
                                                                            .childrenVariationModel3
                                                                            .value
                                                                            .data
                                                                            ?.clear();
                                                                        productDetailsController
                                                                            .childrenVariationModel4
                                                                            .value
                                                                            .data
                                                                            ?.clear();
                                                                        productDetailsController
                                                                            .childrenVariationModel5
                                                                            .value
                                                                            .data
                                                                            ?.clear();
                                                                        productDetailsController
                                                                            .childrenVariationModel6
                                                                            .value
                                                                            .data
                                                                            ?.clear();

                                                                        if (productDetailsController.initialVariationModel.value.data?[index].sku !=
                                                                            null) {
                                                                          productDetailsController
                                                                              .variationProductId
                                                                              .value = productDetailsController.initialVariationModel.value.data?[index].id
                                                                                  .toString() ??
                                                                              '';
                                                                          productDetailsController
                                                                              .variationProductPrice
                                                                              .value = productDetailsController.initialVariationModel.value.data?[index].price
                                                                                  .toString() ??
                                                                              '';
                                                                          productDetailsController
                                                                              .variationProductCurrencyPrice
                                                                              .value = productDetailsController.initialVariationModel.value.data?[index].currencyPrice
                                                                                  .toString() ??
                                                                              '';
                                                                          productDetailsController
                                                                              .variationProductOldPrice
                                                                              .value = productDetailsController.initialVariationModel.value.data?[index].oldPrice
                                                                                  .toString() ??
                                                                              '';
                                                                          productDetailsController
                                                                              .variationProductOldCurrencyPrice
                                                                              .value = productDetailsController.initialVariationModel.value.data?[index].oldCurrencyPrice
                                                                                  .toString() ??
                                                                              '';
                                                                          productDetailsController
                                                                              .variationsku
                                                                              .value = productDetailsController.initialVariationModel.value.data?[index].sku
                                                                                  .toString() ??
                                                                              '';
                                                                          productDetailsController
                                                                              .variationsStock
                                                                              .value = productDetailsController.initialVariationModel.value.data?[index].stock!
                                                                                  .toInt() ??
                                                                              0;
                                                                        } else {
                                                                          productDetailsController
                                                                              .variationProductId
                                                                              .value = '';
                                                                          productDetailsController
                                                                              .variationProductPrice
                                                                              .value = '';
                                                                          productDetailsController
                                                                              .variationProductCurrencyPrice
                                                                              .value = '';
                                                                          productDetailsController
                                                                              .variationProductOldPrice
                                                                              .value = '';
                                                                          productDetailsController
                                                                              .variationProductOldCurrencyPrice
                                                                              .value = '';
                                                                          productDetailsController
                                                                              .variationsku
                                                                              .value = '';
                                                                          productDetailsController
                                                                              .variationsStock
                                                                              .value = -1;
                                                                        }

                                                                        if (productDetailsController.initialVariationModel.value.data?[index].sku ==
                                                                            null) {
                                                                          await productDetailsController.fetchChildrenVariation1(
                                                                              initialVariationId: productDetailsController.initialVariationModel.value.data![index].id.toString());
                                                                        }
                                                                      },
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            EdgeInsets.only(right: 8.w),
                                                                        child:
                                                                            Container(
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color: productDetailsController.selectedIndex1.value == index
                                                                                ? AppColor.primaryColor
                                                                                : AppColor.cartColor,
                                                                            borderRadius:
                                                                                BorderRadius.circular(20.r),
                                                                          ),
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                EdgeInsets.only(left: 12.5.w, right: 12.5.w),
                                                                            child:
                                                                                Center(
                                                                              child: CustomText(
                                                                                text: productDetailsController.initialVariationModel.value.data?[index].productAttributeOptionName ?? '',
                                                                                color: productDetailsController.selectedIndex1.value == index ? Colors.white : Colors.black,
                                                                                size: 12.sp,
                                                                                weight: FontWeight.w500,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }),
                                                        )
                                                      : const SizedBox(),
                                                  productDetailsController
                                                                  .initialVariationModel
                                                                  .value
                                                                  .data !=
                                                              null &&
                                                          productDetailsController
                                                              .initialVariationModel
                                                              .value
                                                              .data!
                                                              .isNotEmpty
                                                      ? SizedBox(height: 8.h)
                                                      : const SizedBox(),
                                                ],
                                              )
                                            : const SizedBox(),
                                        productDetailsController
                                                        .selectedIndex1.value ==
                                                    -1 &&
                                                productDetailsController
                                                        .childrenVariationModel1
                                                        .value
                                                        .data ==
                                                    null
                                            ? const SizedBox()
                                            : Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  productDetailsController
                                                                  .childrenVariationModel1
                                                                  .value
                                                                  .data !=
                                                              null &&
                                                          productDetailsController
                                                              .childrenVariationModel1
                                                              .value
                                                              .data!
                                                              .isNotEmpty
                                                      ? CustomText(
                                                          text:
                                                              '${productDetailsController.childrenVariationModel1.value.data?[0].productAttributeName.toString().tr}:',
                                                          size: 14.sp,
                                                          weight:
                                                              FontWeight.w600,
                                                        )
                                                      : const SizedBox(),
                                                  productDetailsController
                                                                  .childrenVariationModel1
                                                                  .value
                                                                  .data !=
                                                              null &&
                                                          productDetailsController
                                                              .childrenVariationModel1
                                                              .value
                                                              .data!
                                                              .isNotEmpty
                                                      ? SizedBox(height: 8.h)
                                                      : const SizedBox(),
                                                  productDetailsController
                                                                  .childrenVariationModel1
                                                                  .value
                                                                  .data !=
                                                              null &&
                                                          productDetailsController
                                                              .childrenVariationModel1
                                                              .value
                                                              .data!
                                                              .isNotEmpty
                                                      ? SizedBox(
                                                          height: 32.h,
                                                          child:
                                                              ListView.builder(
                                                                  itemCount: productDetailsController
                                                                          .childrenVariationModel1
                                                                          .value
                                                                          .data
                                                                          ?.length ??
                                                                      0,
                                                                  scrollDirection:
                                                                      Axis
                                                                          .horizontal,
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    return GestureDetector(
                                                                      onTap:
                                                                          () async {
                                                                        cartController
                                                                            .numOfItems
                                                                            .value = 1;
                                                                        productDetailsController
                                                                            .selectedIndex2
                                                                            .value = index;

                                                                        productDetailsController
                                                                            .selectedIndex3
                                                                            .value = -1;
                                                                        productDetailsController
                                                                            .selectedIndex4
                                                                            .value = -1;
                                                                        productDetailsController
                                                                            .selectedIndex5
                                                                            .value = -1;
                                                                        productDetailsController
                                                                            .selectedIndex6
                                                                            .value = -1;
                                                                        productDetailsController
                                                                            .selectedIndex7
                                                                            .value = -1;

                                                                        productDetailsController
                                                                            .childrenVariationModel2
                                                                            .value
                                                                            .data
                                                                            ?.clear();
                                                                        productDetailsController
                                                                            .childrenVariationModel3
                                                                            .value
                                                                            .data
                                                                            ?.clear();
                                                                        productDetailsController
                                                                            .childrenVariationModel4
                                                                            .value
                                                                            .data
                                                                            ?.clear();
                                                                        productDetailsController
                                                                            .childrenVariationModel5
                                                                            .value
                                                                            .data
                                                                            ?.clear();
                                                                        productDetailsController
                                                                            .childrenVariationModel6
                                                                            .value
                                                                            .data
                                                                            ?.clear();

                                                                        if (productDetailsController.childrenVariationModel1.value.data?[index].sku !=
                                                                            null) {
                                                                          productDetailsController
                                                                              .variationProductId
                                                                              .value = productDetailsController.childrenVariationModel1.value.data?[index].id
                                                                                  .toString() ??
                                                                              '';
                                                                          productDetailsController
                                                                              .variationProductPrice
                                                                              .value = productDetailsController.childrenVariationModel1.value.data?[index].price
                                                                                  .toString() ??
                                                                              '';
                                                                          productDetailsController
                                                                              .variationProductCurrencyPrice
                                                                              .value = productDetailsController.childrenVariationModel1.value.data?[index].currencyPrice
                                                                                  .toString() ??
                                                                              '';
                                                                          productDetailsController
                                                                              .variationProductOldPrice
                                                                              .value = productDetailsController.childrenVariationModel1.value.data?[index].oldPrice
                                                                                  .toString() ??
                                                                              '';
                                                                          productDetailsController
                                                                              .variationProductOldCurrencyPrice
                                                                              .value = productDetailsController.childrenVariationModel1.value.data?[index].oldCurrencyPrice
                                                                                  .toString() ??
                                                                              '';
                                                                          productDetailsController
                                                                              .variationsku
                                                                              .value = productDetailsController.childrenVariationModel1.value.data?[index].sku
                                                                                  .toString() ??
                                                                              '';
                                                                          productDetailsController
                                                                              .variationsStock
                                                                              .value = productDetailsController.childrenVariationModel1.value.data?[index].stock!
                                                                                  .toInt() ??
                                                                              0;
                                                                        } else {
                                                                          productDetailsController
                                                                              .variationProductId
                                                                              .value = '';
                                                                          productDetailsController
                                                                              .variationProductPrice
                                                                              .value = '';
                                                                          productDetailsController
                                                                              .variationProductCurrencyPrice
                                                                              .value = '';
                                                                          productDetailsController
                                                                              .variationProductOldPrice
                                                                              .value = '';
                                                                          productDetailsController
                                                                              .variationProductOldCurrencyPrice
                                                                              .value = '';
                                                                          productDetailsController
                                                                              .variationsku
                                                                              .value = '';
                                                                          productDetailsController
                                                                              .variationsStock
                                                                              .value = -1;
                                                                        }

                                                                        if (productDetailsController.childrenVariationModel1.value.data?[index].sku ==
                                                                            null) {
                                                                          await productDetailsController.fetchChildrenVariation2(
                                                                              initialVariationId: productDetailsController.childrenVariationModel1.value.data![index].id.toString());
                                                                        }
                                                                      },
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            EdgeInsets.only(right: 8.w),
                                                                        child:
                                                                            Container(
                                                                          decoration: BoxDecoration(
                                                                              color: productDetailsController.selectedIndex2.value == index ? AppColor.primaryColor : AppColor.cartColor,
                                                                              borderRadius: BorderRadius.circular(50.r)),
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                EdgeInsets.only(left: 12.5.w, right: 12.5.w),
                                                                            child:
                                                                                Center(
                                                                              child: CustomText(
                                                                                text: productDetailsController.childrenVariationModel1.value.data?[index].productAttributeOptionName ?? '',
                                                                                color: productDetailsController.selectedIndex2.value == index ? Colors.white : Colors.black,
                                                                                size: 12.sp,
                                                                                weight: FontWeight.w500,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }),
                                                        )
                                                      : const SizedBox(),
                                                  productDetailsController
                                                                  .childrenVariationModel1
                                                                  .value
                                                                  .data !=
                                                              null &&
                                                          productDetailsController
                                                              .childrenVariationModel1
                                                              .value
                                                              .data!
                                                              .isNotEmpty
                                                      ? SizedBox(height: 24.h)
                                                      : const SizedBox(),
                                                ],
                                              ),
                                        productDetailsController
                                                        .selectedIndex2.value ==
                                                    -1 &&
                                                productDetailsController
                                                        .childrenVariationModel2
                                                        .value
                                                        .data ==
                                                    null
                                            ? const SizedBox()
                                            : Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  productDetailsController
                                                                  .childrenVariationModel2
                                                                  .value
                                                                  .data !=
                                                              null &&
                                                          productDetailsController
                                                              .childrenVariationModel2
                                                              .value
                                                              .data!
                                                              .isNotEmpty
                                                      ? CustomText(
                                                          text:
                                                              '${productDetailsController.childrenVariationModel2.value.data?[0].productAttributeName.toString().tr ?? ''}:',
                                                          size: 14.sp,
                                                          weight:
                                                              FontWeight.w600,
                                                        )
                                                      : const SizedBox(),
                                                  productDetailsController
                                                                  .childrenVariationModel2
                                                                  .value
                                                                  .data !=
                                                              null &&
                                                          productDetailsController
                                                              .childrenVariationModel2
                                                              .value
                                                              .data!
                                                              .isNotEmpty
                                                      ? SizedBox(height: 8.h)
                                                      : const SizedBox(),
                                                  productDetailsController
                                                                  .childrenVariationModel2
                                                                  .value
                                                                  .data !=
                                                              null &&
                                                          productDetailsController
                                                              .childrenVariationModel2
                                                              .value
                                                              .data!
                                                              .isNotEmpty
                                                      ? SizedBox(
                                                          height: 32.h,
                                                          child:
                                                              ListView.builder(
                                                                  itemCount: productDetailsController
                                                                          .childrenVariationModel2
                                                                          .value
                                                                          .data
                                                                          ?.length ??
                                                                      0,
                                                                  scrollDirection:
                                                                      Axis
                                                                          .horizontal,
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    return GestureDetector(
                                                                      onTap:
                                                                          () async {
                                                                        cartController
                                                                            .numOfItems
                                                                            .value = 1;
                                                                        productDetailsController
                                                                            .selectedIndex3
                                                                            .value = index;

                                                                        productDetailsController
                                                                            .selectedIndex4
                                                                            .value = -1;
                                                                        productDetailsController
                                                                            .selectedIndex5
                                                                            .value = -1;
                                                                        productDetailsController
                                                                            .selectedIndex6
                                                                            .value = -1;
                                                                        productDetailsController
                                                                            .selectedIndex7
                                                                            .value = -1;

                                                                        productDetailsController
                                                                            .childrenVariationModel3
                                                                            .value
                                                                            .data
                                                                            ?.clear();
                                                                        productDetailsController
                                                                            .childrenVariationModel4
                                                                            .value
                                                                            .data
                                                                            ?.clear();
                                                                        productDetailsController
                                                                            .childrenVariationModel5
                                                                            .value
                                                                            .data
                                                                            ?.clear();
                                                                        productDetailsController
                                                                            .childrenVariationModel6
                                                                            .value
                                                                            .data
                                                                            ?.clear();

                                                                        if (productDetailsController.childrenVariationModel2.value.data![index].sku !=
                                                                            null) {
                                                                          productDetailsController
                                                                              .variationProductId
                                                                              .value = productDetailsController.childrenVariationModel2.value.data?[index].id
                                                                                  .toString() ??
                                                                              '';
                                                                          productDetailsController
                                                                              .variationProductPrice
                                                                              .value = productDetailsController.childrenVariationModel2.value.data?[index].price
                                                                                  .toString() ??
                                                                              '';
                                                                          productDetailsController
                                                                              .variationProductCurrencyPrice
                                                                              .value = productDetailsController.childrenVariationModel2.value.data?[index].currencyPrice
                                                                                  .toString() ??
                                                                              '';
                                                                          productDetailsController
                                                                              .variationProductOldPrice
                                                                              .value = productDetailsController.childrenVariationModel2.value.data?[index].oldPrice
                                                                                  .toString() ??
                                                                              '';
                                                                          productDetailsController
                                                                              .variationProductOldCurrencyPrice
                                                                              .value = productDetailsController.childrenVariationModel2.value.data?[index].oldCurrencyPrice
                                                                                  .toString() ??
                                                                              '';
                                                                          productDetailsController
                                                                              .variationsku
                                                                              .value = productDetailsController.childrenVariationModel2.value.data?[index].sku
                                                                                  .toString() ??
                                                                              '';
                                                                          productDetailsController
                                                                              .variationsStock
                                                                              .value = productDetailsController.childrenVariationModel2.value.data?[index].stock!
                                                                                  .toInt() ??
                                                                              0;
                                                                        } else {
                                                                          productDetailsController
                                                                              .variationProductId
                                                                              .value = '';
                                                                          productDetailsController
                                                                              .variationProductPrice
                                                                              .value = '';
                                                                          productDetailsController
                                                                              .variationProductCurrencyPrice
                                                                              .value = '';
                                                                          productDetailsController
                                                                              .variationProductOldPrice
                                                                              .value = '';
                                                                          productDetailsController
                                                                              .variationProductOldCurrencyPrice
                                                                              .value = '';
                                                                          productDetailsController
                                                                              .variationsku
                                                                              .value = '';
                                                                          productDetailsController
                                                                              .variationsStock
                                                                              .value = -1;
                                                                        }

                                                                        if (productDetailsController.childrenVariationModel2.value.data![index].sku ==
                                                                            null) {
                                                                          await productDetailsController.fetchChildrenVariation3(
                                                                              initialVariationId: productDetailsController.childrenVariationModel2.value.data![index].id.toString());
                                                                        }
                                                                      },
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            EdgeInsets.only(right: 8.w),
                                                                        child:
                                                                            Container(
                                                                          decoration: BoxDecoration(
                                                                              color: productDetailsController.selectedIndex3.value == index ? AppColor.primaryColor : AppColor.cartColor,
                                                                              borderRadius: BorderRadius.circular(50.r)),
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                EdgeInsets.only(left: 12.5.w, right: 12.5.w),
                                                                            child:
                                                                                Center(
                                                                              child: CustomText(
                                                                                text: productDetailsController.childrenVariationModel2.value.data?[index].productAttributeOptionName ?? '',
                                                                                color: productDetailsController.selectedIndex3.value == index ? Colors.white : Colors.black,
                                                                                size: 12.sp,
                                                                                weight: FontWeight.w500,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }),
                                                        )
                                                      : const SizedBox(),
                                                  productDetailsController
                                                                  .childrenVariationModel2
                                                                  .value
                                                                  .data !=
                                                              null &&
                                                          productDetailsController
                                                              .childrenVariationModel2
                                                              .value
                                                              .data!
                                                              .isNotEmpty
                                                      ? SizedBox(height: 24.h)
                                                      : const SizedBox(),
                                                ],
                                              ),
                                        productDetailsController
                                                        .selectedIndex3.value ==
                                                    -1 &&
                                                productDetailsController
                                                        .childrenVariationModel3
                                                        .value
                                                        .data ==
                                                    null
                                            ? const SizedBox()
                                            : Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  productDetailsController
                                                                  .childrenVariationModel3
                                                                  .value
                                                                  .data !=
                                                              null &&
                                                          productDetailsController
                                                              .childrenVariationModel3
                                                              .value
                                                              .data!
                                                              .isNotEmpty
                                                      ? CustomText(
                                                          text:
                                                              '${productDetailsController.childrenVariationModel3.value.data?[0].productAttributeName.toString().tr ?? ''}:',
                                                          size: 14.sp,
                                                          weight:
                                                              FontWeight.w600,
                                                        )
                                                      : const SizedBox(),
                                                  productDetailsController
                                                                  .childrenVariationModel3
                                                                  .value
                                                                  .data !=
                                                              null &&
                                                          productDetailsController
                                                              .childrenVariationModel3
                                                              .value
                                                              .data!
                                                              .isNotEmpty
                                                      ? SizedBox(height: 8.h)
                                                      : const SizedBox(),
                                                  productDetailsController
                                                                  .childrenVariationModel3
                                                                  .value
                                                                  .data !=
                                                              null &&
                                                          productDetailsController
                                                              .childrenVariationModel3
                                                              .value
                                                              .data!
                                                              .isNotEmpty
                                                      ? SizedBox(
                                                          height: 32.h,
                                                          child:
                                                              ListView.builder(
                                                                  itemCount: productDetailsController
                                                                          .childrenVariationModel3
                                                                          .value
                                                                          .data
                                                                          ?.length ??
                                                                      0,
                                                                  scrollDirection:
                                                                      Axis
                                                                          .horizontal,
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    return GestureDetector(
                                                                      onTap:
                                                                          () async {
                                                                        cartController
                                                                            .numOfItems
                                                                            .value = 1;
                                                                        productDetailsController
                                                                            .selectedIndex4
                                                                            .value = index;

                                                                        productDetailsController
                                                                            .selectedIndex5
                                                                            .value = -1;
                                                                        productDetailsController
                                                                            .selectedIndex6
                                                                            .value = -1;
                                                                        productDetailsController
                                                                            .selectedIndex7
                                                                            .value = -1;

                                                                        productDetailsController
                                                                            .childrenVariationModel4
                                                                            .value
                                                                            .data
                                                                            ?.clear();
                                                                        productDetailsController
                                                                            .childrenVariationModel5
                                                                            .value
                                                                            .data
                                                                            ?.clear();
                                                                        productDetailsController
                                                                            .childrenVariationModel6
                                                                            .value
                                                                            .data
                                                                            ?.clear();

                                                                        if (productDetailsController.childrenVariationModel3.value.data![index].sku !=
                                                                            null) {
                                                                          productDetailsController
                                                                              .variationProductId
                                                                              .value = productDetailsController.childrenVariationModel3.value.data?[index].id
                                                                                  .toString() ??
                                                                              '';
                                                                          productDetailsController
                                                                              .variationProductPrice
                                                                              .value = productDetailsController.childrenVariationModel3.value.data?[index].price
                                                                                  .toString() ??
                                                                              '';
                                                                          productDetailsController
                                                                              .variationProductCurrencyPrice
                                                                              .value = productDetailsController.childrenVariationModel3.value.data?[index].currencyPrice
                                                                                  .toString() ??
                                                                              '';
                                                                          productDetailsController
                                                                              .variationProductOldPrice
                                                                              .value = productDetailsController.childrenVariationModel3.value.data?[index].oldPrice
                                                                                  .toString() ??
                                                                              '';
                                                                          productDetailsController
                                                                              .variationProductOldCurrencyPrice
                                                                              .value = productDetailsController.childrenVariationModel3.value.data?[index].oldCurrencyPrice
                                                                                  .toString() ??
                                                                              '';
                                                                          productDetailsController
                                                                              .variationsku
                                                                              .value = productDetailsController.childrenVariationModel3.value.data?[index].sku
                                                                                  .toString() ??
                                                                              '';
                                                                          productDetailsController
                                                                              .variationsStock
                                                                              .value = productDetailsController.childrenVariationModel3.value.data?[index].stock!
                                                                                  .toInt() ??
                                                                              0;
                                                                        } else {
                                                                          productDetailsController
                                                                              .variationProductId
                                                                              .value = '';
                                                                          productDetailsController
                                                                              .variationProductPrice
                                                                              .value = '';
                                                                          productDetailsController
                                                                              .variationProductCurrencyPrice
                                                                              .value = '';
                                                                          productDetailsController
                                                                              .variationProductOldPrice
                                                                              .value = '';
                                                                          productDetailsController
                                                                              .variationProductOldCurrencyPrice
                                                                              .value = '';
                                                                          productDetailsController
                                                                              .variationsku
                                                                              .value = '';
                                                                          productDetailsController
                                                                              .variationsStock
                                                                              .value = -1;
                                                                        }

                                                                        if (productDetailsController.childrenVariationModel3.value.data?[index].sku ==
                                                                            null) {
                                                                          await productDetailsController.fetchChildrenVariation4(
                                                                              initialVariationId: productDetailsController.childrenVariationModel3.value.data![index].id.toString());
                                                                        }
                                                                      },
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            EdgeInsets.only(right: 8.w),
                                                                        child:
                                                                            Container(
                                                                          decoration: BoxDecoration(
                                                                              color: productDetailsController.selectedIndex4.value == index ? AppColor.primaryColor : AppColor.cartColor,
                                                                              borderRadius: BorderRadius.circular(50.r)),
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                EdgeInsets.only(left: 12.5.w, right: 12.5.w),
                                                                            child:
                                                                                Center(
                                                                              child: CustomText(
                                                                                text: productDetailsController.childrenVariationModel3.value.data?[index].productAttributeOptionName ?? '',
                                                                                color: productDetailsController.selectedIndex4.value == index ? Colors.white : Colors.black,
                                                                                size: 12.sp,
                                                                                weight: FontWeight.w500,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }),
                                                        )
                                                      : const SizedBox(),
                                                  productDetailsController
                                                                  .childrenVariationModel3
                                                                  .value
                                                                  .data !=
                                                              null &&
                                                          productDetailsController
                                                              .childrenVariationModel3
                                                              .value
                                                              .data!
                                                              .isNotEmpty
                                                      ? SizedBox(height: 24.h)
                                                      : const SizedBox(),
                                                ],
                                              ),
                                        productDetailsController
                                                        .selectedIndex4.value ==
                                                    -1 &&
                                                productDetailsController
                                                        .childrenVariationModel4
                                                        .value
                                                        .data ==
                                                    null
                                            ? const SizedBox()
                                            : Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  productDetailsController
                                                                  .childrenVariationModel4
                                                                  .value
                                                                  .data !=
                                                              null &&
                                                          productDetailsController
                                                              .childrenVariationModel4
                                                              .value
                                                              .data!
                                                              .isNotEmpty
                                                      ? CustomText(
                                                          text:
                                                              '${productDetailsController.childrenVariationModel4.value.data?[0].productAttributeName.toString().tr ?? ''}:',
                                                          size: 14.sp,
                                                          weight:
                                                              FontWeight.w600,
                                                        )
                                                      : const SizedBox(),
                                                  productDetailsController
                                                                  .childrenVariationModel4
                                                                  .value
                                                                  .data !=
                                                              null &&
                                                          productDetailsController
                                                              .childrenVariationModel4
                                                              .value
                                                              .data!
                                                              .isNotEmpty
                                                      ? SizedBox(height: 8.h)
                                                      : const SizedBox(),
                                                  productDetailsController
                                                                  .childrenVariationModel4
                                                                  .value
                                                                  .data !=
                                                              null &&
                                                          productDetailsController
                                                              .childrenVariationModel4
                                                              .value
                                                              .data!
                                                              .isNotEmpty
                                                      ? SizedBox(
                                                          height: 32.h,
                                                          child:
                                                              ListView.builder(
                                                                  itemCount: productDetailsController
                                                                          .childrenVariationModel4
                                                                          .value
                                                                          .data
                                                                          ?.length ??
                                                                      0,
                                                                  scrollDirection:
                                                                      Axis
                                                                          .horizontal,
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    return GestureDetector(
                                                                      onTap:
                                                                          () async {
                                                                        cartController
                                                                            .numOfItems
                                                                            .value = 1;
                                                                        productDetailsController
                                                                            .selectedIndex5
                                                                            .value = index;

                                                                        productDetailsController
                                                                            .selectedIndex6
                                                                            .value = -1;
                                                                        productDetailsController
                                                                            .selectedIndex7
                                                                            .value = -1;

                                                                        productDetailsController
                                                                            .childrenVariationModel5
                                                                            .value
                                                                            .data
                                                                            ?.clear();
                                                                        productDetailsController
                                                                            .childrenVariationModel6
                                                                            .value
                                                                            .data
                                                                            ?.clear();

                                                                        if (productDetailsController.childrenVariationModel4.value.data![index].sku !=
                                                                            null) {
                                                                          productDetailsController
                                                                              .variationProductId
                                                                              .value = productDetailsController.childrenVariationModel4.value.data?[index].id
                                                                                  .toString() ??
                                                                              '';
                                                                          productDetailsController
                                                                              .variationProductPrice
                                                                              .value = productDetailsController.childrenVariationModel4.value.data?[index].price
                                                                                  .toString() ??
                                                                              '';
                                                                          productDetailsController
                                                                              .variationProductCurrencyPrice
                                                                              .value = productDetailsController.childrenVariationModel4.value.data?[index].currencyPrice
                                                                                  .toString() ??
                                                                              '';
                                                                          productDetailsController
                                                                              .variationProductOldPrice
                                                                              .value = productDetailsController.childrenVariationModel4.value.data?[index].oldPrice
                                                                                  .toString() ??
                                                                              '';
                                                                          productDetailsController
                                                                              .variationProductOldCurrencyPrice
                                                                              .value = productDetailsController.childrenVariationModel4.value.data?[index].oldCurrencyPrice
                                                                                  .toString() ??
                                                                              '';
                                                                          productDetailsController
                                                                              .variationsku
                                                                              .value = productDetailsController.childrenVariationModel4.value.data?[index].sku
                                                                                  .toString() ??
                                                                              '';
                                                                          productDetailsController
                                                                              .variationsStock
                                                                              .value = productDetailsController.childrenVariationModel4.value.data?[index].stock!
                                                                                  .toInt() ??
                                                                              0;
                                                                        } else {
                                                                          productDetailsController
                                                                              .variationProductId
                                                                              .value = '';
                                                                          productDetailsController
                                                                              .variationProductPrice
                                                                              .value = '';
                                                                          productDetailsController
                                                                              .variationProductCurrencyPrice
                                                                              .value = '';
                                                                          productDetailsController
                                                                              .variationProductOldPrice
                                                                              .value = '';
                                                                          productDetailsController
                                                                              .variationProductOldCurrencyPrice
                                                                              .value = '';
                                                                          productDetailsController
                                                                              .variationsku
                                                                              .value = '';
                                                                          productDetailsController
                                                                              .variationsStock
                                                                              .value = -1;
                                                                        }

                                                                        if (productDetailsController.childrenVariationModel4.value.data![index].sku ==
                                                                            null) {
                                                                          await productDetailsController.fetchChildrenVariation5(
                                                                              initialVariationId: productDetailsController.childrenVariationModel4.value.data![index].id.toString());
                                                                        }
                                                                      },
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            EdgeInsets.only(right: 8.w),
                                                                        child:
                                                                            Container(
                                                                          decoration: BoxDecoration(
                                                                              color: productDetailsController.selectedIndex5.value == index ? AppColor.primaryColor : AppColor.cartColor,
                                                                              borderRadius: BorderRadius.circular(50.r)),
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                EdgeInsets.only(left: 12.5.w, right: 12.5.w),
                                                                            child:
                                                                                Center(
                                                                              child: CustomText(
                                                                                text: productDetailsController.childrenVariationModel4.value.data?[index].productAttributeOptionName ?? '',
                                                                                color: productDetailsController.selectedIndex5.value == index ? Colors.white : Colors.black,
                                                                                size: 12.sp,
                                                                                weight: FontWeight.w500,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }),
                                                        )
                                                      : const SizedBox(),
                                                  productDetailsController
                                                                  .childrenVariationModel4
                                                                  .value
                                                                  .data !=
                                                              null &&
                                                          productDetailsController
                                                              .childrenVariationModel4
                                                              .value
                                                              .data!
                                                              .isNotEmpty
                                                      ? SizedBox(height: 24.h)
                                                      : const SizedBox(),
                                                ],
                                              ),
                                        productDetailsController
                                                        .selectedIndex5.value ==
                                                    -1 &&
                                                productDetailsController
                                                        .childrenVariationModel5
                                                        .value
                                                        .data ==
                                                    null
                                            ? const SizedBox()
                                            : Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  productDetailsController
                                                                  .childrenVariationModel5
                                                                  .value
                                                                  .data !=
                                                              null &&
                                                          productDetailsController
                                                              .childrenVariationModel5
                                                              .value
                                                              .data!
                                                              .isNotEmpty
                                                      ? CustomText(
                                                          text:
                                                              '${productDetailsController.childrenVariationModel5.value.data?[0].productAttributeName.toString().tr ?? ''}:',
                                                          size: 15.sp,
                                                          weight:
                                                              FontWeight.w600,
                                                        )
                                                      : const SizedBox(),
                                                  productDetailsController
                                                                  .childrenVariationModel5
                                                                  .value
                                                                  .data !=
                                                              null &&
                                                          productDetailsController
                                                              .childrenVariationModel5
                                                              .value
                                                              .data!
                                                              .isNotEmpty
                                                      ? SizedBox(height: 8.h)
                                                      : const SizedBox(),
                                                  productDetailsController
                                                                  .childrenVariationModel5
                                                                  .value
                                                                  .data !=
                                                              null &&
                                                          productDetailsController
                                                              .childrenVariationModel5
                                                              .value
                                                              .data!
                                                              .isNotEmpty
                                                      ? SizedBox(
                                                          height: 32.h,
                                                          child:
                                                              ListView.builder(
                                                                  itemCount: productDetailsController
                                                                          .childrenVariationModel5
                                                                          .value
                                                                          .data
                                                                          ?.length ??
                                                                      0,
                                                                  scrollDirection:
                                                                      Axis
                                                                          .horizontal,
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    return GestureDetector(
                                                                      onTap:
                                                                          () async {
                                                                        cartController
                                                                            .numOfItems
                                                                            .value = 1;
                                                                        productDetailsController
                                                                            .selectedIndex6
                                                                            .value = index;

                                                                        productDetailsController
                                                                            .selectedIndex7
                                                                            .value = -1;

                                                                        productDetailsController
                                                                            .childrenVariationModel6
                                                                            .value
                                                                            .data
                                                                            ?.clear();

                                                                        if (productDetailsController.childrenVariationModel5.value.data![index].sku !=
                                                                            null) {
                                                                          productDetailsController
                                                                              .variationProductId
                                                                              .value = productDetailsController.childrenVariationModel5.value.data?[index].id
                                                                                  .toString() ??
                                                                              '';
                                                                          productDetailsController
                                                                              .variationProductPrice
                                                                              .value = productDetailsController.childrenVariationModel5.value.data?[index].price
                                                                                  .toString() ??
                                                                              '';
                                                                          productDetailsController
                                                                              .variationProductCurrencyPrice
                                                                              .value = productDetailsController.childrenVariationModel5.value.data?[index].currencyPrice
                                                                                  .toString() ??
                                                                              '';
                                                                          productDetailsController
                                                                              .variationProductOldPrice
                                                                              .value = productDetailsController.childrenVariationModel5.value.data?[index].oldPrice
                                                                                  .toString() ??
                                                                              '';
                                                                          productDetailsController
                                                                              .variationProductOldCurrencyPrice
                                                                              .value = productDetailsController.childrenVariationModel5.value.data?[index].oldCurrencyPrice
                                                                                  .toString() ??
                                                                              '';
                                                                          productDetailsController
                                                                              .variationsku
                                                                              .value = productDetailsController.childrenVariationModel5.value.data?[index].sku
                                                                                  .toString() ??
                                                                              '';
                                                                          productDetailsController
                                                                              .variationsStock
                                                                              .value = productDetailsController.childrenVariationModel5.value.data?[index].stock!
                                                                                  .toInt() ??
                                                                              0;
                                                                        } else {
                                                                          productDetailsController
                                                                              .variationProductId
                                                                              .value = '';
                                                                          productDetailsController
                                                                              .variationProductPrice
                                                                              .value = '';
                                                                          productDetailsController
                                                                              .variationProductCurrencyPrice
                                                                              .value = '';
                                                                          productDetailsController
                                                                              .variationProductOldPrice
                                                                              .value = '';
                                                                          productDetailsController
                                                                              .variationProductOldCurrencyPrice
                                                                              .value = '';
                                                                          productDetailsController
                                                                              .variationsku
                                                                              .value = '';
                                                                          productDetailsController
                                                                              .variationsStock
                                                                              .value = -1;
                                                                        }

                                                                        if (productDetailsController.childrenVariationModel5.value.data![index].sku ==
                                                                            null) {
                                                                          await productDetailsController.fetchChildrenVariation6(
                                                                              initialVariationId: productDetailsController.childrenVariationModel5.value.data![index].id.toString());
                                                                        }
                                                                      },
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            EdgeInsets.only(right: 8.w),
                                                                        child:
                                                                            Container(
                                                                          decoration: BoxDecoration(
                                                                              color: productDetailsController.selectedIndex6.value == index ? AppColor.primaryColor : AppColor.cartColor,
                                                                              borderRadius: BorderRadius.circular(50.r)),
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                EdgeInsets.only(left: 12.5.w, right: 12.5.w),
                                                                            child:
                                                                                Center(
                                                                              child: CustomText(
                                                                                text: productDetailsController.childrenVariationModel5.value.data?[index].productAttributeOptionName ?? '',
                                                                                color: productDetailsController.selectedIndex6.value == index ? Colors.white : Colors.black,
                                                                                size: 12.sp,
                                                                                weight: FontWeight.w500,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }),
                                                        )
                                                      : const SizedBox(),
                                                  productDetailsController
                                                                  .childrenVariationModel5
                                                                  .value
                                                                  .data !=
                                                              null &&
                                                          productDetailsController
                                                              .childrenVariationModel5
                                                              .value
                                                              .data!
                                                              .isNotEmpty
                                                      ? SizedBox(height: 24.h)
                                                      : const SizedBox(),
                                                ],
                                              ),
                                        productDetailsController
                                                        .selectedIndex6.value ==
                                                    -1 &&
                                                productDetailsController
                                                        .childrenVariationModel6
                                                        .value
                                                        .data ==
                                                    null
                                            ? const SizedBox()
                                            : Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  productDetailsController
                                                                  .childrenVariationModel6
                                                                  .value
                                                                  .data !=
                                                              null &&
                                                          productDetailsController
                                                              .childrenVariationModel6
                                                              .value
                                                              .data!
                                                              .isNotEmpty
                                                      ? CustomText(
                                                          text:
                                                              '${productDetailsController.childrenVariationModel6.value.data?[0].productAttributeName.toString().tr ?? ''}:',
                                                          size: 14.sp,
                                                          weight:
                                                              FontWeight.w600,
                                                        )
                                                      : const SizedBox(),
                                                  productDetailsController
                                                                  .childrenVariationModel6
                                                                  .value
                                                                  .data !=
                                                              null &&
                                                          productDetailsController
                                                              .childrenVariationModel6
                                                              .value
                                                              .data!
                                                              .isNotEmpty
                                                      ? SizedBox(height: 8.h)
                                                      : const SizedBox(),
                                                  productDetailsController
                                                                  .childrenVariationModel6
                                                                  .value
                                                                  .data !=
                                                              null &&
                                                          productDetailsController
                                                              .childrenVariationModel6
                                                              .value
                                                              .data!
                                                              .isNotEmpty
                                                      ? SizedBox(
                                                          height: 32.h,
                                                          child:
                                                              ListView.builder(
                                                                  itemCount: productDetailsController
                                                                          .childrenVariationModel6
                                                                          .value
                                                                          .data
                                                                          ?.length ??
                                                                      0,
                                                                  scrollDirection:
                                                                      Axis
                                                                          .horizontal,
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    return GestureDetector(
                                                                      onTap:
                                                                          () async {
                                                                        cartController
                                                                            .numOfItems
                                                                            .value = 1;

                                                                        productDetailsController
                                                                            .selectedIndex7
                                                                            .value = index;

                                                                        if (productDetailsController.childrenVariationModel6.value.data?[index].sku !=
                                                                            null) {
                                                                          productDetailsController
                                                                              .variationProductId
                                                                              .value = productDetailsController.childrenVariationModel6.value.data?[index].id
                                                                                  .toString() ??
                                                                              '';
                                                                          productDetailsController
                                                                              .variationProductPrice
                                                                              .value = productDetailsController.childrenVariationModel6.value.data?[index].price
                                                                                  .toString() ??
                                                                              '';
                                                                          productDetailsController
                                                                              .variationProductCurrencyPrice
                                                                              .value = productDetailsController.childrenVariationModel6.value.data?[index].currencyPrice
                                                                                  .toString() ??
                                                                              '';
                                                                          productDetailsController
                                                                              .variationProductOldPrice
                                                                              .value = productDetailsController.childrenVariationModel6.value.data?[index].oldPrice
                                                                                  .toString() ??
                                                                              '';
                                                                          productDetailsController
                                                                              .variationProductOldCurrencyPrice
                                                                              .value = productDetailsController.childrenVariationModel6.value.data?[index].oldCurrencyPrice
                                                                                  .toString() ??
                                                                              '';
                                                                          productDetailsController
                                                                              .variationsku
                                                                              .value = productDetailsController.childrenVariationModel6.value.data?[index].sku
                                                                                  .toString() ??
                                                                              '';
                                                                          productDetailsController
                                                                              .variationsStock
                                                                              .value = productDetailsController.childrenVariationModel6.value.data?[index].stock!
                                                                                  .toInt() ??
                                                                              0;
                                                                        } else {
                                                                          productDetailsController
                                                                              .variationProductId
                                                                              .value = '';
                                                                          productDetailsController
                                                                              .variationProductPrice
                                                                              .value = '';
                                                                          productDetailsController
                                                                              .variationProductCurrencyPrice
                                                                              .value = '';
                                                                          productDetailsController
                                                                              .variationProductOldPrice
                                                                              .value = '';
                                                                          productDetailsController
                                                                              .variationProductOldCurrencyPrice
                                                                              .value = '';
                                                                          productDetailsController
                                                                              .variationsku
                                                                              .value = '';
                                                                          productDetailsController
                                                                              .variationsStock
                                                                              .value = -1;
                                                                        }
                                                                      },
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            EdgeInsets.only(right: 8.w),
                                                                        child:
                                                                            Container(
                                                                          decoration: BoxDecoration(
                                                                              color: productDetailsController.selectedIndex7.value == index ? AppColor.primaryColor : AppColor.cartColor,
                                                                              borderRadius: BorderRadius.circular(50.r)),
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                EdgeInsets.only(left: 12.5.w, right: 12.5.w),
                                                                            child:
                                                                                Center(
                                                                              child: CustomText(
                                                                                text: productDetailsController.childrenVariationModel5.value.data![index].productAttributeOptionName,
                                                                                color: productDetailsController.selectedIndex7.value == index ? Colors.white : Colors.black,
                                                                                size: 12.sp,
                                                                                weight: FontWeight.w500,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }),
                                                        )
                                                      : const SizedBox(),
                                                  productDetailsController
                                                                  .childrenVariationModel5
                                                                  .value
                                                                  .data !=
                                                              null &&
                                                          productDetailsController
                                                              .childrenVariationModel5
                                                              .value
                                                              .data!
                                                              .isNotEmpty
                                                      ? SizedBox(height: 24.h)
                                                      : const SizedBox(),
                                                ],
                                              ),
                                      ],
                                    ),
                              CustomText(
                                text: "QUANTITY".tr,
                                size: 14.sp,
                                weight: FontWeight.w600,
                              ),
                              SizedBox(height: 8.h),
                              Row(
                                children: [
                                  Container(
                                    width: 99.w,
                                    height: 36.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.r),
                                      color: AppColor.cartColor,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        GestureDetector(
                                            onTap: () {
                                              if (productDetailsController
                                                      .variationsStock.value <
                                                  0) {
                                              } else {
                                                if (cartController
                                                        .numOfItems.value >
                                                    1) {
                                                  cartController
                                                      .numOfItems.value--;
                                                } else {}
                                              }
                                            },
                                            child: productDetailsController
                                                        .variationsStock
                                                        .value !=
                                                    -1
                                                ? cartController.numOfItems
                                                                .value ==
                                                            1 ||
                                                        productDetailsController
                                                                .variationsStock
                                                                .value ==
                                                            1
                                                    ? SvgPicture.asset(
                                                        SvgIcon.decrement,
                                                        color: Colors.grey,
                                                        height: 20.h,
                                                        width: 20.w)
                                                    : SvgPicture.asset(
                                                        SvgIcon.decrement,
                                                        height: 20.h,
                                                        width: 20.w)
                                                : SvgPicture.asset(
                                                    SvgIcon.decrement,
                                                    height: 20.h,
                                                    width: 20.w,
                                                    color: Colors.grey)),
                                        Obx(
                                          () => CustomText(
                                              text: cartController
                                                  .numOfItems.value
                                                  .toString(),
                                              size: 18.sp,
                                              weight: FontWeight.w600),
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              if (productDetailsController
                                                      .variationsStock.value <
                                                  0) {
                                              } else {
                                                if (cartController
                                                        .numOfItems.value <
                                                    productDetailsController
                                                        .variationsStock
                                                        .value) {
                                                  cartController
                                                      .numOfItems.value++;
                                                } else {}
                                              }
                                            },
                                            child: productDetailsController
                                                        .variationsStock
                                                        .value !=
                                                    -1
                                                ? cartController.numOfItems.value ==
                                                            productDetailsController
                                                                .variationsStock
                                                                .value ||
                                                        productDetailsController
                                                                .variationsStock
                                                                .value ==
                                                            0
                                                    ? SvgPicture.asset(
                                                        SvgIcon.increment,
                                                        color: Colors.grey,
                                                        height: 20.h,
                                                        width: 20.w)
                                                    : SvgPicture.asset(
                                                        SvgIcon.increment,
                                                        height: 20.h,
                                                        width: 20.w)
                                                : SvgPicture.asset(
                                                    SvgIcon.increment,
                                                    height: 20.h,
                                                    width: 20.w,
                                                    color: Colors.grey))
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  productDetailsController
                                              .variationsStock.value >
                                          0
                                      ? Row(
                                          children: [
                                            TextWidget(
                                              text: "Available:".tr,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            TextWidget(
                                                text:
                                                    " (${productDetailsController.variationsStock.value}) ",
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w600),
                                            TextWidget(
                                              text: productDetailsController
                                                  .productModel.value.data?.unit
                                                  ?.toLowerCase(),
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14.sp,
                                            )
                                          ],
                                        )
                                      : productDetailsController
                                                  .variationsStock.value ==
                                              0
                                          ? TextWidget(
                                              text: "Stock Out".tr,
                                              color: AppColor.redColor,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14.sp,
                                            )
                                          : const SizedBox()
                                ],
                              ),
                              SizedBox(height: 32.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SecondaryButton(
                                      height: 48.h,
                                      width: 165.w,
                                      icon: SvgIcon.bag,
                                      text: "ADD_TO_CART".tr,
                                      buttonColor: productDetailsController
                                                  .variationsStock.value >
                                              0
                                          ? AppColor.primaryColor
                                          : AppColor.grayColor,
                                      onTap: () async {
                                        if (productDetailsController
                                                    .initialVariationModel
                                                    .value
                                                    .data !=
                                                null &&
                                            productDetailsController
                                                .initialVariationModel
                                                .value
                                                .data!
                                                .isNotEmpty) {
                                          if (productDetailsController
                                                  .variationsStock.value >
                                              0) {
                                            await productDetailsController
                                                .finalVariation(
                                                    id: productDetailsController
                                                        .variationProductId
                                                        .toString());
                                            cartController
                                                    .totalIndividualProductTax =
                                                0.0;
                                            productDetailsController
                                                .productModel.value.data!.taxes!
                                                .map((e) {
                                              cartController
                                                      .totalIndividualProductTax +=
                                                  double.parse(
                                                      e.taxRate.toString());
                                            }).toList();

                                            var taxMap =
                                                productDetailsController
                                                    .productModel
                                                    .value
                                                    .data!
                                                    .taxes!
                                                    .map((e) {
                                              return {
                                                "id": e.id!.toInt(),
                                                "name": e.name.toString(),
                                                "code": e.code.toString(),
                                                "tax_rate": double.tryParse(
                                                    e.taxRate.toString()),
                                                'tax_amount': double.tryParse(
                                                    cartController.totalTax
                                                        .toString()),
                                              };
                                            }).toList();

                                            cartController.addItem(
                                                variationStock: productDetailsController
                                                    .variationsStock.value
                                                    .toInt(),
                                                product: productDetailsController
                                                    .productModel.value,
                                                variationId: int.parse(productDetailsController
                                                    .variationProductId.value),
                                                shippingAmount: authController.settingModel!.data!.shippingSetupMethod.toString() == "5" &&
                                                        productDetailsController
                                                                .productModel
                                                                .value
                                                                .data
                                                                ?.shipping
                                                                ?.shippingType
                                                                .toString() ==
                                                            "5"
                                                    ? "0"
                                                    : productDetailsController
                                                        .productModel
                                                        .value
                                                        .data!
                                                        .shipping!
                                                        .shippingCost,
                                                finalVariation: productDetailsController.finalVariationString,
                                                sku: productDetailsController.variationsku.value,
                                                taxJson: taxMap,
                                                stock: productDetailsController.variationsStock.value,
                                                shipping: productDetailsController.productModel.value.data!.shipping,
                                                productVariationPrice: productDetailsController.variationProductPrice.value,
                                                productVariationOldPrice: productDetailsController.variationProductOldPrice.value,
                                                productVariationCurrencyPrice: productDetailsController.variationProductCurrencyPrice.value,
                                                productVariationOldCurrencyPrice: productDetailsController.variationProductOldCurrencyPrice.value,
                                                totalTax: cartController.totalIndividualProductTax,
                                                flatShippingCost: authController.settingModel?.data?.shippingSetupFlatRateWiseCost.toString() ?? "0");

                                            cartController.calculateShippingCharge(
                                                shippingMethodStatus:
                                                    authController
                                                        .shippingMethod,
                                                shippingType:
                                                    productDetailsController
                                                            .productModel
                                                            .value
                                                            .data
                                                            ?.shipping
                                                            ?.shippingType
                                                            .toString() ??
                                                        "0",
                                                isProductQntyMultiply:
                                                    productDetailsController
                                                            .productModel
                                                            .value
                                                            .data
                                                            ?.shipping
                                                            ?.isProductQuantityMultiply
                                                            .toString() ??
                                                        "0",
                                                flatShippingCharge: authController
                                                    .settingModel
                                                    ?.data
                                                    ?.shippingSetupFlatRateWiseCost);

                                            customSnackbar(
                                                "SUCCESS".tr,
                                                "Product added to cart".tr,
                                                AppColor.success);
                                          } else {}
                                        } else {
                                          if (productDetailsController
                                                  .variationsStock.value >
                                              0) {
                                            cartController
                                                    .totalIndividualProductTax =
                                                0.0;

                                            productDetailsController
                                                .productModel.value.data!.taxes!
                                                .map((e) {
                                              cartController
                                                      .totalIndividualProductTax +=
                                                  double.parse(
                                                      e.taxRate.toString());
                                            }).toList();

                                            var taxMap =
                                                productDetailsController
                                                    .productModel
                                                    .value
                                                    .data!
                                                    .taxes!
                                                    .map((e) {
                                              return {
                                                "id": e.id!.toInt(),
                                                "name": e.name.toString(),
                                                "code": e.code.toString(),
                                                "tax_rate": double.tryParse(
                                                    e.taxRate.toString()),
                                                'tax_amount': double.tryParse(
                                                    cartController.totalTax
                                                        .toString()),
                                              };
                                            }).toList();

                                            cartController.addItem(
                                                variationStock: productDetailsController
                                                    .variationsStock.value
                                                    .toInt(),
                                                product: productDetailsController
                                                    .productModel.value,
                                                variationId: int.parse(productDetailsController
                                                    .variationProductId.value),
                                                shippingAmount: authController.settingModel!.data!.shippingSetupMethod.toString() == "5" &&
                                                        productDetailsController
                                                                .productModel
                                                                .value
                                                                .data
                                                                ?.shipping
                                                                ?.shippingType
                                                                .toString() ==
                                                            "5"
                                                    ? "0"
                                                    : productDetailsController
                                                        .productModel
                                                        .value
                                                        .data!
                                                        .shipping!
                                                        .shippingCost,
                                                finalVariation: productDetailsController.finalVariationString,
                                                sku: productDetailsController.productModel.value.data!.sku,
                                                taxJson: taxMap,
                                                stock: productDetailsController.productModel.value.data!.stock,
                                                shipping: productDetailsController.productModel.value.data!.shipping,
                                                productVariationPrice: productDetailsController.productModel.value.data!.price,
                                                productVariationOldPrice: productDetailsController.productModel.value.data!.oldPrice,
                                                productVariationCurrencyPrice: productDetailsController.productModel.value.data!.currencyPrice,
                                                productVariationOldCurrencyPrice: productDetailsController.productModel.value.data!.oldCurrencyPrice,
                                                totalTax: cartController.totalIndividualProductTax,
                                                flatShippingCost: authController.settingModel?.data?.shippingSetupFlatRateWiseCost.toString() ?? "0");

                                            cartController
                                                .calculateShippingCharge(
                                              shippingMethodStatus:
                                                  authController.shippingMethod,
                                              shippingType:
                                                  productDetailsController
                                                          .productModel
                                                          .value
                                                          .data
                                                          ?.shipping
                                                          ?.shippingType
                                                          .toString() ??
                                                      "0",
                                              isProductQntyMultiply:
                                                  productDetailsController
                                                          .productModel
                                                          .value
                                                          .data
                                                          ?.shipping
                                                          ?.isProductQuantityMultiply
                                                          .toString() ??
                                                      "0",
                                              flatShippingCharge: authController
                                                  .settingModel
                                                  ?.data
                                                  ?.shippingSetupFlatRateWiseCost,
                                            );

                                            customSnackbar(
                                                "SUCCESS".tr,
                                                "Product added to cart".tr,
                                                AppColor.success);
                                          } else {}
                                        }
                                      }),
                                  InkWell(
                                    onTap: () async {
                                      if (box.read('isLogedIn') != false) {
                                        if (productDetailsController
                                                .productModel
                                                .value
                                                .data!
                                                .wishlist ==
                                            true) {
                                          await wishlistController
                                              .toggleFavoriteFalse(
                                                  productDetailsController
                                                      .productModel
                                                      .value
                                                      .data!
                                                      .id!);

                                          wishlistController.showFavorite(
                                              productDetailsController
                                                  .productModel
                                                  .value
                                                  .data!
                                                  .id!);
                                        }
                                        if (productDetailsController
                                                .productModel
                                                .value
                                                .data!
                                                .wishlist ==
                                            false) {
                                          await wishlistController
                                              .toggleFavoriteTrue(
                                                  productDetailsController
                                                      .productModel
                                                      .value
                                                      .data!
                                                      .id!);

                                          wishlistController.showFavorite(
                                              productDetailsController
                                                  .productModel
                                                  .value
                                                  .data!
                                                  .id!);
                                        }
                                      } else {
                                        Get.to(() => const SignInScreen());
                                      }
                                    },
                                    borderRadius: BorderRadius.circular(24.r),
                                    child: Ink(
                                      height: 48.h,
                                      width: 139.w,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(24.r),
                                          color: AppColor.whiteColor,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.04),
                                                blurRadius: 8.r,
                                                offset: const Offset(0, 4))
                                          ]),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            wishlistController.favList.contains(
                                                        productDetailsController
                                                            .productModel
                                                            .value
                                                            .data!
                                                            .id!) ||
                                                    productDetailsController
                                                            .productModel
                                                            .value
                                                            .data!
                                                            .wishlist ==
                                                        true
                                                ? SvgIcon.filledHeart
                                                : SvgIcon.heart,
                                            height: 24.h,
                                            width: 24.w,
                                          ),
                                          SizedBox(width: 8.w),
                                          CustomText(
                                            text: "FAVORITE".tr,
                                            size: 16.sp,
                                            weight: FontWeight.w700,
                                            color: AppColor.textColor,
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 20.h),
                              const DeviderWidget(),
                              SizedBox(height: 20.h),
                              Obx(
                                () => productDetailsController
                                            .productModel.value.data !=
                                        null
                                    ? CustomTabBar(
                                        allProductModel: widget.allProductModel,
                                        categoryWiseProduct:
                                            widget.categoryWiseProduct,
                                        favoriteItem: widget.favoriteItem,
                                        productModel: widget.productModel,
                                        relatedProduct: widget.relatedProduct,
                                        sectionModel: widget.sectionModel,
                                      )
                                    : const SizedBox(),
                              ),
                              SizedBox(height: 30.h),
                              Obx(
                                () => productDetailsController
                                            .relatedProductModel.value !=
                                        null
                                    ? const SizedBox()
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomText(
                                            text: "RELATED_PRODUCTS".tr,
                                            size: 26.sp,
                                            weight: FontWeight.w700,
                                          ),
                                          SizedBox(height: 20.h),
                                          StaggeredGrid.count(
                                            crossAxisCount: 2,
                                            mainAxisSpacing: 10.h,
                                            crossAxisSpacing: 10.w,
                                            children: [
                                              for (int i = 0;
                                                  i <
                                                      productDetailsController
                                                          .relatedProductModel
                                                          .value
                                                          .data!
                                                          .length;
                                                  i++)
                                                ProductWidget(
                                                  onTap: () async {
                                                    productDetailsController
                                                        .resetProductState();
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            ProductDetailsScreen(
                                                                relatedProduct:
                                                                    productDetailsController
                                                                        .relatedProductModel
                                                                        .value
                                                                        .data?[i]),
                                                      ),
                                                    );
                                                  },
                                                  favTap: () async {
                                                    if (box.read('isLogedIn') !=
                                                        false) {
                                                      if (productDetailsController
                                                              .relatedProductModel
                                                              .value
                                                              .data?[i]
                                                              .wishlist ==
                                                          true) {
                                                        await wishlistController
                                                            .toggleFavoriteFalse(
                                                                productDetailsController
                                                                    .relatedProductModel
                                                                    .value
                                                                    .data![i]
                                                                    .id!);

                                                        wishlistController.showFavorite(
                                                            productDetailsController
                                                                .relatedProductModel
                                                                .value
                                                                .data![i]
                                                                .id!);
                                                      }
                                                      if (productDetailsController
                                                              .relatedProductModel
                                                              .value
                                                              .data?[i]
                                                              .wishlist ==
                                                          false) {
                                                        await wishlistController
                                                            .toggleFavoriteTrue(
                                                                productDetailsController
                                                                    .relatedProductModel
                                                                    .value
                                                                    .data![i]
                                                                    .id!);

                                                        wishlistController.showFavorite(
                                                            productDetailsController
                                                                .relatedProductModel
                                                                .value
                                                                .data![i]
                                                                .id!);
                                                      }
                                                    } else {
                                                      Get.to(() =>
                                                          const SignInScreen());
                                                    }
                                                  },
                                                  wishlist: wishlistController
                                                              .favList
                                                              .contains(
                                                                  productDetailsController
                                                                      .relatedProductModel
                                                                      .value
                                                                      .data![i]
                                                                      .id!) ||
                                                          productDetailsController
                                                                  .relatedProductModel
                                                                  .value
                                                                  .data?[i]
                                                                  .wishlist ==
                                                              true
                                                      ? true
                                                      : false,
                                                  productImage:
                                                      productDetailsController
                                                          .relatedProductModel
                                                          .value
                                                          .data?[i]
                                                          .cover,
                                                  title:
                                                      productDetailsController
                                                          .relatedProductModel
                                                          .value
                                                          .data?[i]
                                                          .name,
                                                  rating:
                                                      productDetailsController
                                                          .relatedProductModel
                                                          .value
                                                          .data?[i]
                                                          .ratingStar,
                                                  currentPrice:
                                                      productDetailsController
                                                          .relatedProductModel
                                                          .value
                                                          .data?[i]
                                                          .currencyPrice,
                                                  discountPrice:
                                                      productDetailsController
                                                          .relatedProductModel
                                                          .value
                                                          .data?[i]
                                                          .discountedPrice,
                                                  textRating:
                                                      productDetailsController
                                                          .relatedProductModel
                                                          .value
                                                          .data?[i]
                                                          .ratingStarCount,
                                                  flashSale:
                                                      productDetailsController
                                                          .relatedProductModel
                                                          .value
                                                          .data![i]
                                                          .flashSale!,
                                                  isOffer:
                                                      productDetailsController
                                                          .relatedProductModel
                                                          .value
                                                          .data![i]
                                                          .isOffer!,
                                                  offer_end_date:
                                                      productDetailsController
                                                          .relatedProductModel
                                                          .value
                                                          .data![i]
                                                          .offer_end_date,
                                                ),
                                              SizedBox(height: 12.h),
                                            ],
                                          ),
                                        ],
                                      ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
