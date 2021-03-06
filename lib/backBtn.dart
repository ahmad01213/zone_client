import 'package:flutter/material.dart';
class BackBtn extends StatelessWidget {
  Color color;

  BackBtn({this.color=Colors.black});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Align(
        alignment: Alignment.topLeft,
        child: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back_ios,
              size: 25,
              color:color,
            )),
      ),
    );
  }


}
