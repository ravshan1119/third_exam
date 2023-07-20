import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ImageShimmerProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Shimmer.fromColors(
          baseColor: Colors.white,
          highlightColor: Colors.black.withOpacity(0.3),
          child: Container(
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(5),
            height: 120.h,
            width: 120.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
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
          )),
    );
  }
}
