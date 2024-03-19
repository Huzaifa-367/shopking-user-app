import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:shopperz/app/modules/auth/views/sign_in.dart';
import 'package:shopperz/app/modules/home/widgets/appbar.dart';
import 'package:shopperz/app/modules/product/widgets/product.dart';
import 'package:shopperz/app/modules/product_details/views/product_details.dart';
import 'package:shopperz/app/modules/wishlist/controller/wishlist_controller.dart';
import 'package:shopperz/main.dart';
import 'package:shopperz/utils/images.dart';
import 'package:shopperz/widgets/textwidget.dart';
import '../../../../config/theme/app_color.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final wishlistController = Get.find<WishlistController>();
  @override
  void initState() {
    wishlistController.fetchFavorite();
    super.initState();
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
        backgroundColor: AppColor.primaryBackgroundColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(48.h),
          child: const AppBarWidget(),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 16.h, left: 16.w, right: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                text: 'WISHLIST'.tr,
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
                      '(${wishlistController.favoriteModel.value.data?.length ?? 0} ${' Products Found'.tr})',
                  color: AppColor.textColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
              Expanded(
                child: RefreshIndicator(
                  color: AppColor.primaryColor,
                  onRefresh: () async {
                    wishlistController.fetchFavorite();
                  },
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        Obx(() {
                          return wishlistController.favoriteModel.value.data ==
                                      null ||
                                  wishlistController
                                      .favoriteModel.value.data!.isEmpty
                              ? Padding(
                                  padding: EdgeInsets.only(top: 100.h),
                                  child: Center(
                                    child: Image.asset(
                                      AppImages.emptyIcon,
                                      height: 300.h,
                                      width: 300.w,
                                    ),
                                  ),
                                )
                              : Obx(
                                  () => StaggeredGrid.count(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 10.h,
                                    crossAxisSpacing: 10.w,
                                    children: [
                                      for (var i = 0;
                                          i <
                                              wishlistController.favoriteModel
                                                  .value.data!.length;
                                          i++)
                                        InkWell(
                                          onTap: () {
                                            Get.to(() => ProductDetailsScreen(
                                                favoriteItem: wishlistController
                                                    .favoriteModel
                                                    .value
                                                    .data![i]));
                                          },
                                          child: Obx(
                                            () => ProductWidget(
                                              favTap: () async {
                                                if (box.read('isLogedIn') !=
                                                    false) {
                                                  if (wishlistController
                                                          .favoriteModel
                                                          .value
                                                          .data![i]
                                                          .wishlist ==
                                                      true) {
                                                    await wishlistController
                                                        .toggleFavoriteFalse(
                                                            wishlistController
                                                                .favoriteModel
                                                                .value
                                                                .data![i]
                                                                .id!);

                                                    wishlistController
                                                        .showFavorite(
                                                            wishlistController
                                                                .favoriteModel
                                                                .value
                                                                .data![i]
                                                                .id!);
                                                  }
                                                  if (wishlistController
                                                          .favoriteModel
                                                          .value
                                                          .data![i]
                                                          .wishlist ==
                                                      false) {
                                                    await wishlistController
                                                        .toggleFavoriteTrue(
                                                            wishlistController
                                                                .favoriteModel
                                                                .value
                                                                .data![i]
                                                                .id!);

                                                    wishlistController
                                                        .showFavorite(
                                                            wishlistController
                                                                .favoriteModel
                                                                .value
                                                                .data![i]
                                                                .id!);
                                                  }
                                                } else {
                                                  Get.to(() =>
                                                      const SignInScreen());
                                                }

                                                await wishlistController
                                                    .fetchFavorite();
                                              },
                                              wishlist: wishlistController
                                                          .favList
                                                          .contains(
                                                              wishlistController
                                                                  .favoriteModel
                                                                  .value
                                                                  .data![i]
                                                                  .id) ||
                                                      wishlistController
                                                              .favoriteModel
                                                              .value
                                                              .data?[i]
                                                              .wishlist ==
                                                          true
                                                  ? true
                                                  : false,
                                              productImage: wishlistController
                                                  .favoriteModel
                                                  .value
                                                  .data?[i]
                                                  .cover,
                                              title: wishlistController
                                                  .favoriteModel
                                                  .value
                                                  .data?[i]
                                                  .name,
                                              rating: wishlistController
                                                  .favoriteModel
                                                  .value
                                                  .data?[i]
                                                  .ratingStar,
                                              flashSale: wishlistController
                                                  .favoriteModel
                                                  .value
                                                  .data![i]
                                                  .flashSale!,
                                              isOffer: wishlistController
                                                  .favoriteModel
                                                  .value
                                                  .data![i]
                                                  .isOffer!,
                                              currentPrice: wishlistController
                                                  .favoriteModel
                                                  .value
                                                  .data?[i]
                                                  .currencyPrice,
                                              discountPrice: wishlistController
                                                  .favoriteModel
                                                  .value
                                                  .data?[i]
                                                  .discountedPrice,
                                              textRating: wishlistController
                                                  .favoriteModel
                                                  .value
                                                  .data?[i]
                                                  .ratingStarCount,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                );
                        }),
                        SizedBox(
                          height: 100.h,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
