import 'dart:convert';
import 'package:arkan/Models/Cart.dart';
import 'package:arkan/Models/Category.dart';
import 'package:arkan/Models/Food.dart';
import 'package:arkan/Models/Market.dart';
import 'package:arkan/helpers/helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
class MarketProvider extends ChangeNotifier{
  List<Food> foods = [];
  List<Food> topFoods = [];
  Market market;
  List<Catagory> categories = [];
  bool loading = false;
  bool catLoad = false;
  getMarkeCategoryFoods({int catId,int marketId}) async {
    print("data : $catId $marketId");
    foods = [];
    final url = "$baseUrl/get-category-foods";
    final response = await http.post(Uri.parse(url),body: {"categoryId":catId.toString(),"marketId":marketId.toString()});
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      data.forEach((element) {
        foods.add(Food.fromJson(element));
      });
      print('hey: ${foods.length.toString()}');
    } else {
    }
    loading = false;
    notifyListeners();
  }

  getCategories() async {
    final url = "$baseDashboardUrl/dashboard/category/get-categories";
    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      categories = [];

      data.forEach((element) {
        categories.add(Catagory.fromJson(element));

      });
      getCarts();
    } else {
    }
    catLoad = false;
    notifyListeners();
  }
  bool topFoodLoad = true;
  getTopFoods(id) async {
    final url = "$baseDashboardUrl/mobile/get-top-foods";
    final response = await http.post(Uri.parse(url),body:{"id":id.toString()});
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      topFoods = [];
      data.forEach((element) {
        topFoods.add(Food.fromJson(element));
      });
    } else {
    }
    topFoodLoad = false;
    notifyListeners();
  }


  List<Cart> carts = [];
  double ordersPrice = 0;
  double wholePrice = 0;
  double deliveryFee = 0;
  double tax = 0;
   getCarts() async {
    final url = "$baseDashboardUrl/mobile/get-carts";
    final response = await http.post(Uri.parse(url),body:{"id":user.id.toString()});
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      carts = [];
      data.forEach((element) {
        final cart = Cart.fromJson(element['cart']);
        cart.food = Food.fromJson(element['food']);
        carts.add(cart);

      });
      calcordersPrice();

    } else {
    }
    notifyListeners();
  }


  calcordersPrice(){
    ordersPrice=0;
    carts.forEach((cart) {
      ordersPrice+=(cart.food.price*cart.quantity);
    });

    double subtotal = ordersPrice+deliveryFee;
    tax = subtotal*0.5;

    wholePrice = subtotal+tax;
     notifyListeners();
  }


  updateCart(id,status) async {
    final url = "$baseUrl/update-cart-quantity";
   await http.post(Uri.parse(url),body:{"id":id.toString(),'status':status.toString()});
   notifyListeners();
  }

}