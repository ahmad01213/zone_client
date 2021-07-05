import 'dart:convert';
import 'package:arkan/Models/Address.dart';
import 'package:arkan/Pages/AddNewAddress.dart';
import 'package:arkan/helpers/Functions.dart';
import 'package:arkan/helpers/helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class AddressProvider extends ChangeNotifier{
  bool listLoad = true;
  List<Address> addresses = [];
  getAddresses(context,id) async {
    final url = "$baseUrl/get-user-addresses";
    final response = await http.post(Uri.parse(url),body:{"id":id.toString()});
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      addresses = [];
      data.forEach((element) {
        addresses.add(Address.fromJson(element));
      });
      if(addresses.isEmpty){
        replacePage(context: context,page: AddNewAddress());
      }
    } else {
    }
    listLoad = false;
    notifyListeners();
  }



  bool addLoad = false;
  addNewAddress(context,Map<String,String> params) async {
    addLoad = true;
    notifyListeners();
    params['user_id']="10";
    params['lat']="22.33";
    params['lng']="32.1";
    final url = "$baseUrl/add-address";
    final response = await http.post(Uri.parse(url),body:params);
    if (response.statusCode == 200) {
     await HelperFunctions.slt.notifyUser(context: context,message: "Address Saved Successfully",color: Colors.green);
     await getAddresses(context,10);
     pop(context);
     pop(context);

    // replacePage(context: context,page: AddressesPage());
    } else {
    }
    addLoad = false;
    notifyListeners();
  }
}