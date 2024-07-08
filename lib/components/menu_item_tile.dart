import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtual_waiter/constant.dart';
import 'package:virtual_waiter/controllers/views/single_menu_item_screen/smis_state_controller.dart';

import '../constants/text_constants.dart';
import '../views/order_list.dart';

class MenuItemTile extends StatelessWidget {


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
  final List<String> tags;
  final Function() onTap;

  MenuItemTile({
    required this.id,
    required this.name,
    required this.price,
    required this.availableQuantity,
    required this.imageUrl,
    required this.onTap,
    required this.tags,

    this.outerContainerHeight,
    this.innerContainerHeight,
    this.circleRadius,
    this.width,
    this.backgroundColor,
  });

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
    SmisStateController _smisStateController = SmisStateController.instance;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: outerContainerHeight ?? 320,
        width: width ?? 270,
        // color: Colors.white10,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  color: backgroundColor ?? Color(0xFF1F1D2B),
                  // Color(0xFF1F1D2B)
                  borderRadius: BorderRadius.circular(10.0),
                ),
                height: innerContainerHeight ?? 260,
                width: width ?? 270,
                child: Container(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(height: 35.0),
                    Text(
                      name,
                      style: TextStyle(
                        fontFamily: 'Barlow',
                        fontSize: 23.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    SizedBox(height: 10.0),
                    Text(
                      'LKR $price',
                      style: TextStyle(
                        fontFamily: 'Barlow',
                        fontSize: 18.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      '$availableQuantity Bowls are Available',
                      style: TextStyle(
                        fontFamily: 'Barlow',
                        fontSize: 17.0,
                        color: Color(0xFFABBBC2),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10.0),

                    // GestureDetector(
                    //   onTap: _smisStateController.addOrderList(),
                    //   child: Container(
                    //     height: 33.0,
                    //     width: 145.0,
                    //     margin: EdgeInsets.only(right: 20.0),
                    //     decoration: BoxDecoration(
                    //         color: kButtonClour.withOpacity(0.9),
                    //         borderRadius: BorderRadius.circular(5.0),
                    //         ),
                    //     child: Center(
                    //       child: Text(
                    //         'Add to My Orders',
                    //         style: TextStyle(
                    //             fontFamily: 'Barlow',
                    //             fontSize: 15.0,
                    //             fontWeight: FontWeight.w500,
                    //             color: Colors.white),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(height: 10.0),
                  ],
                )),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: CircleAvatar(
                radius: circleRadius ?? 80,
                backgroundImage: CachedNetworkImageProvider(imageUrl),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
