import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';


import 'helpers.dart';

class HelperFunctions {
  static HelperFunctions slt = HelperFunctions();

  notifyUser({context, message, color, bool isNeedPop = false}) {
    Flushbar(
      borderRadius: 8,
      padding: EdgeInsets.all(17),
      flushbarStyle: FlushbarStyle.GROUNDED,
      flushbarPosition: FlushbarPosition.BOTTOM,
      message: message,
      icon: Icon(
        Icons.circle,
        size: 28.0,
        color: Colors.white,
      ),
      duration: Duration(seconds: 3),
      backgroundColor: color,
      animationDuration: Duration(milliseconds: 400),
      leftBarIndicatorColor: color,
    )..show(context).whenComplete(() {
        if (isNeedPop) pop(context);
      });
  }


}
