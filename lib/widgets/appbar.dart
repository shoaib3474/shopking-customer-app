import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:shopperz/app/modules/cart/controller/cart_controller.dart';
import 'package:shopperz/app/modules/navbar/controller/navbar_controller.dart';
import 'package:shopperz/utils/svg_icon.dart';

import '../../../../config/theme/app_color.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget(
      {super.key,
      this.onTap,
      this.svgIcon,
      this.title,
      required this.isSearch});

  final void Function()? onTap;
  final String? svgIcon;
  final String? title;
  final bool? isSearch;

  @override
  Widget build(BuildContext context) { 
    final CartController cartController = Get.find<CartController>(); 
    return AppBar(
      backgroundColor: AppColor.primaryBackgroundColor,
      elevation: 0,
      toolbarHeight: 48.h,
      leadingWidth: 130.w,
      leading: Padding(
        padding: EdgeInsets.only(left: 16.w, right: 16.w),
        child: SvgPicture.asset(
          SvgIcon.logo,
          height: 20.h,
          width: 73.w,
        ),
      ),
      title: Text(
        title ?? "",
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
          color: AppColor.textColor,
        ),
      ),
      actions: [
          Stack( 
            children: [
               GestureDetector(
                  onTap: onTap,
                  child: Container(
                    margin: EdgeInsets.only(right: 18.w, top: 13.h),
                    child: SvgPicture.asset(
                      svgIcon ?? "",
                      height: 26.h,
                      width: 26.w, 
                      color: AppColor.textColor,
                    ),
                  ),
                ), 
                //  cartController.totalItems > 0
                //           ? 
                          Positioned(
                              top: 10,
                              right: 13,
                              child: Container(
                                padding: EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                    color: AppColor.primaryColor,
                                    shape: BoxShape.circle
                                    ),
                                    child: Text(cartController.cartItems.length.toString() ,style: TextStyle(fontSize: 7, color: Colors.white),),
                              ),
                            )
                          // : Container()
                ]
          )
            
      ],
    // bottom: PreferredSize(
    //   preferredSize:Size(MediaQuery.of(context).size.width , 0) , 
    //   child: Column(
    //     children: [
    //          Container(
    //           margin: EdgeInsets.symmetric(horizontal: 20),
    //           padding: EdgeInsets.all(10),
    //           decoration: BoxDecoration(
    //             color: AppColor.grayColor, 
    //           ),
    //          )
    //     ],
    //   )),
    );
  }
}
