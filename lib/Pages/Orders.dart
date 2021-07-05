import 'package:arkan/Pages/OrderDetail.dart';
import 'package:arkan/Providers/OrderProvider.dart';
import 'package:arkan/helpers/helpers.dart';
import 'package:arkan/widgets/RatingBar.dart';
import 'package:arkan/widgets/SizedBoxWidget.dart';
import 'package:arkan/widgets/Texts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
class Orders extends StatelessWidget {
  OrderProvider _orderProvider;
  @override
  Widget build(BuildContext context) {
    if(_orderProvider == null){
      _orderProvider = Provider.of(context);
      _orderProvider.getCurrentOrders(context: context);
    }
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.2),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Box(1),
            Texts(
              title: "الطلبات",
              fSize: 17,
              weight: FontWeight.bold,
              color: Colors.black,
            ),
            IconButton(
              onPressed: (){
                _orderProvider.startLoading = true;
                _orderProvider.getCurrentOrders(context: context,load :true);
              },
              icon: Icon(
                Icons.refresh_outlined,
                size: 40,
                color: socondColor,
              ),
            )
          ],
        ),
        elevation: 0,

      ),
      body:_orderProvider.startLoading
          ? Center(
        child: SpinKitRing(
          size: 60,
          color: mainColor,
          lineWidth: 7,
          duration: Duration(milliseconds: 600),
        ),
      )
          : ListView.builder(
          itemCount: _orderProvider.orders.length,
          padding: EdgeInsets.only(top: 30),
          itemBuilder: (ctx, i) {
            return InkWell(
              onTap: (){
                pushPage(context: context,page: OrderDetailPage(_orderProvider.orders[i]));
              },
              child: Container(
                width: double.infinity,
                height: 200,
                child: Card(
                  elevation: 0,
                  margin: EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Texts(
                              title: checkStatus(_orderProvider.orders[i].status==0?_orderProvider.orders[i].status:(_orderProvider.orders[i].status-1)),
                              fSize: 17,
                              color: Colors.black,
                            ),
                            Texts(
                              title: _orderProvider.orders[i].date,
                              fSize: 13,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                        Box(5),
                        Divider(),
                        Box(5),
                        Row(
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(70),
                                child: Image.network(
                                  _orderProvider.orders[i].marketimage ,
                                  height: 50,
                                  width: 50,
                                )),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Texts(
                                  title: _orderProvider.orders[i].marketname,
                                  fSize: 14,
                                  color: Colors.grey,
                                ),
                                Row(
                                  children: [
                                    RatingBarWidget(
                                      ratingValue: _orderProvider.orders[i].rate.toDouble(),
                                      emptColor: Colors.grey,
                                      ignorGesture: true,
                                      itemSize: 15,
                                      direction: TextDirection.rtl,
                                      fillColor: Colors.orangeAccent,
                                    ),
                                    Texts(
                                      title:"  "+ _orderProvider.orders[i].rate.toString()+" ",
                                      fSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                        Box(5),
                        Divider(),
                        Box(5),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }



  List statuses = [
    "قبول الطلب",
    "في انتظار المندوب",
    "تم استلام الطلب من المتجر",
    "تم التسليم للعميل"
  ];
  checkStatus(int status){
    print(status);
    return  statuses[status==0?status:(status-1)];
  }
}
