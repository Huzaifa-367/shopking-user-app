// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shopperz/app/modules/home/controller/promotion_controller.dart';
import 'package:shopperz/widgets/shimmer/promotion_banner_shimmer.dart';

class PromotionBanner extends StatelessWidget {
  const PromotionBanner({
    super.key,
    this.image,
    this.width,
    this.pIndex,
  });

  final String? image;
  final double? width;
  final int? pIndex;
  @override
  Widget build(BuildContext context) {
    final promotionController = Get.put(PromotionalController());

    return Obx(() {
      return promotionController.isLoading.value
          ? Padding(
              padding: EdgeInsets.only(top: 24.h),
              child: SizedBox(
                  height: 142.h,
                  child: PromotionBannerShimmer(
                    width: 280.w,
                  )),
            )
          : promotionController.promotionModel.value.data?.isNotEmpty ?? false
              ? Padding(
                  padding: EdgeInsets.only(top: 16.h),
                  child: SizedBox(
                    height: 142.h,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          promotionController.promotionModel.value.data!.length,
                      itemBuilder: (context, index) {
                        final promotion =
                            promotionController.promotionModel.value.data;
                        return Padding(
                          padding: EdgeInsets.only(right: 16.w),
                          child: Container(
                            width:
                                promotion![index].status == 10 ? 280.w : 240.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.r),
                              child: Image.network(
                                promotion[index].cover.toString(),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )
              : const SizedBox();
    });
  }
}
