import 'dart:convert';

import 'package:arkan/Models/Market.dart';
import 'package:arkan/helpers/helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
class FieldProvider extends ChangeNotifier {
  bool fieldMarketsLoad = true;
  List<Market> fieldMarkets = [];

  getFieldMarkets({int id}) async {
    fieldMarkets = [];
    final params = {
      "fieldId":id.toString(),
      "lat":locationData.latitude.toString(),
      "lng":locationData.longitude.toString()
    };
    final url = "$baseUrl/get-field-markets";
    final response = await http.post(Uri.parse(url),body:params);
    final data = jsonDecode(response.body);
    print(response.body);
    if (response.statusCode == 200) {
      data.forEach((element) {
        Market market =Market.fromJson(element['market']);
        market.distance = element['dist'].toDouble();

        fieldMarkets.add(market);
      });

    } else {
    }
    fieldMarketsLoad = false;
    notifyListeners();
  }
}