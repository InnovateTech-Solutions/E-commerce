import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:profile_part/src/constant/color.dart';
import 'package:profile_part/src/getx/cart_controller.dart';
import 'package:profile_part/src/model/vendor_model.dart';
import 'package:profile_part/src/widget/custom_Widget.dart/product_button.dart';

import '../../../View/checkout/appointments.dart';

class CartWidget extends GetView<ServiceController> {
  CartWidget({required this.vendorModel, super.key});
  final VendorModel vendorModel;
  @override
  Widget build(BuildContext context) {
    Get.put(ServiceController());
    return Obx(
      () => controller.cartItems.isEmpty
          ? Center(
              child: Text("The cart is empty",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w500,
                          color: ColorConstants.mainTextColor))),
            )
          : Column(
              children: [
                Expanded(
                    child: ListView.separated(
                        separatorBuilder: (context, index) => Divider(
                              indent: 20.0,
                              endIndent: 10.0,
                              thickness: 1,
                              color: ColorConstants.textFiledmColor,
                            ),
                        itemCount: controller.cartItems.length,
                        itemBuilder: (context, index) {
                          return Dismissible(
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) => controller
                                .removeFromCart(controller.cartItems[index]),
                            key: Key(controller.cartItems[index].name),
                            background: Column(
                              children: [
                                Container(
                                  color: ColorConstants.snakbarColorError,
                                  alignment: Alignment.centerRight,
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: IconButton(
                                    onPressed: () {
                                      controller.toggleService(
                                          controller.cartItems[index]);
                                    },
                                    icon: Icon(
                                      Icons.delete_outline_rounded,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            child: ListTile(
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(controller.cartItems[index].name,
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500,
                                              color: ColorConstants
                                                  .mainTextColor))),
                                  Text(controller.cartItems[index].price,
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500,
                                              color: ColorConstants
                                                  .mainTextColor))),
                                ],
                              ),
                            ),
                          );
                        })),
                Obx(
                  () => controller.cartItems.isEmpty
                      ? Container()
                      : Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            width: double.infinity.w,
                            height: 75.h,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2.r,
                                      blurRadius: 3.r,
                                      offset: const Offset(0, 2)),
                                ],
                                color:
                                    ColorConstants.mainScaffoldBackgroundColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.r))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "BD ${controller.counter.toString()}",
                                      style: TextStyle(
                                        color: ColorConstants
                                            .mainTextColor, // Customize text color
                                        fontSize:
                                            16.0.sp, // Customize text size
                                      ),
                                    ),
                                    Text(
                                      '${controller.cartItems.length} Service',
                                      style: TextStyle(
                                          color: ColorConstants
                                              .mainTextColor, // Customize text color
                                          fontSize: 10.0.sp,
                                          fontWeight: FontWeight.w300
                                          // Customize text size
                                          ),
                                    ),
                                  ],
                                ),
                                ProductButton(
                                  onTap: () => {
                                    Get.to(
                                        Appointments(
                                          vendorModel: vendorModel,
                                        ),
                                        transition: Transition.downToUp,
                                        duration: Duration(milliseconds: 500))
                                  },
                                  title: 'Confrim',
                                )
                              ],
                            ),
                          ),
                        ),
                )
              ],
            ),
    );
  }
}
