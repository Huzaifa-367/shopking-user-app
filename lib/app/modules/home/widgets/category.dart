import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shopperz/app/modules/category/views/category_wise_product_screen.dart';
import 'package:shopperz/app/modules/home/controller/category_controller.dart';
import 'package:shopperz/widgets/textwidget.dart';
import '../../../../config/theme/app_color.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.find<CategoryController>();

    return Container(
      height: 120.h,
      width: double.infinity,
      color: AppColor.whiteColor, // white hobe
      child: Obx(() {
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: categoryController.categoryModel.value.data!.length,
          itemBuilder: (context, index) {
            final category = categoryController.categoryModel.value.data!;
            return Center(
              child: Padding(
                padding: EdgeInsets.only(right: 12.w),
                child: InkWell(
                  onTap: () {
                    Get.to(
                      () => CategoryWiseProductScreen(
                          categoryModel: category[index]),
                    );
                  },
                  child: Container(
                    height: 85.h,
                    width: 72.w,
                    decoration: BoxDecoration(
                      color: AppColor.whiteColor,
                      borderRadius: BorderRadius.circular(8.r),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            offset: const Offset(0, 0),
                            blurRadius: 32.r,
                            spreadRadius: 0)
                      ],
                    ),
                    child: Column(
                      children: [
                        CachedNetworkImage(
                          imageUrl: category[index].thumb.toString(),
                          imageBuilder: (context, imageProvider) => Container(
                            height: 50.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8.r),
                                  topRight: Radius.circular(8.r)),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          placeholder: (context, imageProvider) => Container(
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
                                image: AssetImage("assets/images/empty.gif"),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 22.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppColor.whiteColor,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(8.r),
                                bottomRight: Radius.circular(8.r),
                              ),
                            ),
                            child: Center(
                              child: TextWidget(
                                text: category[index].name,
                                textAlign: TextAlign.center,
                                color: AppColor.titleTextColor,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
