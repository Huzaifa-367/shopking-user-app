import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopperz/app/modules/auth/controller/auth_controler.dart';
import 'package:shopperz/app/modules/auth/views/sign_in.dart';
import 'package:shopperz/app/modules/profile/controller/profile_controller.dart';
import 'package:shopperz/app/modules/shipping/controller/address_controller.dart';
import 'package:shopperz/app/modules/shipping/controller/show_address_controller.dart';
import 'package:shopperz/main.dart';
import 'package:shopperz/utils/svg_icon.dart';
import 'package:shopperz/utils/validation_rules.dart';
import 'package:shopperz/widgets/loader/loader.dart';
import '../../../../config/theme/app_color.dart';
import '../../../../widgets/custom_form_field.dart';
import '../../../../widgets/custom_phone_form_field.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/form_field_title.dart';
import '../../../../widgets/secondary_button2.dart';

// ignore: must_be_immutable
class EditAddressDialog extends StatefulWidget {
  EditAddressDialog({super.key,this.address,this.city,this.country,this.country_code,this.email,this.name,this.phone,this.state,this.zip, this.id});
  String? name, email, phone, country_code, country, state, city, zip, address, id; 

  @override
  State<EditAddressDialog> createState() => _EditAddressDialogState();
}

class _EditAddressDialogState extends State<EditAddressDialog> {
  AuthController auth = Get.put(AuthController());
  AddressController addressController = Get.put(AddressController());
  final showAddressController = Get.put(ShowAddressController());
  ProfileController profile = Get.put(ProfileController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auth.getSetting();
    auth.getCountryCode();

    addressController.nameTextController.text = widget.name.toString();
    addressController.emailTextController.text = widget.email.toString();
    addressController.phoneTextController.text = widget.phone.toString();
    addressController.country.value = widget.country.toString();
    addressController.city.value = widget.city.toString();
    addressController.state.value = widget.state.toString();
    addressController.zipTextController.text = widget.zip.toString();
    addressController.streetTextController.text = widget.address.toString();

    addressController.countryCode = widget.country_code.toString();

  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: Colors.green,
          ),
          width: 328.w,
          child: Material(
            borderRadius: BorderRadius.circular(12.r),
            child: Form(
              key: addressController.formkey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 16.h),
                        CustomText(
                          text: "Update Address".tr,
                          size: 22.sp,
                          weight: FontWeight.w700,
                        ),
                        SizedBox(height: 10.h),
                        FormFieldTitle(title: "Full Name".tr),
                        SizedBox(height: 4.h),
                        CustomFormField(
                          controller: addressController.nameTextController,
                          validator: (name) => ValidationRules().normal(name),
                        ),
                        SizedBox(height: 10.h),
                        FormFieldTitle(title: "Email".tr),
                        SizedBox(height: 4.h),
                        CustomFormField(
                          controller: addressController.emailTextController,
                        ),
                        SizedBox(height: 10.h),
                        FormFieldTitle(title: "Phone".tr),
                        SizedBox(height: 4.h),
                        CustomPhoneFormField(
                          phoneController: addressController.phoneTextController,
                          validator: (phone) => ValidationRules().normal(phone),
                          prefix: Padding(
                            padding:  EdgeInsets.only(left: 10.w),
                            child: PopupMenuButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.r),
                                  ),
                                ),
                                position: PopupMenuPosition.under,
                                itemBuilder: (ctx) => List.generate(
                                    auth.countryCodeModel!.data!.length,
                                    (index) => PopupMenuItem(
                                      height: 32.h,
                                          onTap: () async {
                                            setState(() {
                                              addressController.countryCode = auth.countryCodeModel!.data![index].callingCode.toString();
                                            });
                                          },
                                          child: Text(
                                            auth.countryCodeModel!.data![index].callingCode.toString(),
                                            style: GoogleFonts.urbanist(
                                                color: AppColor.textColor,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16.sp),
                                          ),
                                        )),
                              child: Row(
                                    children: [
                                      Text(
                                        addressController.countryCode,
                                        style: GoogleFonts.urbanist(
                                            color: AppColor.textColor,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w500
                                          ),
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      SvgPicture.asset(SvgIcon.down)
                                    ],
                                  ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        FormFieldTitle(title: "Address".tr),
                        SizedBox(height: 4.h),
                        
                        CSCPicker(
                          flagState: CountryFlag.DISABLE,
                          currentCity: addressController.city.value,
                          currentCountry: addressController.country.value,
                          currentState: addressController.state.value,
                          
                          countryDropdownLabel: addressController.country.value,
                          stateDropdownLabel: addressController.state.value,
                          cityDropdownLabel: addressController.city.value,
                          onCountryChanged: (country) {
                            
                            addressController.country.value = country;
                          },
                          onCityChanged: (city) {
                            addressController.city.value = city ?? "";
                          },
                          onStateChanged: (state) {
                            addressController.state.value = state ?? "";
                          },
                          selectedItemStyle:  GoogleFonts.urbanist(
                              color: AppColor.textColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 16.sp),
                        

                          dropdownDecoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8.r)),
                          color: AppColor.whiteColor,
                          border:
                          Border.all(color: AppColor.inactiveColor, width: 1.w)),

                          disabledDropdownDecoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8.r)),
                          color: AppColor.whiteColor,
                          border:
                          Border.all(color: AppColor.inactiveColor, width: 1.w)),
                        ),
                        SizedBox(height: 10.h),
                        FormFieldTitle(title: "Zip Code".tr),
                        SizedBox(height: 4.h),
                        CustomFormField(
                          controller: addressController.zipTextController,
                        ),
                        SizedBox(height: 10.h),
                        FormFieldTitle(title: "Street Address".tr),
                        SizedBox(height: 4.h),
                        CustomFormField(
                          controller: addressController.streetTextController,
                          validator: (address) => ValidationRules().normal(address),
                        ),
                        SizedBox(height: 24.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SecondaryButton2(
                                      height: 48.h,
                                      width: 158.w,
                                      text: "Update Address".tr,
                                      buttonColor: AppColor.primaryColor,
                                      textColor: AppColor.whiteColor,
                                      onTap: () async {
                                        if (addressController.formkey.currentState!
                                            .validate()) {
                                          if (box.read("isLogedIn") != false) {
                                            await addressController
                                                .updateAddress(id: widget.id.toString());
                                            profile.getAddress();
                                          } else {
                                            Get.off(() => const SignInScreen());
                                          }
                                        }
                                      }),
                            SecondaryButton2(
                              height: 48.h,
                              width: 114.w,
                              text: "Cancel".tr,
                              buttonColor: AppColor.cartColor,
                              textColor: AppColor.textColor,
                              onTap: () {
                                Get.back();
                              },
                            )
                          ],
                        ),
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ),
              ),
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
