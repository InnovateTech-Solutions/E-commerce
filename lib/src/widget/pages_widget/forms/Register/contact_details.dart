import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vendor_app/src/constant/app_constant.dart';
import 'package:vendor_app/src/constant/color.dart';
import 'package:vendor_app/src/getx/map_controller.dart';
import 'package:vendor_app/src/getx/register_controller.dart';
import 'package:vendor_app/src/model/login_model.dart';
import 'package:vendor_app/src/widget/constant_widget/sizes/sized_box.dart';
import 'package:vendor_app/src/widget/custom_widget.dart/form_widget.dart';
import 'package:vendor_app/src/widget/text_widget/form_text.dart';

import 'map_widget.dart';

class ContactDetailsWidget extends StatefulWidget {
  const ContactDetailsWidget({super.key});

  @override
  State<ContactDetailsWidget> createState() => _ContactDetailsWidgetState();
}

class _ContactDetailsWidgetState extends State<ContactDetailsWidget> {
  final controller = Get.put(RegisterController());
  final mapController = Get.put(MapController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
              child: SizedBox(
            height: 400.h,
            child: ListView(children: [
              registerText(
                  "Make it easier for customers to \nfind and reach you."),
              AppSizes.mediumHeightSizedBox,
              textFieldLabel("Phone Number"),
              FormWidget(
                  login: Login(
                      onTap: () {},
                      enableText: false,
                      controller: controller.phoneNumber,
                      hintText: AppConst.phoneNumber,
                      icon: const Icon(Icons.phone),
                      invisible: false,
                      validator: (email) => controller.vaildPhoneNumber(email),
                      type: TextInputType.number,
                      onChange: null,
                      inputFormat: [controller.maskFormatterPhone])),
              AppSizes.smallHeightSizedBox,
              textFieldLabel("Address"),
              FormWidget(
                login: Login(
                    onTap: () {},
                    enableText: false,
                    controller: controller.address,
                    hintText: "Address",
                    icon: const Icon(Icons.location_city),
                    invisible: false,
                    validator: (email) => controller.validateVendorName(email),
                    type: TextInputType.streetAddress,
                    onChange: null,
                    inputFormat: null),
              ),
              AppSizes.smallHeightSizedBox,
              textFieldLabel("Coordanits"),
              Theme(
                data: Theme.of(context).copyWith(
                    inputDecorationTheme: InputDecorationTheme(
                  filled: true,
                  fillColor: ColorConstants.secondaryScaffoldBacground,
                )),
                child: TextFormField(
                    readOnly: true,
                    validator: (email) => controller.vaildatePassword(email),
                    onTap: () => Get.to(const MapWidget()),
                    controller: mapController.coordinatesController,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color:
                                    ColorConstants.secondaryScaffoldBacground),
                            borderRadius:
                                BorderRadius.all(Radius.circular(7.r))),
                        border: const OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color:
                                    ColorConstants.secondaryScaffoldBacground),
                            borderRadius:
                                BorderRadius.all(Radius.circular(7.r))),
                        hintText: "Select File")),
              ),
            ]),
          )),
        ),
      ],
    );
  }
}
