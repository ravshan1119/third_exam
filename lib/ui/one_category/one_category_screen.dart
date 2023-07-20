import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:third_exam_n8/data/local/db/local_databases.dart';
import 'package:third_exam_n8/data/model/products_model.dart';
import 'package:third_exam_n8/data/network/api_provider.dart';
import 'package:third_exam_n8/ui/one_category/widgets/ImageShimmer.dart';
import 'package:third_exam_n8/ui/one_category/widgets/shimmer_products.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class OneCategoryScreen extends StatefulWidget {
  const OneCategoryScreen({super.key, required this.id});

  final int id;

  @override
  State<OneCategoryScreen> createState() => _OneCategoryScreenState();
}

class _OneCategoryScreenState extends State<OneCategoryScreen> {
  bool loading = false;
  List<ProductsModel> categoryModel = [];
  List<bool> isLikedList = [];

  _getData() async {
    setState(() {
      loading = true;
    });
    categoryModel = await ApiProvider.getProductsById(widget.id);
    for (int i = 0; i < categoryModel.length; i++) {
      isLikedList.add(false);
    }
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
        title: const Text("one category screen"),
        centerTitle: true,
      ),
      body: loading
          ? Center(
              child: ShimmerProducts(),
            )
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 0.65,
              ),
              itemCount: categoryModel.length,
              itemBuilder: (BuildContext ctx, index) {
                return Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(color: Colors.grey, width: 1),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(3, 5), // no offset
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            ZoomTapAnimation(
                              onTap: () {},
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      height: 120.h,
                                      width: 120.h,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              categoryModel[index].imageUrl,
                                          fit: BoxFit.fill,
                                          placeholder: (context, url) => Center(
                                              child: ImageShimmerProducts()),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Text(categoryModel[index].name),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Text(
                                    "\$${categoryModel[index].price.toString()}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20.sp,
                                        color: Colors.blue),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.red,
                                    elevation: 0,
                                  ),
                                  onPressed: () {
                                    Fluttertoast.showToast(
                                      msg: "saqlanganlarga qowildi",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                    );
                                  },
                                  child: const Text("add to cart"),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                        top: 20.h,
                        right: 20.w,
                        child: ZoomTapAnimation(
                          onTap: () {
                            Map<String, dynamic> map = {
                              "name": categoryModel[index].name,
                              "price": categoryModel[index].price,
                              "image_url": categoryModel[index].imageUrl,
                              "_id": categoryModel[index].id,
                            };


                            setState(() {
                              LocalDatabase.getInstance;
                              LocalDatabase.insertProduct(map);
                              isLikedList[index] = !isLikedList[index];
                            });
                          },
                          child: Container(
                              height: 35.h,
                              width: 35.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50.r),
                                  color: Colors.white),
                              child: isLikedList[index]
                                  ? const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              )
                                  : const Icon(
                                Icons.favorite_border,
                                color: Colors.grey,
                              )),
                        )),
                  ],
                );
              }),
    );
  }
}
