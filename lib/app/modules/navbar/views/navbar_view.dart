import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:shopperz/app/modules/auth/views/sign_in.dart';
import 'package:shopperz/app/modules/cart/controller/cart_controller.dart';
import 'package:shopperz/app/modules/cart/views/cart_screen.dart';
import 'package:shopperz/app/modules/category/views/category_screen.dart';
import 'package:shopperz/app/modules/home/views/home_screen.dart';
import 'package:shopperz/app/modules/navbar/controller/navbar_controller.dart';
import 'package:shopperz/app/modules/navbar/widgets/bottom_navbar.dar.dart';
import 'package:shopperz/app/modules/profile/views/profile_screen.dart';
import 'package:shopperz/app/modules/wishlist/controller/wishlist_controller.dart';
import 'package:shopperz/app/modules/wishlist/views/wishlist_screen.dart';
import 'package:shopperz/data/helper/device_token.dart';
import 'package:shopperz/data/helper/notification_helper.dart';
import 'package:shopperz/main.dart';
import 'package:shopperz/utils/svg_icon.dart';
import '../../../../config/theme/app_color.dart';

class NavBarView extends StatelessWidget {
  const NavBarView({super.key});

  @override
  Widget build(BuildContext context) {
    NotificationHelper notificationHelper = NotificationHelper();

    DeviceToken deviceToken = DeviceToken();

    notificationHelper.notificationPermission();

    if (box.read('isLogedIn') != false && box.read('isLogedIn') != null) {
      deviceToken.getDeviceToken();
    }

    final navController = Get.put(NavbarController());
    GlobalKey<ScaffoldMessengerState> scaffoldKey = GlobalKey();
    final CartController cartController = Get.find<CartController>();

    List<Widget> screens = [
      const HomeScreen(),
      const CategoryScreen(),
      const WishlistScreen(),
      const ProfileScreen()
    ];

    return WillPopScope(
      onWillPop: () async {
        if (navController.selectedIndex.value != 0) {
          navController.selectPage(0);
          return false;
        } else {
          if (navController.canExit.value) {
            navController.selectPage(0);
            return true;
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Press back again to exit.'.tr,
                    style: TextStyle(color: Colors.white)),
                behavior: SnackBarBehavior.floating,
                backgroundColor: AppColor.primaryColor,
                duration: Duration(seconds: 2),
                margin: EdgeInsets.all(10),
              ),
            );
            navController.canExit.value = true;
            Timer(const Duration(seconds: 2), () {
              navController.canExit.value = false;
            });
            return false;
          }
        }
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.dark,
        ),
        child: Scaffold(
          key: scaffoldKey,
          extendBody: true,
           bottomNavigationBar: Obx(() {
            return Container(
              decoration: BoxDecoration(
                color: AppColor.whiteColor,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 20,
                    color: Colors.black.withOpacity(.1),
                  )
                ],
              ),
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
                  child: GNav(
                    rippleColor: AppColor.primaryColor.withOpacity(0.1),
                    hoverColor: AppColor.primaryColor.withOpacity(0.1),
                    haptic: true,
                    tabBorderRadius: 30.r,
                    tabActiveBorder: Border.all(color: AppColor.primaryColor, width: 1),
                    tabShadow: [
                    ],
                    curve: Curves.easeOutBack,
                    duration: Duration(milliseconds: 500),
                    gap: 8,
                    color: AppColor.deSelectedColor,
                    activeColor: AppColor.whiteColor,
                    iconSize: 24.r,
                    tabBackgroundColor: AppColor.primaryColor,
                    padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 14.h),
                   tabs: [
  GButton(
    icon:const IconData(0),  
    leading: SvgPicture.asset(
      SvgIcon.home,
      colorFilter: ColorFilter.mode(
        navController.selectedIndex.value == 0
            ? AppColor.whiteColor
            : AppColor.deSelectedColor,
        BlendMode.srcIn,
      ),
      height: 20.h,
      width: 20.w,
    ),
    text: 'Home'.tr,
    textStyle: TextStyle(
      fontSize: 13.sp,
      fontWeight: FontWeight.w500,
      color: AppColor.whiteColor
    ),
  ),
  GButton(
    icon: const IconData(0),
    leading: SvgPicture.asset(
      SvgIcon.category,
      colorFilter: ColorFilter.mode(
        navController.selectedIndex.value == 1
            ? AppColor.whiteColor
            : AppColor.deSelectedColor,
        BlendMode.srcIn,
      ),
      height: 20.h,
      width: 20.w,
    ),
    text: 'Category'.tr,
    textStyle: TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w500,
       color: AppColor.whiteColor
       
    ),
  ),
  GButton(
    duration: Duration(milliseconds: 400),
    padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 12.h, bottom: 12.h),
    icon: const IconData(0),
    leading: SvgPicture.asset(
      SvgIcon.wishlist,
      colorFilter: ColorFilter.mode(
        navController.selectedIndex.value == 2
            ? AppColor.whiteColor
            : AppColor.deSelectedColor,
        BlendMode.srcIn,
      ),
      height: 20.h,
      width: 20.w,
    ),
    text: 'Wishlist'.tr,
    textStyle: TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w500,
    color: AppColor.whiteColor
    ),
  ),
  GButton(
    icon:const IconData(0),
    leading: SvgPicture.asset(
      SvgIcon.profile,
      colorFilter: ColorFilter.mode(
        navController.selectedIndex.value == 3
            ? AppColor.whiteColor
            : AppColor.deSelectedColor,
        BlendMode.srcIn,
      ),
      height: 20.h,
      width: 20.w,
    ),
    text: 'Profile'.tr,
    textStyle: TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w500,
       color: AppColor.whiteColor
    ),
  ),
],
 selectedIndex: navController.selectedIndex.value,
                    onTabChange: (index) {
                      if (index == 2) { // Wishlist index
                        if (box.read('isLogedIn') != false && box.read('isLogedIn') != null) {
                          navController.selectPage(index);
                          Get.put(WishlistController()).fetchFavorite();
                        } else {
                          Get.to(() => SignInScreen());
                          return;
                        }
                      } else {
                        navController.selectPage(index);
                      }
                    },
                  ),
                ),
              ),
            );
          }),
          body: Obx(() {
            return screens[navController.selectedIndex.value];
          }),
        ),
      ),
    );
  }
}

