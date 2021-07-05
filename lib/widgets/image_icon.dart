import 'package:flutter/material.dart';
class ImageIconView extends StatelessWidget {
 final String name;
 final Color color;
 final double size;
 ImageIconView({this.name, this.color,this.size = 20});
  @override
  Widget build(BuildContext context) {
    return
     ImageIcon(
      AssetImage('imgs/$name'),
      size: size,
      color: color,
     );
  }
}
