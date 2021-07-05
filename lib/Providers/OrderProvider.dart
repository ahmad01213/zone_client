import 'dart:convert';

import 'package:arkan/Models/Order.dart';
import 'package:arkan/Models/OrderDetails.dart';
import 'package:arkan/Pages/OrderDetail.dart';
import 'package:arkan/helpers/helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OrderProvider extends ChangeNotifier{

   bool startLoading = true;
  List<Order> orders = [] ;
  getCurrentOrders({ context,load=false}) async {
    print(user.id.toString());

    startLoading = true;
    if(load){
      notifyListeners();
    }
    orders = [];
    final url = "$baseUrl/user/get-orders";
    final body = {
      "id":user.id.toString()
    };
    final response = await http.post(Uri.parse(url), body: body);
    print(response.body);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      data.forEach((e){
        orders.add(Order.fromJson(e));
      });
    } else {
      print(response.body);
    }
    startLoading = false;
    notifyListeners();
  }

   bool addLoad = false;
   addOrder(context,Map<String,String> params) async {
     addLoad = true;
     notifyListeners();
     final url = "$baseUrl/add-order";
     final response = await http.post(Uri.parse(url),body:params);
     final data = jsonDecode(response.body);
     print(response.body);
     if (response.statusCode == 200) {
       getCurrentOrders(context: context,load: false);
       Order order = Order.fromJson(data);
       pop(context);

       replacePage(context: context,page: OrderDetailPage(order));

     } else {
     }
     addLoad = false;
     notifyListeners();
   }



   OrderDetail orderDetail ;
   getOrderDetail({orderId, context}) async {
     startLoading = true;
     final url = "$baseUrl/driver/get-order-detail";
     print("hey ${orderId}");
     final body = {
       "id":orderId.toString()
     };
     final response = await http.post(Uri.parse(url), body: body);
     if (response.statusCode == 200) {
       final data = jsonDecode(response.body);
       orderDetail = OrderDetail.fromJson(data);
     } else {
       print(response.body);
     }
     startLoading = false;
     notifyListeners();
   }
}