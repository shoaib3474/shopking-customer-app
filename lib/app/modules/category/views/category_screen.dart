import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shopperz/app/modules/category/controller/category_tree_controller.dart';
import 'package:shopperz/app/modules/category/views/category_wise_product_screen.dart';
import 'package:shopperz/app/modules/category/widgets/category_widget.dart';
import 'package:shopperz/app/modules/home/controller/category_controller.dart';
import 'package:shopperz/app/modules/sub_category/views/sub_category_screen.dart';
import 'package:shopperz/utils/images.dart';
import 'package:shopperz/widgets/loader/loader.dart';

import '../../../../config/theme/app_color.dart';
import '../../../../widgets/appbar.dart';
import '../../../../widgets/textwidget.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final categoryTreeController = Get.put(CategoryTreeController());
  final categoryController = Get.find<CategoryController>();

  @override
  void initState() {
    categoryTreeController.fetchCategoryTree();
    categoryController.fetchCategory(); 
    super.initState();
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
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(48.h),
          child: const AppBarWidget(isSearch: false),
        ),
        body: Obx(
          () => Stack(
            alignment: Alignment.center,
            children: [
              
              RefreshIndicator(
                onRefresh: () async {
                  categoryTreeController.fetchCategoryTree();
                  categoryController.fetchCategory(); 
                },
                color: AppColor.primaryColor,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 16.h,
                      left: 16.w,
                      right: 16.w,
                    ),
                    child: Obx(() {
                      return categoryTreeController.categoryTreeList.isEmpty
                          ? const SizedBox()
                          : categoryTreeController.categoryTreeList.isEmpty
                          ? Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: 100.h),
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
                                      text: 'NO_SUB_CATEGORY_FOUND'.tr,
                                      textAlign: TextAlign.center,
                                      color: AppColor.textColor,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                          : GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 20 , 
                              mainAxisSpacing: 20, 
                              
                            ),
                             itemCount: categoryController.categoryModel.value.data!.length ,
                                // categoryTreeController.categoryTreeList.length,
                            shrinkWrap: true,
                             physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                               final categoryTree =
                                  categoryTreeController.categoryTreeList;
                                  final category = categoryController.categoryModel.value.data!;
                              return  CategoryList(
                                image: category[index].thumb.toString(),
                                // text: categoryTree[index].name.toString(),
                                text: category[index].name.toString() ,
                                onTapProduct: () {
                                  Get.to(
                                    () => CategoryWiseProductScreen(
                                      categoryModel: category[index],
                                    ),
                                    transition: Transition.fade,
                                  );
                                },
                                onTapSubCategory: () {
                                  Get.to(
                                    () => SubCategoryScreen(
                                      categoryTreeModel: categoryTree[index],
                                    ),
                                    transition: Transition.fade,
                                  );
                                },
                              ); ;
                            },
                          ); 
                    }),
                  ),
                ),
              ),
              categoryTreeController.isLoading.value
                  ? const Center(child: LoaderCircle())
                  : const SizedBox(),

                  // TextButton(onPressed: (){
                    // categoryTreeController.fetchCategoryTree(); 
                // print(" category list : ${categoryTreeController.categoryTreeList}") ;
              // }, child: Text("${categoryTreeController.categoryTreeList}")) ,

            ],
          ),
        ),
      ),
    );
  }
}
