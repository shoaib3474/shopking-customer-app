import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shopperz/utils/svg_icon.dart';
import 'package:shopperz/widgets/textwidget.dart';

import '../../../../config/theme/app_color.dart';
import '../../../../widgets/textwidget_with_currency.dart';

class CartWidget extends StatefulWidget {
  const CartWidget(
      {super.key,
      this.title,
      this.color,
      this.size,
      this.increment,
      this.decrement,
      required this.quantity,
      this.productImage,
      this.currentPrice,
      this.discountPrice,
      this.remove,
      required this.isOffer,
      this.stock,
      this.incrementValue,
      this.decrementIconvalue = 1,
      this.finalVariation});

  final String? productImage;
  final String? title;
  final String? color;
  final String? size;
  final String quantity;
  final String? currentPrice;
  final String? discountPrice;
  final void Function()? increment;
  final void Function()? decrement;
  final void Function()? remove;
  final int decrementIconvalue;
  final int? incrementValue;
  final int? stock;
  final String? finalVariation;
  final bool? isOffer;

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 90.h,
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: widget.productImage ??
                    "https://img.freepik.com/free-vector/healthy-food-packaging-set_1284-23304.jpg",
                imageBuilder: (context, imageProvider) => Container(
                  height: 75.h,
                  width: 60.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover),
                  ),
                ),
              ),
              SizedBox(
                width: 15.w,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: widget.title ?? '',
                      color: AppColor.textColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                   
                    SizedBox(
                      height: 10.h,
                    ),

                    Row(
                      children: [
                        TextWidgetWithCurrency(
                          text: widget.currentPrice,
                          color: AppColor.primaryColor,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        widget.isOffer == true
                            ? TextWidgetWithCurrency(
                                text: widget.discountPrice ?? '0',
                                color: AppColor.quantityError,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.lineThrough)
                            : const SizedBox(),
                      SizedBox(width: 5.w), 
                       TextWidget(
                      text: widget.finalVariation,
                      color: AppColor.textColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                      ],
                    ),
                    SizedBox(
                      height: 5.h,
                    ),

                    Row(
                      children: [
                        InkWell(
                          onTap: widget.decrement,
                          child: SvgPicture.asset(
                              widget.decrementIconvalue < 2
                                  ? SvgIcon.cart1
                                  : SvgIcon.cart3,
                              height: 24.h,
                              width: 24.w),
                        ),
                        SizedBox(
                          width: 12.w,
                        ),
                        TextWidget(
                          text: widget.quantity,
                          color: AppColor.textColor,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(
                          width: 12.w,
                        ),
                        InkWell(
                          onTap: widget.increment,
                          child: SvgPicture.asset(
                              widget.stock! >
                                      widget.incrementValue!.toInt()
                                  ? SvgIcon.cart2
                                  : SvgIcon.cart1,
                              height: 24.h,
                              width: 24.w),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: widget.remove,
                          child: Container(
                            height: 30.h,
                            width: 30.w,
                            decoration: BoxDecoration(
                                color: AppColor.primaryColor.withOpacity(0.9),
                                shape: BoxShape.circle
                                ),
                            child:  Center(
                              child: SvgPicture.asset(SvgIcon.remove,
                                          height: 16.h, width: 16.w, 
                                          color: AppColor.whiteColor,
                                          ),
                            ) ,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 13.h,
        ),
        Container(
          height: 1.h,
          width: double.infinity,
          color: AppColor.borderColor,
        )
      ],
    );
  }
}
