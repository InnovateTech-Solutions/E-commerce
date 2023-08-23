import 'package:ecommerce/src/model/button_model.dart';
import 'package:ecommerce/src/widget/constant_widget/constant_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../constant/app_const.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List<Button> drawer = [
      Button(
          title: 'Home',
          icon: SvgPicture.asset(
            'assets/home.svg',
            matchTextDirection: true,
            width: 20.w,
            height: 20.h,
          ),
          onTap: () {}),
      Button(
          title: 'Categoris',
          icon: SvgPicture.asset(
            'assets/cat.svg',
            matchTextDirection: true,
            width: 20.w,
            height: 20.h,
          ),
          onTap: () {}),
      Button(
          title: 'Location',
          icon: SvgPicture.asset(
            'assets/location.svg',
            matchTextDirection: true,
            width: 20.w,
            height: 20.h,
          ),
          onTap: () {}),
      Button(
          title: 'My Appointments',
          icon: SvgPicture.asset(
            'assets/appointment.svg',
            matchTextDirection: true,
            width: 25.w,
            height: 25.h,
          ),
          onTap: () {}),
      Button(
          title: 'Profile',
          icon: SvgPicture.asset(
            'assets/profile.svg',
            matchTextDirection: true,
            width: 20.w,
            height: 20.h,
          ),
          onTap: () {}),
    ];
    return Padding(
      padding: const EdgeInsets.only(left: 18.0),
      child: Column(
        children: [
          Expanded(child: Container()),
          SizedBox(
            width: AppConst.medium,
          ),
          Expanded(
            flex: 3,
            child: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: ListView.separated(
                itemCount: drawer.length,
                itemBuilder: ((context, index) {
                  return drawerWidget(drawer[index]);
                }),
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: AppConst.medium,
                  );
                },
              ),
            ),
          ),
          divder(2000.w, 0, 0),
          drawerWidget(Button(
              title: 'Support And Help',
              icon: SvgPicture.asset(
                'assets/support.svg',
                matchTextDirection: true,
                width: 20.w,
                height: 20.h,
              ),
              onTap: () {})),
          SizedBox(
            height: AppConst.medium,
          ),
          drawerWidget(Button(
              title: 'Logout',
              icon: SvgPicture.asset(
                'assets/logout.svg',
                matchTextDirection: true,
                width: 20.w,
                height: 20.h,
              ),
              onTap: () {})),
        ],
      ),
    );
  }
}
