import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:third_exam_n8/data/local/db/local_databases.dart';
import 'package:third_exam_n8/router.dart';
import 'package:third_exam_n8/ui/one_category/widgets/ImageShimmer.dart';
import 'package:third_exam_n8/ui/one_category/widgets/shimmer_products.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  bool loading = false;
  bool isLiked = false;
  List<Map<String, dynamic>> products = [];

  _getData() async {
    setState(() {
      loading = true;
    });
    products = await LocalDatabase.getAllProducts();
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
        title: const Text("AllProducts Screen"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteNames.favorite);
              },
              icon: const Icon(
                Icons.favorite,
                color: Colors.white,
              )),
        ],
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
              itemCount: products.length,
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
                                    padding: EdgeInsets.all(8.0.h),
                                    child: SizedBox(
                                      height: 120.h,
                                      width: 120.h,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        child: CachedNetworkImage(
                                          imageUrl: products[index]
                                              ["image_url"],
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
                                  Text(products[index]["name"]),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Text(
                                    "\$${products[index]["price"].toString()}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20.sp,
                                        color: Colors.blue),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
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
                                  TextButton(
                                      onPressed: () {

                                        setState(() {
                                          LocalDatabase.deleteProduct(
                                              products[index]["image_url"]);
                                          products.remove(products[index]);
                                        });
                                        Fluttertoast.showToast(
                                          msg: "o'chirildi",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          backgroundColor: Colors.black,
                                          textColor: Colors.white,
                                        );
                                      },
                                      child: Text("delete"))
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }),
    );
  }
}
