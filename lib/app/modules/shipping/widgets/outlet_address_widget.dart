import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopperz/app/modules/profile/widgets/address_delete_widget.dart';
import 'package:shopperz/app/modules/profile/widgets/edit_address.dart';
import 'package:shopperz/app/modules/shipping/controller/address_controller.dart';
import 'package:shopperz/app/modules/shipping/model/outlet_model.dart';
import 'package:shopperz/config/theme/app_color.dart';
import 'package:shopperz/data/model/profile_address_model.dart';
import 'package:shopperz/utils/svg_icon.dart';
import 'package:shopperz/widgets/textwidget.dart';

class OutletAddressWidget extends StatefulWidget {
  const OutletAddressWidget({super.key, required this.address});
  final outletModel? address;

  @override
  State<OutletAddressWidget> createState() => _OutletAddressWidgetState();
}

class _OutletAddressWidgetState extends State<OutletAddressWidget> {
  AddressController addressController = Get.put(AddressController());
  String address = '';
  String floor = '';
  @override
  void initState() {
    address =
        '${widget.address!.address.toString() != '' ? '${widget.address!.address}, ' : ''}${widget.address!.city.toString() != '' ? '${widget.address!.city}, ' : ''} ${widget.address!.state.toString() != '' ? '${widget.address!.state}, ' : ''} ${widget.address!.zipCode.toString() != '' ? 'ZipCode: ${widget.address!.zipCode}, ' : ''}'
            .replaceAll('', '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: 230,
          child: Padding(
            padding: EdgeInsets.all(2.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(
                  text: widget.address!.name.toString(),
                  color: AppColor.textColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
                TextWidget(
                  text: widget.address!.countryCode.toString() +
                      widget.address!.phone.toString(),
                  color: AppColor.textColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
                widget.address!.email.toString() == ''
                    ? const SizedBox.shrink()
                    : TextWidget(
                        text: widget.address!.email.toString(),
                        color: AppColor.textColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
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
              ],
            ),
          ),
        ),
      ],
    );
  }
}
