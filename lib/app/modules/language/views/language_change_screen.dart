import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopperz/app/modules/language/controller/language_controller.dart';
import 'package:shopperz/config/theme/app_color.dart';
import 'package:shopperz/utils/svg_icon.dart';
import 'package:shopperz/widgets/appbar3.dart';
import 'package:shopperz/widgets/custom_text.dart';

// ignore: must_be_immutable
class ChangeLanguageView extends StatefulWidget {
  const ChangeLanguageView({super.key});

  @override
  State<ChangeLanguageView> createState() => _ChangeLanguageViewState();
}

class _ChangeLanguageViewState extends State<ChangeLanguageView> {
  final box = GetStorage();

  final bool isActive = true;

  LanguageController language = Get.put(LanguageController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    language.getLanguageData();
  }

  @override
  Widget build(BuildContext context) {
    LanguageController languageController = Get.put(LanguageController());

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value:const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
          backgroundColor: AppColor.primaryBackgroundColor,
          appBar: const AppBarWidget3(
            text: '',
          ),
          body: Padding(
            padding: EdgeInsets.only(
              top: 16.h,
              left: 16.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 16.w),
                      child: CustomText(
                        text: "CHANGE_LANGUAGE".tr,
                        size: 22.sp,
                        weight: FontWeight.w700,
                        color: AppColor.primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: languageController.languageDataList.length,
                  itemBuilder: (BuildContext context, index) {
                    return InkWell(
                      onTap: () {
                        languageController.changeLanguage(
                          languageController.languageDataList[index].code!,
                          languageController.languageDataList[index].name!,
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 10.h, right: 16.w),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            boxShadow: [
                              BoxShadow(
                                  color: AppColor.blackColor.withOpacity(0.10),
                                  offset: const Offset(0, 0.1),
                                  blurRadius: 1.r)
                            ],
                            color: box.read('languageCode') ==
                                    languageController
                                        .languageDataList[index].code!
                                ? AppColor.primaryColor.withOpacity(0.08)
                                : Colors.white,
                            border: box.read('languageCode') ==
                                    languageController
                                        .languageDataList[index].code!
                                ? Border.all(color: AppColor.primaryColor)
                                : Border.all(color: Colors.white),
                          ),
                          height: 56.h,
                          width: 328.w,
                          child: Row(children: [
                            SizedBox(width: 16.w),
                            SizedBox(
                              width: 24.w,
                              height: 24.h,
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.r)),
                                child: CachedNetworkImage(
                                  imageUrl: languageController
                                      .languageDataList[index].image!,
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  placeholder: (context, url) =>
                                    Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[400]!,
                                    child: Container(
                                        width: 24.w,
                                        height: 24.h,
                                        color: Colors.grey),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                            ),
                            SizedBox(width: 16.w),
                            CustomText(
                              text: languageController
                                  .languageDataList[index].name!,
                              size: 16.sp,
                              weight: FontWeight.w500,
                              color: AppColor.textColor,
                            ),
                            const Spacer(),
                            box.read('languageCode') ==
                                    languageController
                                        .languageDataList[index].code!
                                ? Padding(
                                    padding:
                                        EdgeInsets.only(right: 18.w, left: 18.w),
                                    child: SizedBox(
                                      width: 24.w,
                                      height: 24.h,
                                      child: SvgPicture.asset(
                                        SvgIcon.thikCircle,
                                        color: AppColor.primaryColor,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                          ]),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          )),
    );
  }
}
