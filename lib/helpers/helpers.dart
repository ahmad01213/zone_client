import 'package:arkan/Models/User.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

pushPage({context, page}) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
}

var scaffoldKey = GlobalKey<ScaffoldState>();

showMessage(message){
  scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text(message)));

}
User user = new User();
final count =
ValueNotifier<int>(0);
String token;
int userId;
String isFirstLaunch;

saveToken() {
  final storage = new FlutterSecureStorage();
  storage.write(key: 'token', value: token);
  storage.write(key: 'id', value: userId.toString());
}

saveValue(key, value) {
  final storage = new FlutterSecureStorage();
  storage.write(key: key, value: value);
}

isRegistered() {
  return token != null;
}

signOut({ctx, page}) async {
  final storage = new FlutterSecureStorage();
  token = null;
  await storage.delete(key: "token");
  await storage.delete(key: "id");
  replacePage(context: ctx, page: page);
}

isFirst() {
  return isFirstLaunch == null;
}
readToken() async {
  final storage = new FlutterSecureStorage();
  token = await storage.read(key: "token");
  final id = await storage.read(key: "id");
  print("storage :" +id.toString());
 if(id!=null) user.id = int.parse(id) ;
}

replacePage({context, page}) {
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => page));
}

final defaultShadow = BoxShadow(
  color: Colors.black.withOpacity(0.1),
  spreadRadius: 1,
  blurRadius: 1,
  offset: Offset(0, 1), // changes position of shadow
);

pop(context) {
  Navigator.of(context).pop();
}

final baseUrl = "http://tall3ah.site/mobile";
final filesUrl = "http://tall3ah.site/uploads/";
final baseDashboardUrl = "http://tall3ah.site";
String userRole = 'user';
double screenWidth;
double screenHight;
bool isTablet() {
  final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
  return data.size.shortestSide > 600;
}
const mainColor = Colors.black;
const textColor = Color(0xFF343A40);
const socondColor = Colors.blue;
const thirdColor = Colors.blue;
Color greyColor = Colors.grey.withOpacity(0.1);
titleText({title,color = mainColor,fSize = 15.0,isBold = false}){
  return Text(
    title,
    maxLines: 3,
    textAlign: TextAlign.start,
    style: TextStyle(fontSize: fSize,color: color,fontWeight: isBold?FontWeight.bold:FontWeight.normal),);
}
subTitleText({title,color = Colors.black45,fSize = 12.0,isBold=false}){
  return Text(
    title,
    maxLines: 5,
    textAlign: TextAlign.start,
    style: TextStyle(fontSize: fSize,color: color,fontWeight: FontWeight.bold),);
}


LatLng locationData = LatLng(23,39);

getLocation() async {
  Location location = new Location();
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      return;
    }
  }
  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      return;
    }
  }
  final loc= await location.getLocation();
  locationData = LatLng(loc.latitude, loc.longitude);
  print(locationData.latitude.toString()+" lat:");
}



List<String> imgs = [
  "4.png",
  "3.png",
  "4.png",
  "2.png",
  "3.png",
  "2.png",
  "3.png",
  "4.png",
  "2.png",
  "3.png",
  "2.png",
  "3.png",
  "4.png",
  "2.png",
  "3.png",
  "2.png",
  "3.png",
  "4.png",
  "2.png",
  "3.png",
  "2.png",
  "3.png",
  "4.png",
  "2.png",
  "3.png",
  "2.png",
  "3.png",
  "4.png",
  "2.png",
  "3.png",
  "2.png",
  "3.png",
  "4.png",
  "2.png",
  "3.png",
  "2.png",
  "3.png",
  "4.png",
  "2.png",
  "3.png",
  "2.png",
  "3.png",
  "4.png",
  "2.png",
  "3.png",
  "2.png",
  "3.png",
  "4.png",
  "2.png",
  "3.png",
];

