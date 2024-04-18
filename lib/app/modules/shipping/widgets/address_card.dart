import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopperz/app/modules/profile/widgets/address_delete_widget.dart';
import 'package:shopperz/app/modules/profile/widgets/edit_address.dart';
import 'package:shopperz/app/modules/shipping/controller/address_controller.dart';
import 'package:shopperz/config/theme/app_color.dart';
import 'package:shopperz/data/model/profile_address_model.dart';
import 'package:shopperz/utils/svg_icon.dart';
import 'package:shopperz/widgets/textwidget.dart';

class AddressCard extends StatefulWidget {
  const AddressCard({super.key, required this.address});
  final AddressModel? address;

  @override
  State<AddressCard> createState() => _AddressCardState();
}

class _AddressCardState extends State<AddressCard> {
  AddressController addressController = Get.put(AddressController());
  String address = '';
  String floor = '';
  @override
  void initState() {
    floor = addressController.getFloorSuffix(widget.address!.floor_no!);
    address =
        '${widget.address!.house_no.toString() != '' ? 'House No: ${widget.address!.house_no}, ' : ''} ${widget.address!.floor_no.toString() != '' ? 'Floor No: ${widget.address!.floor_no}$floor, ' : ''} ${widget.address!.address.toString() != '' ? '${widget.address!.address}, ' : ''}${widget.address!.city.toString() != '' ? '${widget.address!.city}, ' : ''} ${widget.address!.state.toString() != '' ? '${widget.address!.state}, ' : ''} ${widget.address!.country.toString() != '' ? '${widget.address!.country}, ' : ''} ${widget.address!.zipCode.toString() != '' ? 'ZipCode: ${widget.address!.zipCode}, ' : ''}'
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
        house_no: widget.address!.house_no.toString(),
        floor_no: widget.address!.floor_no.toString(),
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
              color: AppColor.whiteColor,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                    color: AppColor.blackColor.withOpacity(0.05),
                    offset: const Offset(0, 0),
                    blurRadius: 10.r)
              ]),
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
                  text: widget.address!.countryCode.toString() +
                      widget.address!.phone.toString(),
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
                  maxLines: 3,
                  overflow: TextOverflow.clip,
                ),
                // SizedBox(
                //   height: 8.h,
                // ),
                // TextWidget(
                //   text: widget.address!.address.toString(),
                //   color: AppColor.textColor,
                //   fontSize: 12.sp,
                //   fontWeight: FontWeight.w400,
                // ),
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
