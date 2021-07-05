import 'package:arkan/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'SignIn.dart';
class Account extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 1,
        title: titleText(title: 'حسابي', color: Colors.black, fSize: 20.0),

      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Icon(Icons.account_circle_outlined,size: 100,color: socondColor,)
                ),
                SizedBox(
                  width: 50,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    titleText(
                        title: user.name, color: Colors.black),

                    subTitleText(title:user.phone, color: Colors.black),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 50,
          ),
          rowItem(key: 'رصيد الحساب', value: "32", isFirst: true),
          // rowItem(key: 'إجمالي رسوم التوصيل', value: "120  ريال"),
          // rowItem(key: 'إجمالي الفواتير المدفوعة', value: "120"),
          rowItem(key: 'عدد الطلبات', value: "3"),
          InkWell(
            onTap: (){
              signOut(ctx: context,page:SignInScreen() );

            },
            child:  rowItem(key: "تسجيل الخروج", value: "",),
          )

        ],
      ),
    );
  }

  rowItem({key, value, isFirst = false}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          border: Border(
            bottom: BorderSide(
              width: 0.5,
              color: Colors.black45,
            ),
            top: isFirst
                ? BorderSide(
                    width: 0.5,
                    color: Colors.black45,
                  )
                : BorderSide(
                    width: 0,
                    color: Colors.transparent,
                  ),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          titleText(fSize: 16.0, color: Colors.black54, title: key),
          titleText(fSize: 17.0, title: value, color: mainColor)
        ],
      ),
    );
  }
}
