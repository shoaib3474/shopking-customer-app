import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopperz/app/modules/auth/controller/auth_controler.dart';
import 'package:shopperz/app/modules/auth/views/sign_in.dart';
import 'package:shopperz/app/modules/cart/controller/cart_controller.dart';
import 'package:shopperz/app/modules/cart/widgets/cart_item.dart';
import 'package:shopperz/app/modules/product_details/controller/product_details_controller.dart';
import 'package:shopperz/app/modules/shipping/views/shipping_information_screen.dart';
import 'package:shopperz/main.dart';
import 'package:shopperz/utils/images.dart';
import 'package:shopperz/widgets/devider.dart';
import 'package:shopperz/widgets/primary_button.dart';
import 'package:shopperz/widgets/textwidget.dart';

import '../../../../config/theme/app_color.dart';
import '../../../../widgets/custom_snackbar.dart';
import '../../../../widgets/textwidget_with_currency.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final cartController = Get.find<CartController>();
  final authController = Get.put(AuthController());
  final productDetailsController = Get.put(ProductDetailsController());

  @override
  void dispose() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      productDetailsController.resetProductState();
    });

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: AppColor.primaryBackgroundColor,
        appBar: AppBar(
          backgroundColor: AppColor.whiteColor,
          elevation: 0.5,
          centerTitle: true,
         title: Text(
              "Shopping Cart".tr,
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: AppColor.textColor,
              ),
            ),
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back,
                size: 20.sp,
                color: AppColor.textColor,
              ),
            ),
        ),
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 16.h, left: 16.w, right: 16.w),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Obx(
                      () =>
                          cartController.cartItems.isEmpty
                              ? Padding(
                                padding: EdgeInsets.only(top: 60.h),
                                child: Center(
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        AppImages.emptyIcon,
                                        height: 300.h,
                                        width: 300.w,
                                      ),
                                      SizedBox(height: 16.h),
                                      TextWidget(
                                        text: 'CART_IS_EMPTY'.tr,
                                        textAlign: TextAlign.center,
                                        color: AppColor.textColor,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              : ListView.builder(
                                itemCount: cartController.cartItems.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final cartItem =
                                      cartController.cartItems[index];
                                  return Padding(
                                    padding: EdgeInsets.only(top: 16.h),
                                    child: Obx(
                                      () => CartWidget(
                                        productImage:
                                            cartItem.product.data!.image,
                                        title: cartItem.product.data!.name,
                                        finalVariation:
                                            cartItem.finalVariationString,
                                        currentPrice:
                                            cartItem.variationCurrencyPrice
                                                .toString(),
                                        discountPrice:
                                            cartItem.variationOldCurrencyPrice
                                                .toString(),
                                        decrement: () {
                                          cartController.decrementItem(
                                            cartController.cartItems[index],
                                          );
                                        },
                                        isOffer:
                                            cartItem.product.data!.isOffer,
                                        decrementIconvalue:
                                            cartController.totalItems,
                                        quantity:
                                            cartController
                                                .cartItems[index]
                                                .quantity
                                                .toString(),
                                        increment: () {
                                          cartController.incrementItem(
                                            cartController.cartItems[index],
                                          );
                                        },
                                        remove: () {
                                          cartController.removeFromCart(
                                            cartController.cartItems[index],
                                          );
                                        },
                                        stock: cartItem.stock,
                                        incrementValue:
                                            cartItem.quantity.value,
                                      ),
                                    ),
                                  );
                                },
                              ),
                    ),
                    // SizedBox(height: 164.h),
                  ],
                ),
              ),
            ),
           
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const DeviderWidget(),
                   
                    SizedBox(height: 15.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextWidget(
                            text: 'Subtotal'.tr,
                            color: AppColor.textColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          Obx(
                            () => TextWidgetWithCurrency(
                              text:
                                  '${authController.currency}${cartController.totalPrice.toStringAsFixed(2)}',
                              color: AppColor.textColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: 16.h),
            
                    InkWell(
                      onTap: () {
                        if (cartController.cartItems.isEmpty) {
                          customSnackbar(
                            "ERROR".tr,
                            "Your cart is empty",
                            AppColor.error,
                          );
                        } else {
                          Get.to(
                            () =>
                                box.read("isLogedIn") != false
                                    ? const ShippingInformationScreen()
                                    : const SignInScreen(),
                          );
                        }
                      },
                      child: PrimaryButton(text: 'Proceed to Checkout'.tr),
                    ),

                     SizedBox(height: 10.h),
                    
                        TextWidget(
                      text:
                     'Shipping, Taxes & Discount Calculate at Checkout',
                      color: AppColor.primaryColor.withOpacity(0.6),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  SizedBox(height: 10.h),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
