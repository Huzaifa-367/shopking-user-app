// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopperz/config/theme/app_color.dart';

class ProductShimmer extends StatelessWidget {
  int count;
  bool? isListView;
  bool? onlyContainer;
  ProductShimmer({
    super.key,
    this.count = 4,
    this.isListView = false,
    this.onlyContainer = false,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: !isListView!
          ? Column(
              children: [
                if (!onlyContainer!) ...{
                  Padding(
                    padding: EdgeInsets.only(top: 24.h, bottom: 13.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Shimmer.fromColors(
                          baseColor: Colors.grey[200]!,
                          highlightColor: Colors.grey[300]!,
                          child: Container(
                            height: 30.h,
                            width: 100.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.r),
                                color: Colors.white),
                          ),
                        ),
                        Row(
                          children: [
                            Shimmer.fromColors(
                              baseColor: Colors.grey[200]!,
                              highlightColor: Colors.grey[300]!,
                              child: Container(
                                height: 30.h,
                                width: 70.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16.r),
                                    color: Colors.white),
                              ),
                            ),
                            SizedBox(width: 16.w),
                          ],
                        )
                      ],
                    ),
                  ),
                },
                SizedBox(
                  height: 580.h,
                  child: GridView.builder(
                    // primary: false,
                    scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: count == 1 ? 1 : 2,
                      childAspectRatio: 1 / 1.565,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: count,
                    itemBuilder: (BuildContext ctx, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 5, top: 5),
                        child: Container(
                          height: 100.h,
                          width: 156.w,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            color: Colors.white,
                            border: Border.all(
                              color: AppColor.borderColor,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    child: Container(
                                      height: 140,
                                      width: 140,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Shimmer.fromColors(
                                          baseColor: Colors.grey[400]!,
                                          highlightColor: Colors.grey[100]!,
                                          child: Container(
                                            height: 17,
                                            width: 60,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                            width:
                                                5), // Adjust spacing as needed
                                        Shimmer.fromColors(
                                          baseColor: Colors.grey[400]!,
                                          highlightColor: Colors.grey[100]!,
                                          child: Container(
                                            height: 17,
                                            width: 20,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 10),
                              Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  height: 15,
                                  width: 136,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16.r),
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                  height: 5), // Adjust spacing as needed
                              Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  height: 10,
                                  width: 90,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r),
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  height: 10,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r),
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    child: Container(
                                      height: 20,
                                      width: 60,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                      width: 5), // Adjust spacing as needed
                                  Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    child: Container(
                                      height: 20,
                                      width: 60,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            )
          : SizedBox(
              height: 300.h,
              child: ListView.builder(
                primary: false,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: count,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext ctx, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 5, top: 5),
                    child: Container(
                      height: 100.h,
                      width: 156.w,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: Colors.white,
                        border: Border.all(
                          color: AppColor.borderColor,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  height: 140,
                                  width: 140,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Shimmer.fromColors(
                                      baseColor: Colors.grey[400]!,
                                      highlightColor: Colors.grey[100]!,
                                      child: Container(
                                        height: 17,
                                        width: 60,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                        width: 5), // Adjust spacing as needed
                                    Shimmer.fromColors(
                                      baseColor: Colors.grey[400]!,
                                      highlightColor: Colors.grey[100]!,
                                      child: Container(
                                        height: 17,
                                        width: 20,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              height: 15,
                              width: 136,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.r),
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 5), // Adjust spacing as needed
                          Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              height: 10,
                              width: 90,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              height: 10,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  height: 20,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r),
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                  width: 5), // Adjust spacing as needed
                              Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  height: 20,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r),
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
