import 'package:flutter/material.dart';
import 'package:virtual_waiter/constant.dart';
import 'package:virtual_waiter/enum/order_status.dart';
import 'package:money_formatter/money_formatter.dart';

class OrderTile extends StatelessWidget {
  String orderId;
  OrderStatus orderStatus;
  double orderTotal;

  OrderTile(
      {required this.orderId,
      required this.orderStatus,
      required this.orderTotal});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        decoration: BoxDecoration(
            color: kBackgroundClour.withOpacity(0.9),
            borderRadius: BorderRadius.circular(10.0)),
        // width: 200.0,
        // height: 80.0,
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        padding: EdgeInsets.all(20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                orderStatus == OrderStatus.Editing
                    ? Text(
                        'My Cart',
                        style: TextStyle(
                            fontSize: 22.0, fontWeight: FontWeight.w700,color: Colors.lightGreen),
                      )
                    : Text(
                        'Order No. ${orderId}',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                Text(
                  'Total : ${MoneyFormatter(amount: orderTotal).output.nonSymbol}',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'Order Status: ',
                  style: TextStyle(fontSize: 21.0, fontWeight: FontWeight.w600),
                ),
                Text(
                  ' ${orderStatus.name}',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                      color: orderStatus == OrderStatus.Editing
                          ? Colors.lightGreen
                          : kButtonClour),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
