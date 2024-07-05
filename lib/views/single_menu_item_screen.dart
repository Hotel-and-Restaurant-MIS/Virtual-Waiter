import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:virtual_waiter/components/add_sub_button.dart';
import 'package:virtual_waiter/constant.dart';
import 'package:virtual_waiter/constants/textConstants.dart';
import 'package:virtual_waiter/controllers/views/single_menu_item_screen/smis_state_controller.dart';
import '../model/MenuItem.dart';

class SingleMenuItemScreen extends StatelessWidget {
  final MenuItem menuItem;
  late SmisStateController _smisStateController;
  bool checkBoxValue = false;

  SingleMenuItemScreen({required this.menuItem}) {
    _smisStateController = SmisStateController.instance;
  }

  @override
  Widget build(BuildContext context) {
    _smisStateController.menuItem = menuItem;
    List<String> tagList = menuItem.tags;

    return Scaffold(
      backgroundColor: kBackgroundClour.withOpacity(0.7),
      body: SafeArea(
        child: OrientationBuilder(builder: (context, orientation) {
          double deviceWidth = MediaQuery.of(context).size.width;
          double deviceHeight = MediaQuery.of(context).size.height;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 30.0,
                        ),
                      ),
                      onTap: () {
                        Get.back();
                        _smisStateController.resetData();
                      },
                    ),
                    SizedBox(
                      width: 80,
                    ),
                    Text(
                      'Add ${menuItem.name} to Your Order List',
                      style: TextStyle(
                        fontFamily: 'Barlow',
                        fontSize: 25.0,
                        fontWeight: FontWeight.w500,
                        color: kButtonClour,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 1.0,
                  width: deviceWidth,
                  color: Colors.white.withOpacity(0.5),
                  margin: EdgeInsets.only(top: 7.0),
                ),
                Padding(
                  padding: orientation == Orientation.portrait
                      ? EdgeInsets.all(50.0)
                      : EdgeInsets.all(30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 100.0,
                        backgroundImage:
                            CachedNetworkImageProvider(menuItem.imageUrl),
                      ),
                      SizedBox(
                          width: orientation == Orientation.portrait
                              ? deviceWidth * 0.1
                              : deviceWidth * 0.15),
                      Column(
                        //mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            menuItem.name,
                            style: TextConstants.kMainTextStyle(
                              fontSize: 33.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Visibility(
                            visible: tagList.isNotEmpty,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: tagList.map<Widget>((tag) {
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
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      const SizedBox(
                                        width: 15.0,
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Text(
                            'LKR ${menuItem.price.toStringAsFixed(2)}',
                            style: TextConstants.kSubTextStyle(
                              fontWeight: FontWeight.w400,
                              textColour: Colors.white,
                              fontSize: 27.0,
                            ),
                          ),
                          SizedBox(
                            height: 35.0,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.note_add_outlined,
                            size: 35.0,
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          Text(
                            'Description',
                            style: TextConstants.kSubTextStyle(
                              fontSize: 27.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        menuItem.description,
                        style: TextConstants.kSubTextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.food_bank,
                            size: 35.0,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          Text(
                            'Quantity',
                            style: TextConstants.kSubTextStyle(
                                fontSize: 27.0, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            'How many ${menuItem.name}s do you need ? ',
                            style: TextConstants.kSubTextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.w300),
                          ),
                          SizedBox(
                            width: 50.0,
                          ),
                          Obx(
                            () => AddSubButton(
                                value: _smisStateController.quantity,
                                onAddPress:
                                    _smisStateController.incrementQuantiy,
                                onSubPress:
                                    _smisStateController.decrementQuantiy),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.add,
                            size: 35.0,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          Text(
                            'AddOns',
                            style: TextConstants.kSubTextStyle(
                                fontSize: 27.0, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      Column(
                        children: menuItem.addOns.map<Widget>((addon) {
                          return Container(
                            padding: EdgeInsets.only(
                              top: 10.0,
                              bottom: 10.0,
                              left: 20.0,
                            ),
                            margin: EdgeInsets.all(10.0),
                            width: deviceWidth * 0.8,
                            height: 60.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7.0),
                              border: Border.all(
                                color: Colors.white,
                                width: 1.5,
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  width: 250.0,
                                  child: Text(
                                    addon['name'],
                                    style: TextConstants.kSubTextStyle(
                                      fontSize: 23.0,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: orientation == Orientation.portrait
                                      ? deviceWidth * 0.1
                                      : deviceWidth * 0.2,
                                ),
                                Icon(
                                  Icons.add_box,
                                  size: 30.0,
                                ),
                                SizedBox(
                                  width: 20.0,
                                ),
                                Text(
                                  '\$',
                                  style: TextConstants.kSubTextStyle(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.w400),
                                ),
                                //SizedBox(width: 15.0,),
                                Text(
                                  '${addon['price']}',
                                  style: TextConstants.kSubTextStyle(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.w400),
                                ),
                                SizedBox(
                                  width: 20.0,
                                ),
                               // AddSubButton(value: _smisStateController., onAddPress: onAddPress, onSubPress: onSubPress)
                                
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
