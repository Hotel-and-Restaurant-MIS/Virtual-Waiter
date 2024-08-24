import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../constant.dart';
import '../constants/text_constants.dart';
import '../model/order_item.dart';

import 'package:get/get.dart';

class OrderItemTile extends StatelessWidget {
  const OrderItemTile({required this.orderItem, required this.onEditBtnTap, required this.onRemoveBtnTap, this.actionBtnVisibility = true});

  final OrderItem orderItem;
  final void Function() onEditBtnTap;
  final void Function() onRemoveBtnTap;

  /// To hide edit/remove btns in pending mode
  final bool actionBtnVisibility;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20.0,
        right: 10.0,
        top: 30.0,
      ),
      child: Container(
        padding: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: kBackgroundClour.withOpacity(0.9),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          children: <Widget>[
            Container(
              width: 400.0,
              child: Row(
                crossAxisAlignment:
                CrossAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    radius: 35.0,
                    backgroundImage:
                    CachedNetworkImageProvider(
                        orderItem.menuItem.imageUrl),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        orderItem.menuItem.name,
                        style:
                        TextConstants.kSmallTextStyle(
                            fontSize: 23.0,
                            fontWeight:
                            FontWeight.w400),
                      ),
                      Text(
                        'LKR ${orderItem.menuItem.price.toStringAsFixed(2)}',
                        style:
                        TextConstants.kSmallTextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 19.0,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              width: 40.0,
              child: Text(
                orderItem.quantity.toString(),
                style: TextConstants.kSmallTextStyle(
                    fontSize: 25.0),
              ),
            ),
            SizedBox(
              width: 50.0,
            ),
            Container(
              width: 130.0,
              child: Text(
                '${orderItem.totalPrice.toStringAsFixed(2)}',
                style: TextConstants.kSmallTextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w400),
              ),
            ),
            SizedBox(
              width: 40.0,
            ),
            Visibility(
              visible: actionBtnVisibility,
              child: GestureDetector(
                onTap: onEditBtnTap,
                child: Container(
                  decoration: BoxDecoration(
                    border:
                    Border.all(color: Colors.lightGreen),
                    borderRadius: BorderRadius.circular(7.0),
                  ),
                  width: 40.0,
                  height: 40.0,
                  child: Center(child: Icon(Icons.edit)),
                ),
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Visibility(
              visible: actionBtnVisibility,
              child: GestureDetector(
                // onTap: () => _orderDataController.removeItem(
                //     orderItemId: orderItem.orderItemId),
                onTap: onRemoveBtnTap,

                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: kButtonClour),
                    borderRadius: BorderRadius.circular(7.0),
                  ),
                  width: 40.0,
                  height: 40.0,
                  child: Center(
                      child: Icon(Icons.delete_outline)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
