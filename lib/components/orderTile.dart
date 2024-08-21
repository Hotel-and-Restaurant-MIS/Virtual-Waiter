import 'package:flutter/material.dart';
import 'package:virtual_waiter/enum/order_status.dart';

class OrderTile extends StatelessWidget {
  String orderNo;
  OrderStatus orderStatus;
  double orderTotal;

  OrderTile(
      {required this.orderNo,
      required this.orderStatus,
      required this.orderTotal});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.grey.withOpacity(0.4), borderRadius: BorderRadius.circular(10.0)),
        // width: 200.0,
        // height: 80.0,
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        padding: EdgeInsets.all(20.0),  
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: [
                Text('Order No. $orderNo', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700,),),
                Text('Total : $orderTotal', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18,),),
              ],
            ),
            Text('$orderStatus'),
          ],
        ),
      ),
    );
  }
}
