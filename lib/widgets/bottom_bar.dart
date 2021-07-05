import 'package:arkan/helpers/helpers.dart';
import 'package:flutter/material.dart';

import 'image_icon.dart';


class BottomNavBarView extends StatefulWidget {
  Function changePage;

  BottomNavBarView({this.changePage});

  @override
  _BottomNavBarViewState createState() => _BottomNavBarViewState();
}

class _BottomNavBarViewState extends State<BottomNavBarView> {
  int selectedIndex=0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        unselectedItemColor: Colors.black45,
        selectedLabelStyle: TextStyle(color: mainColor),
        selectedItemColor: socondColor,
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        iconSize: 30,
        onTap: (i){
          changeIndex(index: i);
        },
        unselectedLabelStyle: TextStyle(color: Colors.black45),
        items: [
          BottomNavigationBarItem(
            icon: ImageIconView(size: 30,name: 'cart.png',),
            label: 'متاجر',
          ),
          BottomNavigationBarItem(
            icon: ImageIconView(size: 30,name: 'orders.png',),
            label: 'الطلبات',
          ),
          BottomNavigationBarItem(
            icon: ImageIconView(size: 30,name: 'notification.png',),
            label: 'التنبيهات',
          ),
          BottomNavigationBarItem(
            icon: ImageIconView(size: 30,name: 'avatar.png',),
            label: 'الحساب',
          ),
    ]);
  }

  changeIndex({index}){
    setState(() {
       selectedIndex =index;
    });
    widget.changePage(index:index);
  }
}
