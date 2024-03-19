import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopperz/app/modules/profile/controller/profile_controller.dart';
import 'package:shopperz/app/modules/shipping/controller/address_controller.dart';
import 'package:shopperz/config/theme/app_color.dart';
import 'package:shopperz/utils/images.dart';
import 'package:shopperz/widgets/loader/loader.dart';

// ignore: must_be_immutable
class AddressDeleteWidget extends StatefulWidget {
  AddressDeleteWidget({super.key, this.id});
  String? id;

  @override
  State<AddressDeleteWidget> createState() => _AddressDeleteWidgetState();
}

class _AddressDeleteWidgetState extends State<AddressDeleteWidget> {

  AddressController addressController = Get.put(AddressController());
  ProfileController profile = Get.put(ProfileController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 275.h,
          width: 328.w,
          decoration: BoxDecoration(
            color: AppColor.whiteColor,
            borderRadius: BorderRadius.circular(16.r)
          ),
          child: Padding(
            padding: EdgeInsets.all(16.sp),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Are you sure you want to delete?'.tr,
                style: GoogleFonts.urbanist(
                  color: AppColor.textColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700
                ),
                ),
                Image.asset(AppImages.deleteIcon,height: 120.h,width: 120.w,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        height: 48.h,
                        width: 140.w,
                        decoration: BoxDecoration(
                          color: AppColor.addressColor,
                          borderRadius: BorderRadius.circular(24.r),
                        ),
                        child: Center(
                          child: Text('Cancel'.tr,
                          style: GoogleFonts.urbanist(
                            color: AppColor.textColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700
                          ),),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        await addressController.deleletAddress(id: widget.id.toString());
                        profile.getAddress();
                      },
                      child: Container(
                        height: 48.h,
                        width: 140.w,
                        decoration: BoxDecoration(
                          color: AppColor.error,
                          borderRadius: BorderRadius.circular(24.r),
                        ),
                        child: Center(
                          child: Text('Delete'.tr,
                          style: GoogleFonts.urbanist(
                            color: AppColor.whiteColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700
                          ),),
                        ),
                      ),
                    ),
                    
                  ],
                )
              ],
            ),
          ),
        ),
        Obx(
          () => addressController.isLoading.value
              ? LoaderCircle()
              : SizedBox())
      ],
    );
  }
}