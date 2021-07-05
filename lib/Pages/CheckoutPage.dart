import 'package:arkan/Models/Address.dart';
import 'package:arkan/Pages/pay.dart';
import 'package:arkan/Pages/paymentpage.dart';
import 'package:arkan/Providers/CheckoutProvider.dart';
import 'package:arkan/helpers/helpers.dart';
import 'package:arkan/widgets/Buttons.dart';
import 'package:arkan/widgets/SizedBoxWidget.dart';
import 'package:arkan/widgets/Texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_fatoorah/my_fatoorah.dart';
import 'package:provider/provider.dart';

class CheckOutPage extends StatefulWidget {
  Address address;
  int totalPrice;
  CheckOutPage({this.address, this.totalPrice});
  @override
  _CheckOutPageState createState() => _CheckOutPageState();
}
class _CheckOutPageState extends State<CheckOutPage> {
  int selectedIndex;
  CheckOutProvider _checkOutProvider;
  @override
  Widget build(BuildContext context) {
    if(_checkOutProvider==null){
      _checkOutProvider = Provider.of(context);
    }
    return Container(
      color: Colors.white,
      child: SafeArea(
          child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 3,
          leading: IconButton(
            icon: Icon(
              Boxicons.bx_arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              pop(context);
            },
          ), // icon depends on TargetPlattrom

          title: Texts(
            title: "Checkout",
            fSize: 16,
            color: Colors.black,
          ),
        ),
        body: ListView(
          children: [
            Container(
              height: 200,
              margin: EdgeInsets.all(20),
              width: double.infinity,
              child: Card(
                margin: EdgeInsets.all(0),
                child: Column(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.network(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZuiefT_KDbBbPL3-aa1r6oIN3AMVhx-J24A&usqp=CAU',
                          height: 120,

                          width: screenWidth,
                          fit: BoxFit.cover,
                        )),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'imgs/pin.png',
                                height: 30,
                                fit: BoxFit.fill,
                              ),
                              SizedBox(
                                width: 13,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Texts(
                                    title: 'Selected Location',
                                    fSize: 19,
                                    color: mainColor,
                                    weight: FontWeight.bold,
                                  ),
                                  Texts(
                                    title: widget.address.city +
                                        " , " +
                                        widget.address.street,
                                    fSize: 22,
                                    color: Colors.black,
                                    weight: FontWeight.w300,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Box(10),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50)),
                color: greyColor,
              ),
              child: Column(
                children: [
                  ListView.builder(
                      itemCount: 4,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (ctx, i) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 30),
                              child: Row(
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Image.asset(
                                        'imgs/' + icons[i],
                                        height: 40,
                                        width: 70,
                                        fit: BoxFit.fill,
                                      )),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Texts(
                                    title: names[i],
                                    fSize: 23,
                                    color: Colors.black,
                                    weight: FontWeight.w300,
                                  )
                                ],
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                selectedIndex == i? Icons.radio_button_checked:Icons.radio_button_off,
                                size: 30,
                                color: selectedIndex != i?Colors.grey:mainColor,
                              ),
                              onPressed: () {
                                setState(() {
                                  selectedIndex = i;
                                });
                              },
                            )
                          ],
                        );
                      }),
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
                              title: "Subtotal",
                              fSize: 17,
                              color: Colors.black,
                              weight: FontWeight.bold,
                            ),
                            Texts(
                              title: " 4.000 KD",
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
                              title: "Delivery fee",
                              fSize: 17,
                              color: Colors.grey,
                              weight: FontWeight.w300,
                            ),
                            Texts(
                              title: " 0.250 KD",
                              fSize: 17,
                              color: Colors.grey,
                              weight: FontWeight.w300,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Box(10),
                  Container(
                    padding: EdgeInsets.all(18),
                    height: 140,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Texts(
                                title: "Total",
                                fSize: 17,
                                color: Colors.black,
                                weight: FontWeight.bold,
                              ),
                              Texts(
                                title: " ${widget.totalPrice} KD",
                                fSize: 17,
                                color: Colors.black,
                                weight: FontWeight.bold,
                              ),
                            ],
                          ),
                        ),
                        Box(18),
                        _checkOutProvider.addLoad
                            ? Center(
                          child: SpinKitRing(
                            size: 37,
                            color: mainColor,
                            lineWidth: 3,
                            duration: Duration(milliseconds: 700),
                          ),
                        )
                            :  Container(
                          height: 40,
                          child: Buttons(
                            title: "Place Order",
                            fSize: 15,
                            bgColor: mainColor,
                            horizontalMargin: 0,
                            radius: 15,
                            onPressed: () {
                             // pushPage(context: context,page: MyHomePage());

                              Map<String,String> params={
                                'address_id': widget.address.id.toString(),
                                'user_id': '10',
                                'status': 'preparing'
                              };
                              // _checkOutProvider.addOrder(context, params);
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
  @override
  void initState() {
    super.initState();
  }
  final icons = ['card1.png', 'card2.png', 'card3.png', 'cash.png'];

  final names = ['KNET', 'MasterCard', 'American Express', 'Cash on Delivery'];
}
