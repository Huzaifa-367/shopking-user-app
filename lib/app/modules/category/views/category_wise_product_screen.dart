import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopperz/app/modules/auth/views/sign_in.dart';
import 'package:shopperz/app/modules/category/model/category_tree.dart';
import 'package:shopperz/app/modules/filter/controller/filter_controller.dart';
import 'package:shopperz/app/modules/home/model/category_model.dart';
import 'package:shopperz/app/modules/search/controller/search_controller.dart';
import 'package:shopperz/app/modules/wishlist/controller/wishlist_controller.dart';
import 'package:shopperz/app/modules/product_details/views/product_details.dart';
import 'package:shopperz/main.dart';
import 'package:shopperz/utils/images.dart';
import 'package:shopperz/widgets/appbar4.dart';
import 'package:shopperz/widgets/shimmer/product_shimmer.dart';
import 'package:shopperz/widgets/shimmer/trendy_collections_shimmer.dart';
import '../../../../config/theme/app_color.dart';
import '../../../../utils/svg_icon.dart';
import '../../../../widgets/textwidget.dart';
import '../../filter/views/filter_screen.dart';
import '../../product/widgets/product.dart';
import '../controller/category_wise_product_controller.dart';

class CategoryWiseProductScreen extends StatefulWidget {
  const CategoryWiseProductScreen(
      {super.key, this.categoryTreeModel, this.categoryModel, this.brandName});

  final CategoryTreeModel? categoryTreeModel;
  final Datum? categoryModel;
  final String? brandName;
  final int index = -1;
  final int length = 0;

  @override
  State<CategoryWiseProductScreen> createState() =>
      _CategoryWiseProductScreenState();
}

class _CategoryWiseProductScreenState extends State<CategoryWiseProductScreen> {
  final filterController = Get.put(FilterController());
  final productSearchController = Get.put(ProductSearchController());
  final cateWiseProductController = Get.put(CategoryWiseProductController());
  @override
  void initState() {
    cateWiseProductController.resetState();
    cateWiseProductController.loadMoreData(
        categorySlug:
            widget.categoryTreeModel?.slug ?? widget.categoryModel?.slug ?? "");

    super.initState();
  }

  @override
  void dispose() {
    filterController.resetFilter();
    cateWiseProductController.resetState();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cateWiseProductController = Get.find<CategoryWiseProductController>();
    final wishlistController = Get.find<WishlistController>();
    final filterController = Get.put(FilterController());

    if (filterController.homeBrands == null) {
      cateWiseProductController.resetState();
      cateWiseProductController.fetchCategoryWiseProduct(
        categorySlug:
            widget.categoryTreeModel?.slug ?? widget.categoryModel?.slug ?? '',
        sortBy: filterController.selectedOption.value.trim(),
        brands: filterController.brands,
        variatons: filterController.encodeVaritionObject,
        name: productSearchController.searchTextController.text.toString(),
      );
    } else {
      cateWiseProductController.resetState();
      cateWiseProductController.fetchCategoryWiseProduct(
          categorySlug: widget.categoryTreeModel?.slug ??
              widget.categoryModel?.slug ??
              '',
          sortBy: filterController.selectedOption.value.trim(),
          brands: filterController.homeBrands,
          variatons: filterController.encodeVaritionObject,
          name: productSearchController.searchTextController.text.toString());
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBarWidget4(text: ''),
        body: Column(
          children: [
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: widget.categoryModel?.name ??
                            widget.categoryTreeModel?.name.toString().tr ??
                            widget.brandName ??
                            'Search Results'.tr,
                        color: AppColor.textColor,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Obx(
                        () => Row(
                          children: [
                            TextWidget(
                              text:
                                  '(${cateWiseProductController.categoryWiseProductList.length} Products Found)',
                              color: AppColor.textColor,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => FilterScreen(
                                cateWiseProductModel: cateWiseProductController
                                    .categoryWiseProductModel.value.data,
                              ))!
                          .then((value) {
                        setState(() {});
                      });
                    },
                    child: SvgPicture.asset(
                      SvgIcon.filter,
                      height: 24.h,
                      width: 24.w,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                color: AppColor.primaryColor,
                onRefresh: () async {
                  if (filterController.homeBrands == null) {
                    cateWiseProductController.resetState();
                    cateWiseProductController.fetchCategoryWiseProduct(
                      categorySlug: widget.categoryTreeModel?.slug ??
                          widget.categoryModel?.slug ??
                          '',
                      sortBy: filterController.selectedOption.value.trim(),
                      brands: filterController.brands,
                      variatons: filterController.encodeVaritionObject,
                      name: productSearchController.searchTextController.text
                          .toString(),
                    );
                  } else {
                    cateWiseProductController.resetState();
                    cateWiseProductController.fetchCategoryWiseProduct(
                        categorySlug: widget.categoryTreeModel?.slug ??
                            widget.categoryModel?.slug ??
                            '',
                        sortBy: filterController.selectedOption.value.trim(),
                        brands: filterController.homeBrands,
                        variatons: filterController.encodeVaritionObject,
                        name: productSearchController.searchTextController.text
                            .toString());
                  }
                },
                child: Obx(
                  () => cateWiseProductController
                          .categoryWiseProductList.isNotEmpty
                      ? Padding(
                          padding: EdgeInsets.all(16.r),
                          child: ProductShimmer(
                            count: 6,
                          ),
                        )
                      : cateWiseProductController
                              .categoryWiseProductList.isEmpty
                          ? Center(
                              child: Padding(
                              padding: EdgeInsets.only(top: 120.h),
                              child: Center(
                                child: Image.asset(
                                  AppImages.emptyIcon,
                                  height: 300.h,
                                  width: 300.w,
                                ),
                              ),
                            ))
                          : Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 16.h),
                              child: MasonryGridView.count(
                                  controller: cateWiseProductController
                                      .scrollController,
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10.h,
                                  crossAxisSpacing: 10.w,
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: cateWiseProductController
                                          .categoryWiseProductList.length +
                                      (cateWiseProductController.hasMoreData ==
                                              true
                                          ? 1
                                          : 0),
                                  itemBuilder: (context, i) {
                                    if (i ==
                                        cateWiseProductController
                                            .categoryWiseProductList.length) {
                                      return const SizedBox.shrink();
                                      // return ProductShimmer(
                                      //   count: 6,
                                      // );
                                    }
                                    return GestureDetector(
                                      onTap: () {
                                        Get.to(() => ProductDetailsScreen(
                                            categoryWiseProduct:
                                                cateWiseProductController
                                                        .categoryWiseProductList[
                                                    i]));
                                      },
                                      child: Obx(
                                        () => ProductWidget(
                                          favTap: () async {
                                            if (box.read('isLogedIn') !=
                                                false) {
                                              if (cateWiseProductController
                                                      .categoryWiseProductList[
                                                          i]
                                                      .wishlist ==
                                                  true) {
                                                await wishlistController
                                                    .toggleFavoriteFalse(
                                                        cateWiseProductController
                                                            .categoryWiseProductList[
                                                                i]
                                                            .id!);

                                                wishlistController.showFavorite(
                                                    cateWiseProductController
                                                        .categoryWiseProductList[
                                                            i]
                                                        .id!);
                                              }
                                              if (cateWiseProductController
                                                      .categoryWiseProductList[
                                                          i]
                                                      .wishlist ==
                                                  false) {
                                                await wishlistController
                                                    .toggleFavoriteTrue(
                                                        cateWiseProductController
                                                            .categoryWiseProductList[
                                                                i]
                                                            .id!);

                                                wishlistController.showFavorite(
                                                    cateWiseProductController
                                                        .categoryWiseProductList[
                                                            i]
                                                        .id!);
                                              }
                                            } else {
                                              Get.to(
                                                  () => const SignInScreen());
                                            }
                                          },
                                          wishlist: wishlistController.favList
                                                      .contains(
                                                          cateWiseProductController
                                                              .categoryWiseProductList[
                                                                  i]
                                                              .id!) ||
                                                  cateWiseProductController
                                                          .categoryWiseProductList[
                                                              i]
                                                          .wishlist ==
                                                      true
                                              ? true
                                              : false,
                                          productImage:
                                              cateWiseProductController
                                                  .categoryWiseProductList[i]
                                                  .cover
                                                  .toString(),
                                          title: cateWiseProductController
                                              .categoryWiseProductList[i].name,
                                          currentPrice:
                                              cateWiseProductController
                                                  .categoryWiseProductList[i]
                                                  .currencyPrice,
                                          discountPrice:
                                              cateWiseProductController
                                                  .categoryWiseProductList[i]
                                                  .discountedPrice,
                                          rating: cateWiseProductController
                                              .categoryWiseProductList[i]
                                              .ratingStar,
                                          textRating: cateWiseProductController
                                              .categoryWiseProductList[i]
                                              .ratingStarCount,
                                          flashSale: cateWiseProductController
                                              .categoryWiseProductList[i]
                                              .flashSale!,
                                          isOffer: cateWiseProductController
                                              .categoryWiseProductList[i]
                                              .isOffer!,
                                        ),
                                      ),
                                    );
                                  })),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
