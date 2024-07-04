import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:virtual_waiter/constant.dart';
import 'package:virtual_waiter/constants/textConstants.dart';
import 'package:virtual_waiter/controllers/views/single_menu_item_screen/smis_state_controller.dart';
import '../model/MenuItem.dart';

class SingleMenuItemScreen extends StatelessWidget {
  final MenuItem menuItem;
  late SmisStateController _smisStateController;

  SingleMenuItemScreen({required this.menuItem}) {
    _smisStateController = SmisStateController.instance;
  }

  @override
  Widget build(BuildContext context) {
    _smisStateController.menuItem = menuItem;
    List<String> tagList = menuItem.tags;

    return Scaffold(
      body: SafeArea(child: OrientationBuilder(builder: (context, orientation) {
        double deviceWidth = MediaQuery.of(context).size.width;
        double deviceHeight = MediaQuery.of(context).size.height;
        return Column(
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
               // crossAxisAlignment: CrossAxisAlignment.center,
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
                          : deviceWidth * 0.3),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        menuItem.name,
                        style: TextConstants.kMainTextStyle(fontSize: 30.0,fontWeight: FontWeight.w300,),
                      ),
                      SizedBox(height: 15.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: tagList.map<Widget>((tag){
                          return Container(
                            margin: EdgeInsets.all(5.0),
                            padding: EdgeInsets.all(3.0),
                            decoration: BoxDecoration(
                              color: Colors.blueAccent.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(5.0),

                            ),
                            child: Row(
                              children: [
                                Text('#$tag',style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w400),),
                                const SizedBox(width: 15.0,),

                                //TODO: create things.
                              ],
                            ),
                          );
                        }).toList(),
                      ),

                     // SizedBox(height: 100.0,)
                    ],
                  ),
                ],
              ),
            )
          ],
        );
      })),
    );
  }
}
