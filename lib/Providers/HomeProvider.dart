import 'dart:convert';

import 'package:arkan/Models/Field.dart';
import 'package:arkan/Models/Market.dart';
import 'package:arkan/Models/Slider.dart';
import 'package:arkan/Models/User.dart';
import 'package:arkan/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class HomeProvider extends ChangeNotifier {
  List<Field> fields = [];
  List<Market> topRated = [];
  List<Market> readyToDeliver = [];
  List<Market> topPicks = [];
  List<Slide> sliders = [];
  bool loading =true;
  getHome() async {
  loading =true;

    fields = [];
    topRated = [];
    readyToDeliver = [];
     topPicks = [];
   sliders = [];
    final url = "$baseUrl/get-home";
    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body);
    print(response.body);
    if (response.statusCode == 200) {
      data['fields'].forEach((element) {
        fields.add(Field.fromJson(element));
      });
      data['mostrated'].forEach((element) {
        topRated.add(Market.fromJson(element));
      });
      data['readyfordeliver'].forEach((element) {
        readyToDeliver.add(Market.fromJson(element));
      });
      data['sliders'].forEach((element) {
        sliders.add(Slide.fromJson(element));
      });
      data['toppicks'].forEach((element) {
        topPicks.add(Market.fromJson(element));
      });

    } else {
    }
    loading = false;
    notifyListeners();
  }


  checkAuthintication(response, context) async {
    final data = jsonDecode(response.body);
    token = "Bearer " + data["token"];
    user = User.fromJson(data["customer"]);
    await saveToken();
  }

}