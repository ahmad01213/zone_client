import 'dart:convert';

import 'package:arkan/Models/Option.dart';
import 'package:arkan/Models/OptionGroup.dart';
import 'package:arkan/helpers/Functions.dart';
import 'package:arkan/helpers/helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class FoodProvider extends ChangeNotifier{
  bool loading = true;
  bool cartLoad = false;
  addCart(context,params) async {
    cartLoad = true;
    notifyListeners();
    final url = "$baseUrl/add-cart";
    final response = await http.post(Uri.parse(url), body: params);
    print(response.body);
    if (response.statusCode == 200) {
      HelperFunctions.slt.notifyUser(context: context,color: Colors.green,message: "تمت الإضافة للسلة");
    } else {
    }
    cartLoad = false;
    notifyListeners();
  }
  List<OptionGroup> options = [];
  getFoodDetails(int id) async {
    options = [];
    final url = "$baseUrl/get-food-detail";
    final response = await http.post(Uri.parse(url),body: {"id":id.toString()});
    final data = jsonDecode(response.body);
    print(response.body);
    if (response.statusCode == 200) {
      data.forEach((element) {
        OptionGroup optionGroup  =OptionGroup.fromJson(element['optionGroup']);
        optionGroup.options =   element['options'].map<Option>((data) => Option.fromJson(data))
            .toList();
        options.add(optionGroup);

      });
    } else {
    }
    loading = false;
    notifyListeners();
  }
}