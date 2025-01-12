import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtual_waiter/components/order_item_tile.dart';
import 'package:virtual_waiter/constant.dart';
import 'package:virtual_waiter/constants/text_constants.dart';
import 'package:virtual_waiter/controllers/data/order_data_controller.dart';
import 'package:virtual_waiter/controllers/views/order_screen/order_state_controller.dart';
import 'package:virtual_waiter/model/order_item.dart';
import 'package:virtual_waiter/views/menu_screen.dart';
import 'package:virtual_waiter/views/single_menu_item_screen.dart';
import 'package:money_formatter/money_formatter.dart';

class OrderScreen extends StatelessWidget {
  final List<OrderItem>? orderItemList;
  final bool editMode;

  OrderScreen({this.orderItemList, this.editMode = false}) {
    assert(editMode == false ? orderItemList != null : orderItemList == null);
  }

  final OrderDataController _orderDataController = OrderDataController.instance;

  final OrderStateController _osc = OrderStateController.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBackgroundClour.withOpacity(0.7),
        body: Stack(
          children: <Widget>[
            SafeArea(
              child: OrientationBuilder(
                builder: (context, orientation) {
                  double deviceWidth = MediaQuery.of(context).size.width;
                  double deviceHeight = MediaQuery.of(context).size.height;
                  return SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              child: const Padding(
                                padding: EdgeInsets.only(left: 15.0),
                                child: Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                  size: 30.0,
                                ),
                              ),
                              onTap: () {
                                Get.back();
                              },
                            ),
                            SizedBox(
                              width: orientation == Orientation.portrait
                                  ? deviceWidth * 0.35
                                  : deviceWidth * 0.4,
                            ),
                            Text(
                              editMode?'My Cart':'My Orders',
                              style: const TextStyle(
                                fontFamily: 'Barlow',
                                fontSize: 28.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(width: deviceWidth * 0.25),
                            Text(
                              'Item',
                              style:
                                  TextConstants.kSubTextStyle(fontSize: 23.0),
                            ),
                            SizedBox(width: deviceWidth * 0.2),
                            Text(
                              'Qty',
                              style: TextConstants.kSubTextStyle(
                                fontSize: 23.0,
                              ),
                            ),
                            SizedBox(
                              width: orientation == Orientation.portrait
                                  ? deviceWidth * 0.1
                                  : deviceWidth * 0.2,
                            ),
                            Center(
                              child: Text(
                                'Price\nLKR',
                                style: TextConstants.kSubTextStyle(
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 1.0,
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.5)),
                        ),
                        !editMode
                            ? Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: orderItemList!
                                    .map(
                                      (item) => OrderItemTile(
                                        orderItem: item,
                                        onEditBtnTap: () {},
                                        onRemoveBtnTap: () {},
                                        actionBtnVisibility: false,
                                      ),
                                    )
                                    .toList())
                            : Obx(
                                () => Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: _orderDataController.orderItemList
                                      .map<Widget>((orderItem) {
                                    return OrderItemTile(
                                      orderItem: orderItem,
                                      onEditBtnTap: () {
                                        Get.to(() => SingleMenuItemScreen(
                                            menuItem: orderItem.menuItem));
                                        _osc.removeItem(
                                            orderItemId: orderItem.orderItemId);
                                      },
                                      onRemoveBtnTap: () {
                                        _osc.removeItem(
                                            orderItemId: orderItem.orderItemId);
                                      },
                                    );
                                  }).toList(),
                                ),
                              ),
                        SizedBox(
                          height: deviceHeight * 0.08,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: orientation == Orientation.portrait
                                  ? deviceWidth * 0.07
                                  : deviceWidth * 0.08,
                            ),
                            Text(
                              'Order Total :',
                              style: TextConstants.kSubTextStyle(
                                fontSize: 28.0,
                              ),
                            ),
                            SizedBox(
                                width: orientation == Orientation.portrait
                                    ? deviceWidth * 0.1
                                    : deviceWidth * 0.65),
                            editMode
                                ? Obx(
                                    () => Text(
                                      'LKR  ${MoneyFormatter(amount: _orderDataController.totalAmount).output.nonSymbol}',
                                      style: TextConstants.kSubTextStyle(
                                        fontSize: 28.0,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  )
                                : Builder(
                                    builder: (context) {
                                      double total = 0.0;
                                      orderItemList!.forEach(
                                        (item) {
                                          total += item.totalPrice;
                                        },
                                      );
                                      return Text(
                                        total.toStringAsFixed(2),
                                        style: TextConstants.kSubTextStyle(
                                          fontSize: 28.0,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      );
                                    },
                                  ),
                            SizedBox(
                              width: 20.0,
                            ),
                          ],
                        ),
                        SizedBox(height: 50.0),
                        Visibility(
                          visible: editMode,
                          child: GestureDetector(
                            onTap: () async {

                              if (_osc.itemList.isNotEmpty) {
                                await _orderDataController.sendOrder();
                                Get.offAll(() => MenuScreen());
                              }
                            },
                            child: Container(
                              height: deviceHeight * 0.05,
                              width: deviceWidth * 0.8,
                              margin: EdgeInsets.only(right: 20.0),
                              decoration: BoxDecoration(
                                  color: kButtonClour,
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: [
                                    BoxShadow(
                                        offset: Offset(0, 15.35),
                                        blurRadius: 30.06,
                                        color: kButtonClour.withOpacity(0.3))
                                  ]),
                              child: Center(
                                child: Text(
                                  'Order',
                                  style: TextStyle(
                                      fontFamily: 'Barlow',
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: deviceHeight * 0.1,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Obx(
                  () => _orderDataController.isAddingOrder
                  ? Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          color: Colors.blue,
                        ),
                        SizedBox(width: 20.0,),
                        Text('adding...',style: TextStyle(color: Colors.white,fontSize: 23.0),)
                      ],
                    ),
                  ),
                ),
              )
                  : SizedBox.shrink(),
            ),
          ],
        ));
  }
}
