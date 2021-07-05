import 'package:arkan/Models/Cart.dart';
import 'package:arkan/Models/Food.dart';
import 'package:arkan/Models/Market.dart';
import 'package:arkan/Pages/AddressesPage.dart';
import 'package:arkan/Providers/MarketProvider.dart';
import 'package:arkan/Providers/OrderProvider.dart';
import 'package:arkan/helpers/Functions.dart';
import 'package:arkan/helpers/helpers.dart';
import 'package:arkan/widgets/Buttons.dart';
import 'package:arkan/widgets/SizedBoxWidget.dart';
import 'package:arkan/widgets/Texts.dart';
import 'package:arkan/widgets/textfields.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
class CartPage extends StatefulWidget {
  Market market;
  double totalCost;
  CartPage({this.market, this.totalCost});
  @override
  _CartPageState createState() => _CartPageState();
}
class _CartPageState extends State<CartPage> {
  MarketProvider _marketProvider;
  OrderProvider _orderProvider;
  @override
  Widget build(BuildContext context) {
    if (_marketProvider == null) {
      _marketProvider = Provider.of(context);
      _orderProvider = Provider.of(context);
      _marketProvider.market = widget.market;
      _marketProvider.calcordersPrice();
      _marketProvider.deliveryFee = widget.market.distance*0.5;
    }
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          bottomSheet: Container(
            padding: EdgeInsets.all(18),
            height: 160,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: Colors.white),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Texts(
                        title: "إجمالي السعر",
                        fSize: 17,
                        color: Colors.black,
                        weight: FontWeight.bold,
                      ),
                      Texts(
                        title: " ${_marketProvider.wholePrice.toStringAsFixed(2)} ريال ",
                        fSize: 17,
                        color: Colors.black,
                        weight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
                Box(18),
                Container(
                  height: 50,
                  child: Buttons(
                    title: "إرسال الطلب",
                    fSize: 15,
                    bgColor: Colors.orangeAccent,
                    horizontalMargin: 0,
                    radius: 2,
                    onPressed: () {
                      if(_marketProvider.carts.length==0){
                        HelperFunctions.slt.notifyUser(context: context,message: "السلة فارغة",color: Colors.blue);
                        return;
                      }
                      final params = {
                        'address_id':'1',
                        'status':'1',
                        'market_id':widget.market.id.toString(),
                        'user_id':user.id.toString(),
                        'market_lat':widget.market.lat.toString(),
                        'market_lng':widget.market.lng.toString(),
                        'user_lat':locationData.latitude.toString(),
                        'user_lng':locationData.longitude.toString(),
                        'market_distance':widget.market.distance.toString(),
                        'username':user.name,
                        'marketname':widget.market.title.toString(),
                        'marketimage':widget.market.image.toString(),
                        'market_rate':widget.market.rate.toString(),
                      };
                     _orderProvider.addOrder(context, params);

                    },
                  ),
                )
              ],
            ),
          ),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            elevation: 3,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Texts(
                  title: "السلة",
                  fSize: 22,
                  color: Colors.black,
                ),
                IconButton(
                    icon: Icon(
                      Boxicons.bx_x,
                      size: 33,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      pop(context);
                    })
              ],
            ),
          ),
          body: Container(
            margin: EdgeInsets.only(top: 25),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40), color: greyColor),
            padding: EdgeInsets.all(18),
            child: ListView(
              shrinkWrap: true,
              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white),
                  child: ListView.separated(
                      padding: EdgeInsets.all(0),
                      separatorBuilder: (BuildContext context, int index) =>
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Divider(),
                          ),
                      itemCount: _marketProvider.carts.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (ctx, i) {
                        Cart cart = _marketProvider.carts[i];

                        return buildCartItem(cart,_marketProvider,widget.market);
                      }),
                ),
                Box(10),
                Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Texts(
                          title: "ملاحظات اضافية",
                          fSize: 17,
                          weight: FontWeight.w500,
                        ),
                        Box(10),
                        TextFields(
                          radius: 10,
                          horizontalMargin: 0,
                          lable: 'اكتب ملاحظاتك',
                        ),
                      ],
                    )),
                Box(10),
                // Container(
                //     height: 220,
                //     padding: EdgeInsets.all(10),
                //     decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(15),
                //         color: Colors.white),
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Box(10),
                //         Texts(
                //           title: "People also bought",
                //           fSize: 17,
                //           weight: FontWeight.w500,
                //         ),
                //         Box(10),
                //         _marketProvider.topFoodLoad
                //             ? Center(
                //                 child: SpinKitRing(
                //                   size: 25,
                //                   color: mainColor,
                //                   lineWidth: 5,
                //                   duration: Duration(milliseconds: 700),
                //                 ),
                //               )
                //             : Container(
                //                 height: 150,
                //                 child: ListView.builder(
                //                     padding: EdgeInsets.all(0),
                //                     scrollDirection: Axis.horizontal,
                //                     itemCount: _marketProvider.topFoods.length,
                //                     shrinkWrap: true,
                //                     itemBuilder: (ctx, i) {
                //                       Food food = _marketProvider.topFoods[i];
                //                       return Padding(
                //                         padding: const EdgeInsets.all(5.0),
                //                         child: Column(
                //                           crossAxisAlignment:
                //                               CrossAxisAlignment.start,
                //                           children: [
                //                             ClipRRect(
                //                                 borderRadius:
                //                                     BorderRadius.circular(50),
                //                                 child: CachedNetworkImage(
                //                                   imageUrl:
                //                                       filesUrl + food.image,
                //                                   height: 90,
                //                                   width: 90,
                //                                   fit: BoxFit.cover,
                //                                 )),
                //                             Box(5),
                //                             Container(
                //                               width: 100,
                //                               child: Texts(
                //                                 title: food.name,
                //                                 fSize: 12,
                //                                 weight: FontWeight.bold,
                //                                 color: Colors.black,
                //                               ),
                //                             ),
                //                             Box(5),
                //                             Texts(
                //                               title:
                //                                   "${food.price.toString()} ريال",
                //                               fSize: 13,
                //                               weight: FontWeight.w300,
                //                               color: Colors.grey,
                //                             ),
                //                           ],
                //                         ),
                //                       );
                //                     }),
                //               ),
                //       ],
                //     )),
                Box(10),
                Container(
                  padding: EdgeInsets.all(18),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Texts(
                            title: "سعر الطلبات",
                            fSize: 17,
                            color: Colors.black,
                            weight: FontWeight.bold,
                          ),
                          Texts(
                            title: _marketProvider.ordersPrice.toStringAsFixed(2)+"  ريال ",
                            fSize: 17,
                            color: Colors.black,
                            weight: FontWeight.bold,
                          ),
                        ],
                      ),
                      Box(18),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Texts(
                            title: "تكلفة التوصيل",
                            fSize: 17,
                            color: Colors.grey,
                            weight: FontWeight.w300,
                          ),
                          Texts(
                            title:(widget.market.distance*0.5).toStringAsFixed(2)+ "  ريال",
                            fSize: 17,
                            color: Colors.grey,
                            weight: FontWeight.w300,
                          ),
                        ],
                      ),
                      Box(18),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Texts(
                            title: "قيمة الضريبة 15 %",
                            fSize: 17,
                            color: Colors.grey,
                            weight: FontWeight.w300,
                          ),
                          Texts(
                            title:_marketProvider.tax.toStringAsFixed(2)+ "  ريال",
                            fSize: 17,
                            color: Colors.grey,
                            weight: FontWeight.w300,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Box(150),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class buildCartItem extends StatefulWidget {
  Cart cart;
  Market market;
   MarketProvider provider;
  buildCartItem(this.cart,this.provider,this.market);

  @override
  _buildCartItemState createState() => _buildCartItemState();
}

class _buildCartItemState extends State<buildCartItem> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 30,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  border: Border.all(width: 1, color: mainColor),
                  color: Colors.white),
              child: Center(
                  child: Texts(
                title: widget.cart.quantity.toString(),
                fSize: 15,
                color: Colors.black,
              )),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              width: 100,
              child: Texts(
                title: widget.cart.food.name,
                fSize: 18,
                weight: FontWeight.w300,
                color: Colors.black,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 30,
                  height: 30,
                  child: IconButton(
                      padding: EdgeInsets.all(0),
                      onPressed: () {

                        widget.provider.updateCart(widget.cart.id, 0);

                        if (widget.cart.quantity > 1) {
                          widget.cart.quantity--;

                        }else{
                          widget.provider.carts.remove(widget.cart);
                        }

                        widget.provider.calcordersPrice();

                        setState(() {
                        });
                      },
                      icon: Icon(
                        Icons.remove_circle,
                        color: Colors.grey,
                        size: 30,
                      )),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: 30,
                  height: 30,
                  child: IconButton(
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        widget.provider.updateCart(widget.cart.id, 0);

                        setState(() {
                          widget.cart.quantity++;
                        });
                        widget.provider.calcordersPrice();

                      },
                      icon: Icon(
                        Icons.add_circle,
                        color: mainColor,
                        size: 30,
                      )),
                )
              ],
            )
          ],
        ),
        Texts(
          title:widget.cart.food.price.toString()+" ريال ",
          fSize: 18,
          weight: FontWeight.w300,
          color: Colors.black,
        ),
      ],
    );
  }
}
