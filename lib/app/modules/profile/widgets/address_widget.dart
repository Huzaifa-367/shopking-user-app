import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopperz/app/modules/profile/widgets/address_delete_widget.dart';
import 'package:shopperz/app/modules/profile/widgets/edit_address.dart';
import 'package:shopperz/config/theme/app_color.dart';
import 'package:shopperz/data/model/profile_address_model.dart';
import 'package:shopperz/utils/svg_icon.dart';
import 'package:shopperz/widgets/textwidget.dart';

class AddressWidget extends StatefulWidget {
  const AddressWidget({super.key, this.address});
  final Data? address;

  @override
  State<AddressWidget> createState() => _AddressWidgetState();
}

class _AddressWidgetState extends State<AddressWidget> {
  String address = '';

  @override
  void initState() {
    address =
        '${widget.address!.city.toString() != '' ? widget.address!.city.toString() + ', ' : ''} ${widget.address!.state.toString() != '' ? widget.address!.state.toString() + ', ' : ''} ${widget.address!.country.toString() != '' ? widget.address!.country.toString() + ', ' : ''} ${widget.address!.zipCode.toString() != '' ? widget.address!.zipCode.toString() : ''}'
            .replaceAll('', '');
    super.initState();
  }

  openEditAddressDialog() {
    Get.dialog(Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.only(top: 20.h, bottom: 20.h),
      child: EditAddressDialog(
        id: widget.address!.id.toString(),
        name: widget.address!.fullName.toString(),
        email: widget.address!.email.toString(),
        country: widget.address!.country.toString(),
        address: widget.address!.address.toString(),
        city: widget.address!.city.toString(),
        country_code: widget.address!.countryCode.toString(),
        phone: widget.address!.phone.toString(),
        state: widget.address!.state.toString(),
        zip: widget.address!.zipCode.toString(),
      ),
    ));
  }

  openDeleteAddressDialog() {
    Get.dialog(Dialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent, 
      child: AddressDeleteWidget(id: widget.address!.id.toString()),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 328.w,
          decoration: BoxDecoration(
            color: AppColor.addressColor,
            borderRadius: BorderRadius.circular(12.r), 
          ),
          child: Padding(
            padding: EdgeInsets.all(12.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(
                  text: widget.address!.fullName.toString(),
                  color: AppColor.textColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(
                  height: 8.h,
                ),
                TextWidget(
                  text:
                      '${widget.address!.countryCode.toString() + widget.address!.phone.toString()}',
                  color: AppColor.textColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(
                  height: widget.address!.email.toString() == '' ? 0.h : 8.h,
                ),
                widget.address!.email.toString() == ''
                    ? Container()
                    : TextWidget(
                        text: widget.address!.email.toString(),
                        color: AppColor.textColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  address,
                  style: GoogleFonts.urbanist(
                    color: AppColor.textColor,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.clip,
                ),
                SizedBox(
                  height: 8.h,
                ),
                TextWidget(
                  text: widget.address!.address.toString(),
                  color: AppColor.textColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 12.h,
          right: 12.w,
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  openEditAddressDialog();
                },
                child: Container(
                  height: 24.r,
                  width: 24.r,
                  decoration: BoxDecoration(
                      color: AppColor.activeColor,
                      borderRadius: BorderRadius.circular(24.r)),
                  child: Center(
                    child: SvgPicture.asset(
                      SvgIcon.menuEdit,
                      height: 12.h,
                      width: 12.w,
                      color: AppColor.whiteColor,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 8.w,
              ),
              InkWell(
                onTap: () {
                  openDeleteAddressDialog();
                },
                child: Container(
                  height: 24.r,
                  width: 24.r,
                  decoration: BoxDecoration(
                      color: AppColor.error,
                      borderRadius: BorderRadius.circular(24.r)),
                  child: Center(
                    child: SvgPicture.asset(
                      SvgIcon.delete,
                      height: 12.h,
                      width: 12.w,
                      color: AppColor.whiteColor,
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
