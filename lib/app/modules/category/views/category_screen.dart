import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shopperz/app/modules/category/controller/category_tree_controller.dart';
import 'package:shopperz/app/modules/category/views/category_wise_product_screen.dart';
import 'package:shopperz/app/modules/category/widgets/category_widget.dart';
import 'package:shopperz/app/modules/home/widgets/appbar.dart';
import 'package:shopperz/app/modules/sub_category/views/sub_category_screen.dart';
import 'package:shopperz/utils/images.dart';
import 'package:shopperz/widgets/loader/loader.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryTreeController = Get.put(CategoryTreeController());

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(48.h),
          child: const AppBarWidget(),
        ),
        body: Obx(
          () => Stack(
            alignment: Alignment.center,
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(top: 16.h, left: 16.w, right: 16.w),
                  child: Obx(() {
                    return categoryTreeController.categoryTreeList.isEmpty
                        ? SizedBox()
                        : categoryTreeController.categoryTreeList.length < 1
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
                            : ListView.builder(
                                itemCount: categoryTreeController
                                    .categoryTreeList.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final categoryTree =
                                      categoryTreeController.categoryTreeList;
                                  return CategoryList(
                                    text: categoryTree[index].name.toString(),
                                    onTapProduct: () {
                                      Get.to(() => CategoryWiseProductScreen(
                                          categoryTreeModel:
                                              categoryTree[index]));
                                    },
                                    onTapSubCategory: () {
                                      Get.to(() => SubCategoryScreen(
                                          categoryTreeModel:
                                              categoryTree[index]));
                                    },
                                  );
                                },
                              );
                  }),
                ),
              ),
              categoryTreeController.isLoading.value
                  ? const Center(child: LoaderCircle())
                  : SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
