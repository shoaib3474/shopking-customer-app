import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:shopperz/utils/svg_icon.dart';
import 'package:shopperz/widgets/textwidget.dart';

import '../../../../config/theme/app_color.dart';

class CategoryList extends StatelessWidget {
  const CategoryList(
      {super.key,
      required this.text,
      required this.image, 
      this.onTapSubCategory,
      this.onTapProduct});

  final String text;
  final String image ;
  final Function()? onTapProduct;

  final Function()? onTapSubCategory;

  @override
  Widget build(BuildContext context) {
    return 
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColor.whiteColor,
          border: Border.all( color: AppColor.borderColor, width: 1.sp)),
      child: Column(
        children: [
            //    add category image here
               InkWell(
                onTap: onTapProduct,
                 child: CachedNetworkImage(
                            imageUrl: image,
                            imageBuilder:
                                (context, imageProvider) =>
                                 Container(
                                  height: 100,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8.r),
                                      topRight: Radius.circular(8.r),
                                    ),
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                          ),
               ),
           
            SizedBox(height: 3.h,), 

          Expanded(
            child: InkWell(
              onTap: onTapProduct,
              child: Center(
                child: TextWidget(
                  text: text,
                  color: const Color.fromRGBO(46, 58, 89, 1),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
         
         SizedBox(height: 0.h,), 

        //    InkWell(
        //     onTap: onTapSubCategory,
        //    child: Container(
        //   height: 32.h, 
        //   width:double.infinity,
        //   decoration: BoxDecoration(
        //     border: Border(top: BorderSide(color: AppColor.borderColor, width: 1.w)), 
        //   ),
        //   child: Center(child: Text('View Sub Categories', textAlign: TextAlign.center, style:TextStyle(fontSize: 10 , color: AppColor.textColor) ,)) ,
        //      ),
        // ),
          
        ],
      ),
    );
  }
}
