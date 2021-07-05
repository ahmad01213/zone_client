

import 'Order.dart';
import 'OrderFood.dart';


class OrderDetail{
  Order order;
  List<OrderFood> foods = [];
  OrderDetail.fromJson(json){
    order = Order.fromJson(json['order']);
    json['items'].forEach((e){
      foods.add(OrderFood.fromJson(e));
    });
  }
}