import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:virtual_waiter/constant.dart';

class MenuItemTile extends StatelessWidget {
  MenuItemTile({
    required this.id,
    required this.name,
    required this.price,
    required this.availableQuantity,
    required this.imageUrl,
    required this.onTap,
    this.outerContainerHeight,
    this.innerContainerHeight,
    this.circleRadius,
    this.width,
    this.backgroundColor,
  });

  double? outerContainerHeight;
  double? innerContainerHeight;
  double? width;
  double? circleRadius;
  Color? backgroundColor;
  final int id;
  final String name;
  final double price;
  final int availableQuantity;
  final String imageUrl;
  final Function() onTap;

  String _generateQuantityString() {
    String text = '';
    if (availableQuantity == 1) {
      text = '1 Bowl Available';
    } else if (availableQuantity == 0) {
      text = 'Out of Stock';
    } else {
      text = '$availableQuantity Bowls availabe';
    }
    return text;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.amberAccent,
        height: outerContainerHeight ?? 260,
        width: width ?? 192,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  color: backgroundColor ?? Color(0xFF1F1D2B),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                height: innerContainerHeight ?? 226,
                width: width ?? 192,
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: CircleAvatar(
                radius: circleRadius ?? 66,
                backgroundImage: CachedNetworkImageProvider(imageUrl),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
