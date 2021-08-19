import 'package:arkan/Pages/Home.dart';
import 'package:arkan/Pages/SignIn.dart';
import 'package:arkan/helpers/helpers.dart';
import 'package:arkan/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'Orders.dart';
import 'account.dart';
import 'notifications.dart';
class NavigationPage extends StatefulWidget {
  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: IndexedStack(
          children: pages,
          index: currentIndex,
        ),
      bottomNavigationBar: BottomNavBarView(changePage: changeScreen,)
    );
  }

 @override
  void initState() {
   super.initState();
  }

  List<Widget> pages = [
    Home(),
    Orders(),
    NotificationPage(),
    user.id==null?SignInScreen():Account(),
  ];
  changeScreen({index}){
      setState(() {
        currentIndex = index;
      });
  }
}
