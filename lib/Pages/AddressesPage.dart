import 'package:arkan/Models/Address.dart';
import 'package:arkan/Pages/AddNewAddress.dart';
import 'package:arkan/Pages/CheckoutPage.dart';
import 'package:arkan/Pages/FoodDetail.dart';
import 'package:arkan/Providers/AddressesProvider.dart';
import 'package:arkan/helpers/helpers.dart';
import 'package:arkan/widgets/SizedBoxWidget.dart';
import 'package:arkan/widgets/Texts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
class AddressesPage extends StatelessWidget {
  AddressProvider _addressProvider;
  int totalPrice ;
  AddressesPage(this.totalPrice);
  @override
  Widget build(BuildContext context) {
    if(_addressProvider==null){
      _addressProvider = Provider.of(context);
      _addressProvider.listLoad = true;
      _addressProvider.getAddresses(context,10);
    }
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: greyColor,
          bottomSheet: Container(
            height: 100,
            child: InkWell(
              onTap: (){
                pushPage(context: context,page: AddNewAddress());

              },
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Center(
                  child: Texts(
                    title: ' +  أضف عنوان توصيل',
                    fSize: 22,
                    weight: FontWeight.w400,
                    color:mainColor,
                  ),
                ),
              ),
            ),
          ),
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 1,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                pop(context);
              },
            ), // icon depends on TargetPlattrom

            title: Texts(
              title: "اختر عنوان التوصيل",
              fSize: 16,
              color: Colors.black,
            ),
          ),
          body: _addressProvider.listLoad
              ? Center(
            child: SpinKitRing(
              size: 25,
              color: mainColor,
              lineWidth: 5,
              duration: Duration(milliseconds: 700),
            ),
          )
              :  ListView.builder(
              itemCount: _addressProvider.addresses.length,
              itemBuilder: (ctx, i) {
                Address address = _addressProvider.addresses[i];
                return InkWell(
                  onTap: (){
                    pushPage(context: context,page: CheckOutPage(address:_addressProvider.addresses[i],totalPrice: totalPrice,));
                  },
                  child: Container(
                    height: 220,
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
                                Row(children: [
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
                                        title: address.city+" , "+address.street,
                                        fSize: 22,
                                        color: Colors.black,
                                        weight: FontWeight.w300,
                                      ),

                                    ],
                                  ),
                                ],),
                                Box(10)

                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
