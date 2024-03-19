import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../config/theme/app_color.dart';
import '../controller/slider_controller.dart';

class SliderWidget extends StatelessWidget {
  const SliderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final sliderController = Get.find<SliderController>();

    return Container(
      height: 142.h,
      width: 328.w,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r)),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Obx(() {
            return CarouselSlider.builder(
              itemCount: sliderController.sliderData.value.data!.length,
              itemBuilder: (context, index, _) {
                final data = sliderController.sliderData.value.data!;
                return CachedNetworkImage(
                  imageUrl: data[index].image.toString(),
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.fill),
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                height: 142.h,
                viewportFraction: 1,
                autoPlay: true,
                enlargeCenterPage: true,
                disableCenter: true,
                onPageChanged: (index, reason) {
                  sliderController.handleSliderDots(index);
                },
              ),
            );
          }),
          Positioned(
            bottom: 10,
            child: Obx(() {
              return DotsIndicator(
                dotsCount: sliderController.sliderData.value.data!.length,
                position: sliderController.dotIndex.value,
                decorator: DotsDecorator(
                  spacing: EdgeInsets.only(left: 5.w),
                  shape: const CircleBorder(
                      side: BorderSide(color: AppColor.primaryColor),
                      eccentricity: 0.8),
                  color: Colors.transparent,
                  activeColor: AppColor.primaryColor,
                ),
              );
            }),
          )
        ],
      ),
    );
  }
}
