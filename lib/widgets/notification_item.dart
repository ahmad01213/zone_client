import 'package:arkan/Models/UserNotification.dart';
import 'package:arkan/helpers/helpers.dart';
import 'package:flutter/material.dart';
class NotificationItem extends StatelessWidget {
  UserNotification notification;

  NotificationItem(this.notification);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Image.network(
            notification.image,
            height: 70,
            width: 70,
            fit: BoxFit.fill,
          ),
        )
        ,SizedBox(width: 15,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            titleText(title: notification.body,color: Colors.black54)
    ,SizedBox(width: 15,),
            subTitleText(title: notification.date,color: socondColor),
          ],
        )

      ],),
    );
  }
}
