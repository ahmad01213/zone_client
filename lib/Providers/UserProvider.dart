import 'dart:convert';
import 'package:arkan/Models/Market.dart';
import 'package:arkan/Models/User.dart';
import 'package:arkan/Models/UserNotification.dart';
import 'package:arkan/Pages/navigationPage.dart';
import 'package:arkan/helpers/helpers.dart';
import 'package:arkan/widgets/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class UserProvider extends ChangeNotifier {


  bool loading =false;
  login({email, password, context, Function onFaild}) async {
    print(password);
    showMyCustomLoadingDialog(context);
    var jsoMap = Map();
    jsoMap['email'] = email;
    jsoMap['password'] = password;
    final url = "$baseUrl/user/login";
    final response = await http.post(Uri.parse(url), body: jsoMap);
    print(response.body);
    if (response.statusCode == 200) {
      checkAuthintication(response, context);
    } else {
      print(response.body);
      // HelperFunctions.slt.notifyUser(context: context,color: Colors.red,message: response.body);
    }
    pop(context);
    notifyListeners();
  }


  register({
    Map<String, String> jsoMap,
    context,
  }) async {
    showMyCustomLoadingDialog(context);
    jsoMap['role'] = 'user';
    jsoMap['image'] = '1.png';
    jsoMap['device_token'] = 'none';
    notifyListeners();
    final url = "$baseUrl/user/register";
    final response = await http.post(Uri.parse(url), body: jsoMap);
    print(response.body);
    if (response.statusCode == 200) {
      checkAuthintication(response, context);
    } else {
      print(response.body);
      // HelperFunctions.slt.notifyUser(context: context,color: Colors.red,message: response.body);
    }

    pop(context);
    notifyListeners();
  }
  List<Market> searchMarkets = [];
  searchMarket({text, context}) async {
    searchMarkets = [];
    final url = "$baseUrl/driver/search-markets";
    final body = {
      "lat": locationData.latitude.toString(),
      "lng": locationData.longitude.toString(),
      "searchText":text
    };
    final response = await http.post(Uri.parse(url), body: body);
    if (response.statusCode == 200) {

      final data = jsonDecode(response.body);
      data.forEach((element) {
        Market market = Market.fromJson(element['market']);
        market.distance = element['dist'];
        searchMarkets.add(market);
      });
    } else {
      print(response.body);
    }
    notifyListeners();
  }


  getUserInfo({id, context}) async {
    final url = "$baseUrl/user/get-info";
    final body = {

      "id":id.toString()
    };
    final response = await http.post(Uri.parse(url), body: body);
    print(response.body);

    if (response.statusCode == 200) {
      print('userId :'+id.toString());

      final data = jsonDecode(response.body);
      print(data);

      user = User.fromJson(data);
    } else {
      print(response.body);
    }
    notifyListeners();
  }


  checkAuthintication(response, context) async {
    final data = jsonDecode(response.body);
    token = "Bearer " + data["token"];
    user = User.fromJson(data["customer"]);
    userId = user.id;
    await saveToken();
    pushPage(context: context,page: NavigationPage());
  }



  List<UserNotification> notifications = [] ;
  bool startLoading;
  getNotifications({ context,first=false}) async {
    startLoading = true;
    notifications = [];
   if(!first) notifyListeners();
    final url = "$baseUrl/user/get-notifications";
    final body = {
      "id":user.id.toString()
    };
    final response = await http.post(Uri.parse(url), body: body);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      data.forEach((element){
        notifications.add(UserNotification.fromJson(element));
      });
    } else {
      print(response.body);
    }
    startLoading = false;
    notifyListeners();
  }



}