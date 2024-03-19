import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shopperz/app/modules/category/model/category_tree.dart';
import 'package:shopperz/app/modules/category/views/category_wise_product_screen.dart';
import 'package:shopperz/app/modules/category/widgets/category_widget.dart';
import 'package:shopperz/app/modules/sub_category/views/sub_sub_category_screen.dart';
import 'package:shopperz/utils/images.dart';
import 'package:shopperz/widgets/appbar3.dart';

class SubCategoryScreen extends StatefulWidget {
  const SubCategoryScreen({super.key, this.categoryTreeModel});
  final CategoryTreeModel? categoryTreeModel;

  @override
  State<SubCategoryScreen> createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value:const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        appBar: AppBarWidget3(
          text: widget.categoryTreeModel!.name,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 16.w, top: 16.h, right: 16.w),
            child: Column(
              children: [
                widget.categoryTreeModel!.children!.isEmpty ?
                Center(
                      child: Padding(
                            padding: EdgeInsets.only(top: 120.h),
                            child: Center(
                                  child: Image.asset(AppImages.emptyIcon,height: 300.h,width: 300.w,),
                                ),
                          )
                    ):
                ListView.builder(
                  itemCount: widget.categoryTreeModel!.children!.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    var data = widget.categoryTreeModel!.children![index];
                    return CategoryList(
                            text: data.name.toString(),
                            onTapProduct: () {
                              Get.to(() => CategoryWiseProductScreen(
                                  categoryTreeModel: data));
                            },
                            onTapSubCategory: () {
                              Get.to(() => SubSubCategoryScreen(
                                  categoryTreeModel: data));
                            },
                          );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
