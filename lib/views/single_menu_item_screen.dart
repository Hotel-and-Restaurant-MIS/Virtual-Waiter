import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:virtual_waiter/components/add_sub_button.dart';
import 'package:virtual_waiter/constant.dart';
import 'package:virtual_waiter/constants/text_constants.dart';
import 'package:virtual_waiter/controllers/views/menuScreen/check_box_controller.dart';
import 'package:virtual_waiter/controllers/views/single_menu_item_screen/smis_state_controller.dart';
import '../model/menu-item.dart';
import 'order_list_screen.dart';

class SingleMenuItemScreen extends StatelessWidget {
  final MenuItem menuItem;
  late SmisStateController _smisStateController;
  RxBool isChecked = false.obs;
  TextEditingController _textFieldController = TextEditingController();

  SingleMenuItemScreen({required this.menuItem}) {
    _smisStateController = SmisStateController.instance;
  }

  void toggleCheckbox(bool? value) {
    isChecked.value = value ?? false;
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
                        color: Colors.white,
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
                            //'LKR ${_smisStateController.totalAmount.toStringAsFixed(2)}',
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
                      kSizedBoxUnderTitle,
                      Text(
                        menuItem.description,
                        style: TextConstants.kSubTextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      kSizedBoxUnderContent,
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
                      kSizedBoxUnderTitle,
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
                                    _smisStateController.incrementQuantity,
                                onSubPress:
                                    _smisStateController.decrementQuantity),
                          ),
                        ],
                      ),
                      kSizedBoxUnderContent,
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
                      kSizedBoxUnderTitle,
                      Column(
                        children: menuItem.addOns.map<Widget>((addon) {
                          String checkBoxContTag =
                              'add-on-check-box-cont-${menuItem.id}-${addon['id']}';
                          Get.put(CheckboxController(), tag: checkBoxContTag);
                          CheckboxController _checkboxController =
                              Get.find(tag: checkBoxContTag);
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
                                  size: 25.0,
                                ),
                                SizedBox(
                                  width: 20.0,
                                ),
                                Text(
                                  'LKR ',
                                  style: TextConstants.kSubTextStyle(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.w400),
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  '${addon['price']}',
                                  style: TextConstants.kSubTextStyle(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.w400),
                                ),
                                SizedBox(
                                  width: orientation == Orientation.portrait
                                      ? deviceWidth * 0.1
                                      : deviceWidth * 0.2,
                                ),
                                Obx(
                                  () => Checkbox(
                                    activeColor: kButtonClour,
                                    value: _checkboxController.isChecked.value,
                                    onChanged: (value) {
                                      //before toggle
                                      if (!_checkboxController
                                          .isChecked.value) {
                                        _smisStateController.addAddOns(
                                            addOnId: addon['id']);
                                        Get.snackbar('Add On Added',duration: Duration(seconds: 1 ),
                                            'Add On ${addon['name']} added.',
                                            snackPosition:
                                                SnackPosition.TOP);

                                      } else {
                                        _smisStateController.removeAddOns(
                                            addOnId: addon['id']);
                                      }
                                      _checkboxController.toggleCheckbox(value);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                      kSizedBoxUnderContent,
                      Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.send,
                                size: 30.0,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              Text(
                                'Add Special Note to Chef',
                                style: TextConstants.kSubTextStyle(
                                    fontSize: 27.0,
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                          kSizedBoxUnderTitle,
                          TextField(
                            decoration: InputDecoration(
                              hintText: 'Type here...',
                              hintStyle: TextConstants.kSubTextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.w400),
                            ),
                            controller: _textFieldController,
                            onSubmitted: _smisStateController.specialNote,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 70.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          'Total',
                          style: TextConstants.kSubTextStyle(fontSize: 40.0),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Obx(
                          () => Text(
                            'LKR  ${_smisStateController.totalAmount.toStringAsFixed(2)}',
                            style: TextConstants.kSubTextStyle(
                                fontSize: 35.0, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          _smisStateController.addOrderList();
                          Get.back();
                          _smisStateController.resetData();
                           },
                        child: Container(
                          alignment: Alignment.center,
                          height: 60.0,
                          width: 230.0,
                          margin: EdgeInsets.only(right: 20.0),
                          decoration: BoxDecoration(
                            color: kButtonClour.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Center(
                            child: Text(
                              'Add to My Orders',
                              style: TextStyle(
                                  fontFamily: 'Barlow',
                                  fontSize: 23.0,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
