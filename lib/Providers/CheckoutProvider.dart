import 'package:arkan/helpers/Functions.dart';
import 'package:arkan/helpers/helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class CheckOutProvider extends ChangeNotifier{


  bool addLoad = false;
  addOrder(context,Map<String,String> params) async {
    addLoad = true;
    notifyListeners();

    final url = "$baseUrl/add-order";
    final response = await http.post(Uri.parse(url),body:params);
    print(response.body);
    if (response.statusCode == 200) {
      await HelperFunctions.slt.notifyUser(context: context,message: "Added Successfully",color: Colors.green);


      // replacePage(context: context,page: AddressesPage());
    } else {
    }
    addLoad = false;
    notifyListeners();
  }

}