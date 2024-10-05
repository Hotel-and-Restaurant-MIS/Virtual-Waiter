import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:virtual_waiter/constants/text_constants.dart';
import 'package:virtual_waiter/controllers/views/single_menu_item_screen/smis_state_controller.dart';

class MenuItemTile extends StatelessWidget {
  double? outerContainerHeight;
  double? innerContainerHeight;
  double? width;
  double? circleRadius;
  Color? backgroundColor;
  final int id;
  final String name;
  final double price;
  final String imageUrl;
  final List<String> tags;
  final Function() onTap;

  MenuItemTile({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.onTap,
    required this.tags,
    this.outerContainerHeight,
    this.innerContainerHeight,
    this.circleRadius,
    this.width,
    this.backgroundColor,
  });

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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(height: 10.0),
                    Text(
                      name,
                      style: TextStyle(
                        fontFamily: 'Barlow',
                        fontSize: 23.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Visibility(
                      visible: tags.isEmpty,
                      child: SizedBox(
                        height: 20.0,
                      ),
                    ),
                    Visibility(
                      visible: tags.isNotEmpty,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: tags.map<Widget>((tag) {
                          return Container(
                            margin: EdgeInsets.all(5.0),
                            padding: EdgeInsets.all(3.0),
                            decoration: BoxDecoration(
                              color: Colors.blueAccent.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  '#$tag',
                                  style: TextConstants.kSubTextStyle(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w400),
                                ),
                                const SizedBox(
                                  width: 5.0,
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'LKR ${MoneyFormatter(amount:price).output.nonSymbol}',
                      style: TextStyle(
                        fontFamily: 'Barlow',
                        fontSize: 18.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Visibility(
                      visible: tags.isEmpty,
                      child: SizedBox(
                        height: 20.0,
                      ),
                    ),
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
