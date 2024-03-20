import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopperz/app/modules/home/controller/all_flash_controller.dart';
import 'package:shopperz/app/modules/home/controller/all_popular_controller.dart';
import 'package:shopperz/app/modules/home/controller/popular_product_controller.dart';
import 'package:shopperz/app/modules/home/model/popular_product.dart';
import 'package:shopperz/app/modules/product/widgets/product.dart';
import 'package:shopperz/app/modules/wishlist/controller/wishlist_controller.dart';
import 'package:shopperz/widgets/appbar2.dart';
import 'package:shopperz/widgets/shimmer/product_shimmer.dart';
import 'package:shopperz/widgets/textwidget.dart';
import '../../../../config/theme/app_color.dart';
import '../../product_details/views/product_details.dart';

class ProductlistScreen extends StatefulWidget {
  const ProductlistScreen(
      {super.key, this.product, this.title, required this.id});

  final PopularProduct? product;
  final String? title;
  final int id;

  @override
  State<ProductlistScreen> createState() => _ProductlistScreenState();
}

class _ProductlistScreenState extends State<ProductlistScreen> {
  final allPopularController = Get.put(AllPopularControler());
  final allFlashController = Get.put(AllFlashController());
  final wishListController = Get.find<WishlistController>();
  @override
  void initState() {
    widget.id == 5
        ? allPopularController.loadMoreData()
        : allFlashController.loadMoreData();
    super.initState();
  }

  @override
  void dispose() {
    allPopularController.resetState();
    allFlashController.resetState();
    super.dispose();
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
      child: GetBuilder<PopularProductController>(
        builder: (popularProductController) => Scaffold(
          backgroundColor: AppColor.primaryBackgroundColor,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(48.h),
            child: const AppBarWidget2(),
          ),
          body: Padding(
            padding: EdgeInsets.only(top: 16.h, left: 16.w, right: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          text: widget.title,
                          color: AppColor.textColor,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Obx(
                          () => TextWidget(
                            text:
                                '(${widget.id == 5 ? allPopularController.popularList.length : allFlashController.flashSaleList.length} ${'Products Found'.tr})',
                            color: AppColor.textColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
                Expanded(
                  child: Obx(
                    () => MasonryGridView.count(
                        controller: widget.id == 5
                            ? allPopularController.scrollController
                            : allFlashController.scrollController,
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        mainAxisSpacing: 10.h,
                        crossAxisSpacing: 10.w,
                        itemCount: widget.id == 5
                            ? (allPopularController.popularList.length +
                                (allPopularController.hasMoreData == true
                                    ? 1
                                    : 0))
                            : (allFlashController.flashSaleList.length +
                                (allFlashController.hasMoreData == true
                                    ? 1
                                    : 0)),
                        itemBuilder: (context, index) {
                          final productListLength = widget.id == 5
                              ? allPopularController.popularList.length
                              : allFlashController.flashSaleList.length;

                          final productList = widget.id == 5
                              ? allPopularController.popularList
                              : allFlashController.flashSaleList;
                          if (index == productListLength) {
                            return const SizedBox.shrink();
                            // ProductShimmer(
                            //   count: 1,
                            //   onlyContainer: true,
                            // );
                          }

                          return Obx(
                            () => ProductWidget(
                              onTap: () {
                                Get.to(
                                  () => ProductDetailsScreen(
                                    product: productList[index],
                                  ),
                                );
                              },
                              wishlist: wishListController.favList
                                          .contains(productList[index].id!) ||
                                      productList[index].wishlist == true
                                  ? true
                                  : false,
                              favTap: () async {
                                if (productList[index].wishlist == true) {
                                  await wishListController.toggleFavoriteFalse(
                                      productList[index].id!);

                                  wishListController
                                      .showFavorite(productList[index].id!);
                                }
                                if (productList[index].wishlist == false) {
                                  await wishListController.toggleFavoriteTrue(
                                      productList[index].id!);

                                  wishListController
                                      .showFavorite(productList[index].id!);
                                }
                              },
                              productImage: productList[index].cover,
                              title: productList[index].name,
                              rating: productList[index].ratingStar,
                              currentPrice: productList[index].currencyPrice,
                              discountPrice: productList[index].discountedPrice,
                              textRating: productList[index].ratingStarCount,
                              flashSale: productList[index].flashSale,
                              isOffer: productList[index].isOffer,
                            ),
                          );
                        }),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
