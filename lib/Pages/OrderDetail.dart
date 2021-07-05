import 'package:arkan/Models/Order.dart';
import 'package:arkan/Models/OrderFood.dart';
import 'package:arkan/Providers/OrderProvider.dart';
import 'package:arkan/helpers/helpers.dart';
import 'package:arkan/widgets/SizedBoxWidget.dart';
import 'package:arkan/widgets/Texts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
class OrderDetailPage extends StatelessWidget {
  Order order;
  OrderDetailPage(this.order);
  OrderProvider _orderProvider;
  initData(context) async {
    if (_orderProvider == null) {
      _orderProvider = Provider.of(context);
      _orderProvider.orderDetail=null;
      _orderProvider.getOrderDetail(orderId: order.id,context: context,);
    }
  }
  @override
  Widget build(BuildContext context) {
    initData(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: IconButton(
          onPressed: ()=>pop(context),
          icon: Icon(Icons.arrow_back,
            size: 20,)
        ),
        title: Texts(
          fSize: 16,
          title: "طلب رقم  :  " + order.id.toString(),
          color: Colors.black,
          weight: FontWeight.bold,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body:_orderProvider.startLoading?Center(
        child: SpinKitRing(
          size: 60,
          color: mainColor,
          lineWidth: 7,
          duration: Duration(milliseconds: 600),
        ),
      ): Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [


            Box(10),
            Padding(
                child: titleText(
                    title: "حالة الطلب", color: socondColor, isBold: true),
                padding: EdgeInsets.all(20)),
            Box(10),
           if(_orderProvider.orderDetail!=null) buildStepperView(status: _orderProvider.orderDetail.order.status),
            Box(30),
            Container(height: 5,color: Colors.grey.withOpacity(0.6),),
            Box(10),

            Padding(
                child: titleText(
                    title: "تفاصيل الطلب", color: socondColor, isBold: true),
                padding: EdgeInsets.all(20)),
            Box(10),
            buildOrderItemsList()
          ],
        ),
      ),
    );
  }

    buildStepperView({int status}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.pin_drop_outlined,
                color: Colors.green,
                size: 40,
              ),
              Expanded(
                  child: Container(
                height: 1,
                color: status > 1 ? Colors.black : Colors.grey,
              )),
              Icon(
                Icons.store,
                color: status > 1 ? Colors.green : Colors.grey,
                size: 40,
              ),
              Expanded(
                  child: Container(
                height: 1,
                color: status > 2 ? Colors.black : Colors.grey,
              )
              ),
              Icon(
                Icons.delivery_dining,
                color: status > 1 ? Colors.green : Colors.grey,
                size: 40,
              ),
              Expanded(
                  child: Container(
                height: 1,
                color: status > 3 ? Colors.black : Colors.grey,
              )),
              Icon(
                Icons.account_circle,
                color: status > 3 ? Colors.green : Colors.grey,
                size: 40,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  width: 60,
                  child: Texts(
                    title: "جاري البحث عن مندوب",
                    fSize: 13,
                    align: TextAlign.center,
                    color: Colors.black,
                    lines: 3,
                  )),
              Container(
                  width: 60,
                  child: Texts(
                    title: "في انتظار المندوب",
                    fSize: 13,
                    align: TextAlign.center,
                    color: status > 1 ? Colors.black : Colors.grey,
                    lines: 3,
                  )),
              Container(
                  width: 80,
                  child: Texts(
                    title: "جاري التوصيل للعميل",
                    fSize: 13,
                    align: TextAlign.center,
                    color: status > 2 ? Colors.black : Colors.grey,
                    lines: 2,
                  )),
              Container(
                  width: 60,
                  child: Texts(
                    title: "تم التسليم للعميل",
                    fSize: 13,
                    align: TextAlign.center,
                    color: status > 3 ? Colors.black : Colors.grey,
                    lines: 3,
                  ))
            ],
          ),
          Box(25),
        ],
      ),
    );
  }
  buildOrderItemsList(){
    return _orderProvider.orderDetail==null?Container(): ListView.separated(
        separatorBuilder: (BuildContext context, int index) => Divider(height: 1),
        itemCount: _orderProvider.orderDetail.foods.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (ctx,i){
          OrderFood orderFood = _orderProvider.orderDetail.foods[i];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: orderFood.food.image,
                  height: 70,
                  width: 70,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 20,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      titleText(title:orderFood.food.name ),
                      SizedBox(width: 30,),
                      titleText(title:"السعر  :  ${orderFood.food.price.toString()} ريال",color: Colors.green ),

                    ],
                  ),
                  SizedBox(width: 20,),
                  subTitleText(title: "الكمية  :  ${orderFood.quantity.toString()}"),

                ],
              )
            ],
          ),
        );
    });
  }

  List statusStrings = [
    "قبول الطلب",
    "في انتظار المندوب",
    "تم استلام الطلب من المتجر",
    "تم التسليم للعميل"
  ];
  checkStatus({int status, onPress}) {
    return statusStrings[status -1];
  }
}
