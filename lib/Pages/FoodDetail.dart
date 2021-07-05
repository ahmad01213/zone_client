import 'dart:convert';

import 'package:arkan/Models/Food.dart';
import 'package:arkan/Models/OptionGroup.dart';
import 'package:arkan/Pages/CartPage.dart';
import 'package:arkan/Providers/FoodProvider.dart';
import 'package:arkan/Providers/MarketProvider.dart';
import 'package:arkan/helpers/helpers.dart';
import 'package:arkan/widgets/SizedBoxWidget.dart';
import 'package:arkan/widgets/Texts.dart';
import 'package:arkan/widgets/textfields.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import 'SignIn.dart';

class FoodDetail extends StatefulWidget {
  Food food;

  FoodDetail(this.food);

  @override
  _FoodDetailState createState() => _FoodDetailState();
}

Map<String, String> options = {};

class _FoodDetailState extends State<FoodDetail> {
  FoodProvider _foodProvider;
  MarketProvider _marketProvider;
  int totalPrice = 0;
  @override
  void initState() {
    options = {};
    totalPrice = widget.food.price;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if (_foodProvider == null) {
      _foodProvider = Provider.of(context);
      _marketProvider = Provider.of(context);
      totalPrice = widget.food.price;

      _foodProvider.getFoodDetails(widget.food.id);
    }
    return Container(
      height: 500,
      color: Colors.white,
      child: Column(
        children: [
          Stack(
            children: [
              CachedNetworkImage(
                imageUrl:widget.food.image,
                height: 200,
                width: screenWidth,
                fit: BoxFit.cover,
              ),
              Positioned(
                  top: 40,
                  left: 10,
                  right: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.white),
                          child: Icon(
                            Icons.close,
                            color: Colors.black,
                            size: 20,
                          ),
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 40,
                      )
                    ],
                  ))
            ],
          ),
          Box(10),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.food.name,
                      style: TextStyle(
                          color: textColor,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                    Box(10),
                    Texts(
                      title: widget.food.desc,
                      fSize: 13,
                      color: Colors.grey,
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    buildQuantityView(() {
                      setState(() {});
                    }),
                    Box(10),
                    Text(
                      "${widget.food.price} ريال",
                      style: TextStyle(
                          color: textColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            height: 100,
            child: Card(
              margin: EdgeInsets.all(0),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Box(10),
                    // Texts(
                    //   title: "Add Instructions",
                    //   fSize: 17,
                    //   weight: FontWeight.w500,
                    // ),
                    // TextField(decoration: InputDecoration(labelText: 'Type Here')),
                    Box(15),


                    _foodProvider.cartLoad
                        ? Center(
                      child: SpinKitRing(
                        size: 25,
                        color: mainColor,
                        lineWidth: 5,
                        duration: Duration(milliseconds: 700),
                      ),
                    )
                        : InkWell(
                      onTap: () async {
                        if(user.id ==null){
                          pushPage(context: context,page: SignInScreen());
                        }else{
                          int price = widget.food.price*quantity;
                          Map<String,String> mapPost = {};
                          for (String key in options.keys){
                            mapPost['options.'+key] = options[key];
                            final group =  _foodProvider.options.where((element) => element.id.toString() == key).first;
                            int addedPrice  = group.options.where((element) => element.id.toString()==options[key]).first.price;
                            price+=addedPrice;
                          }
                          final params = {
                            'user_id':user.id.toString(),
                            'quantity':quantity.toString(),
                            'food_id':widget.food.id.toString(),
                            'price':price.toString(),
                            'options':''
                          };
                          // params.addAll(mapPost);
                          await _foodProvider.addCart(context,params);
                          _marketProvider.getCarts();
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10), color: mainColor),
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Texts(
                              title: " | " + quantity.toString() + " |    " + "أضف للسلة",
                              fSize: 17,
                              weight: FontWeight.w300,
                              color: Colors.white,
                            ),
                            Texts(
                              title: '${widget.food.price*quantity} ريال',
                              fSize: 17,
                              weight: FontWeight.w300,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          // Flexible(
          //   child: Container(
          //     decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(30),
          //         color: Colors.grey.withOpacity(0.1)),
          //     child: _foodProvider.loading
          //         ? Center(
          //             child: SpinKitRing(
          //               size: 25,
          //               color: mainColor,
          //               lineWidth: 5,
          //               duration: Duration(milliseconds: 700),
          //             ),
          //           )
          //         : ListView.builder(
          //             itemCount: _foodProvider.options.length,
          //             padding: EdgeInsets.only(top: 10,bottom: 100),
          //             shrinkWrap: true,
          //             itemBuilder: (ctx, i) {
          //               final group = _foodProvider.options[i];
          //               return Container(
          //                 child: Column(
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                   children: [
          //                     Padding(
          //                       padding: const EdgeInsets.only(
          //                           left: 10.0, right: 10, top: 20),
          //                       child: Texts(
          //                         title: group.name,
          //                         fSize: 17,
          //                         weight: FontWeight.w500,
          //                       ),
          //                     ),
          //                     Container(
          //                         padding: EdgeInsets.all(10),
          //                         margin: EdgeInsets.all(10),
          //
          //                         decoration: BoxDecoration(
          //                             borderRadius: BorderRadius.circular(10),
          //                             color: Colors.white),
          //                         child: buildOptionGroupItem(group))
          //                   ],
          //                 ),
          //               );
          //             }),
          //   ),
          // ),
        ],
      ),
    );
  }
}
class buildOptionGroupItem extends StatefulWidget {
  OptionGroup optionGroup;
  buildOptionGroupItem(this.optionGroup);
  @override
  _buildOptionGroupItemState createState() => _buildOptionGroupItemState();
}

class _buildOptionGroupItemState extends State<buildOptionGroupItem> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: EdgeInsets.all(0),
        separatorBuilder: (BuildContext context, int index) => Divider(
              height: 0.2,
              color: Colors.black,
            ),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: widget.optionGroup.options.length,
        itemBuilder: (ctx, i) {
          final option = widget.optionGroup.options[i];
          return Container(
            width: double.infinity,
            height: 50,
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Texts(
                  title: option.name,
                  fSize: 15,
                  color: Colors.black,
                ),
                Row(
                  children: [
                    Texts(
                      title: option.price.toString()+" ريال",
                      fSize: 14,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 5,),
                    Checkbox(
                      value: selectedIndex == i,
                      onChanged: (v) {
                         if(selectedIndex == i){
                           // totalPrice=totalPrice+widget.optionGroup.options[i].price;
                         }else{
                           // totalPrice=totalPrice+widget.optionGroup.options[i].price;
                         }


                        options [widget.optionGroup.id.toString()]= option.id.toString();
                        setState(() {
                          selectedIndex = i;
                        }
                        );
                      },
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }
}

class buildQuantityView extends StatefulWidget {
  Function update;
  buildQuantityView(this.update);
  @override
  _buildQuantityViewState createState() => _buildQuantityViewState();
}

int quantity = 1;

class _buildQuantityViewState extends State<buildQuantityView> {

  @override
  void initState() {
    quantity=1;

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: 30,
            height: 30,
            child: IconButton(
                padding: EdgeInsets.all(0),
                onPressed: () {
                  if (quantity > 1) {
                    setState(() {
                      quantity--;
                    });
                  }
                  widget.update();
                },
                icon: Icon(
                  Icons.remove_circle_outline,
                  color: Colors.grey,
                  size: 30,
                )),
          ),
          Text(
            quantity.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          Container(
            width: 30,
            height: 30,
            child: IconButton(
                padding: EdgeInsets.all(0),
                onPressed: () {
                  setState(() {
                    quantity++;
                  });
                  widget.update();
                },
                icon: Icon(
                  Icons.add_circle_outline,
                  color: mainColor,
                  size: 30,
                )),
          )
        ],
      ),
    );
  }
}
