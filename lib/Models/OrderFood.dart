
import 'package:arkan/Models/Food.dart';

class OrderFood{
  Food food;
  int quantity;

  OrderFood.fromJson(json){
    food = Food.fromJson(json['food']);
    quantity = json['quantity'];
  }
}