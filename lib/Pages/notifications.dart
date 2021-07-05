import 'package:arkan/Providers/UserProvider.dart';
import 'package:arkan/helpers/helpers.dart';
import 'package:arkan/widgets/SizedBoxWidget.dart';
import 'package:arkan/widgets/Texts.dart';
import 'package:arkan/widgets/notification_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';


class NotificationPage extends StatelessWidget {
  UserProvider _userProvider;
  initData(context) async {
    if (_userProvider == null) {
      _userProvider = Provider.of(context);
      _userProvider.getNotifications(context: context,first: true);
    }
  }
  @override
  Widget build(BuildContext context) {
    initData(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Box(1),
            Texts(
              title: "التنبيهات",
              fSize: 17,
              weight: FontWeight.bold,
              color: Colors.black,
            ),
            IconButton(
              onPressed: (){
                _userProvider.startLoading = true;
                _userProvider.getNotifications(context: context);
              },
              icon: Icon(
                Icons.refresh_outlined,
                size: 40,
                color: socondColor,
              ),
            )
          ],
        ),
        elevation: 0,

      ),


      body:_userProvider.startLoading? Center(
        child: SpinKitRing(
          size: 60,
          color: mainColor,
          lineWidth: 7,
          duration: Duration(milliseconds: 600),
        ),
      ): ListView.separated(
          separatorBuilder: (BuildContext context, int index) =>
              Divider(height: 1),
          itemCount: _userProvider.notifications.length,
          physics: BouncingScrollPhysics(),
          itemBuilder: (ctx, i) {
            return NotificationItem(_userProvider.notifications[i]);
          }),
    );
  }
}
