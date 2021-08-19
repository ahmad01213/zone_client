import 'package:arkan/Providers/UserProvider.dart';
import 'package:arkan/helpers/helpers.dart';
import 'package:arkan/widgets/Buttons.dart';
import 'package:arkan/widgets/Texts.dart';
import 'package:arkan/widgets/textfields.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'SignUp.dart';

class SignInScreen extends StatelessWidget {
  String password;
  String email;
  UserProvider _userProvider;
  @override
  Widget build(BuildContext context) {
   if(_userProvider == null){
      _userProvider = Provider.of(context);
   }
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Texts(
              title: "تسجيل الدخول",
              weight: FontWeight.bold,
              fSize: 16,
              color: Colors.black,
            ),
            centerTitle: true,
            iconTheme: IconThemeData(
              color: Colors.black, //change your color here
            ),
            elevation: 0,
            backgroundColor: Colors.white,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 70,
                ),
                ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset("imgs/logo.png", height: 90)),
                SizedBox(
                  height: 25,
                ),

                SizedBox(
                  height: 15,
                ),
                TextFields(
                  onChange: (v){
                    email = v.toString();
                  },
                  lable: 'البريد الإلكتروني',
                ),
                SizedBox(
                  height: 15,
                ),
                TextFields(
                  onChange: (v){
                    password = v.toString();
                  },
                  lable: 'كلمة المرور',
                ),

                // InkWell(
                //     onTap: () {
                //       pushPage(context: context, page: SignUp());
                //     },
                //     child: Padding(
                //       padding: const EdgeInsets.symmetric(horizontal: 18),
                //       child: Align(
                //           alignment: Alignment.centerRight,
                //           child: Texts(
                //               title: "Forget Password", fSize: 12, color: mainColor)),
                //     )),
                SizedBox(
                  height: 25,
                ),
                   Container(
                  height: 60,
                  child: Buttons(
                    title: "تسجيل الدخول",
                    radius: 10,
                    horizontalMargin: 30,

                    onPressed: () async {
                       _userProvider.login(email: email,password: password,context: context);
                    },
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  height: 60,
                  child: Buttons(
                    title: "إنشاء حساب جديد",
                    radius: 10,
                    horizontalMargin: 30,
                    textColol: Colors.black,
                    bgColor: Colors.white,
                    onPressed: (){

                      pushPage(context: context,page: SignUp());
                    },
                  ),
                ),

                SizedBox(
                  height: 25,
                ),

                // buildSocialLoginBtn('التسجيل عبر جوجل', Colors.red, Colors.white,
                //     Colors.white, 'imgs/google.png', () {}),
                // buildSocialLoginBtn('التسجيل عبر فيسبوك', Colors.indigo,
                //     Colors.white, Colors.white, 'imgs/facebook.png', () {})
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildSocialLoginBtn(
    text,
    color,
    textColor,
    iconColor,
    image,
    press,
  ) {
    return InkWell(
      onTap: () {
        press();
      },
      child: Container(
        height: 50,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 40),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: color,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(
                1.0,
                0.9,
              ), //(x,y)
              blurRadius: 0.1,
            ),
          ],
        ),
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 18),
        child: Row(
          children: [
            Image.asset(
              image,
              height: 20,
              width: 20,
              color: iconColor,
            ),
            SizedBox(
              width: 30,
            ),
            Text(
              text,
              style: TextStyle(
                  fontSize: 17, fontWeight: FontWeight.bold, color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}
