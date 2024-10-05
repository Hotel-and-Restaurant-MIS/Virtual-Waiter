import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MenuShimmerItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[500]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Circular shimmer for the image
          Container(
            width: 200.0,
            height: 200.0,
            decoration: BoxDecoration(
              color: Colors.white38,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(height: 10.0),

          // Rectangular shimmer for the dish name
          Container(
            width: 120.0,
            height: 20.0,
            color: Colors.white,
          ),
          SizedBox(height: 5.0),

          // Rectangular shimmer for the price
          Container(
            width: 80.0,
            height: 20.0,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}

class MenuShimmerGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(10.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 5.0,
        childAspectRatio: 1.1,
      ),
      itemCount: 8, // Number of shimmer items
      itemBuilder: (context, index) {
        return MenuShimmerItem();
      },
    );
  }
}
