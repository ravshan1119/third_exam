import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:third_exam_n8/data/model/category_model.dart';
import 'package:third_exam_n8/data/network/api_provider.dart';
import 'package:third_exam_n8/router.dart';
import 'package:third_exam_n8/ui/category/widgets/image_shimmer.dart';
import 'package:third_exam_n8/ui/category/widgets/shimmer.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  bool loading = false;
  List<CategoryModel> categoryModel = [];

  _getData() async {
    setState(() {
      loading = true;
    });
    categoryModel = await ApiProvider.getCategory();
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Category Screen"),
        centerTitle: true,
      ),
      body: loading
          ? Center(
              child: ShimmerScreen(),
            )
          : ListView(
              children: [
                Column(
                  children: [
                    ...List.generate(
                        categoryModel.length,
                        (index) => Padding(
                              padding: EdgeInsets.all(8.0.h),
                              child: ZoomTapAnimation(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, RouteNames.categoryById,
                                      arguments: categoryModel[index].id);
                                },
                                child: Container(
                                  height: 90.h,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.grey, width: 1),
                                      borderRadius: BorderRadius.circular(10.r),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: Offset(3,5), // no offset
                                      ),
                                    ],),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8.0.h),
                                        child: SizedBox(
                                          height: 80.h,
                                          width: 100.w,
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                categoryModel[index].imageUrl,
                                            placeholder: (context, url) =>
                                                Center(child: ImageShimmer()),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        categoryModel[index].name,
                                        style: TextStyle(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ))
                  ],
                )
              ],
            ),
    );
  }
}
