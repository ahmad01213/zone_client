
import 'package:arkan/Providers/UserProvider.dart';
import 'package:arkan/helpers/helpers.dart';
import 'package:arkan/widgets/Buttons.dart';
import 'package:arkan/widgets/Texts.dart';
import 'package:arkan/widgets/textfields.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class SignUp extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  var jsonMap = new Map<String,String>();
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
            title: Texts(title: "إنشاء حساب ",weight: FontWeight.bold, fSize: 18,color: Colors.black,),
            centerTitle: true,
            leading: IconButton(
              onPressed: (){
                pop(context);
              },
              icon: Icon(Icons.arrow_back),),
            iconTheme: IconThemeData(
              color: Colors.black,
              //change your color here
            ),
            elevation: 0,
            backgroundColor: Colors.white,
          ),
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(children: [
                SizedBox(height: 25,),
                ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset("imgs/logo.png", height: 90)),
                SizedBox(height: 25,),
                TextFields(
                  lable: "الإسم بالكامل",
                  onChange: (v){
                    jsonMap['name'] = v.toString();
                  },
                ),
                SizedBox(height: 15,),
                TextFields(
                  lable: "البريد الإلكتروني",
                  onChange: (v){
                    jsonMap['email'] = v.toString();
                  },
                ),
                SizedBox(height: 15,),
                TextFields(
                  lable: "رقم الهاتف",
                  keyboard: TextInputType.phone,
                  onChange: (v){
                    jsonMap['phone'] = v.toString();
                  },
                ),
                SizedBox(height: 15,),
                TextFields(
                  lable:" كلمة المرور",
                  onChange: (v){
                    jsonMap['password'] = v.toString();
                  },
                  isHidden: true,
                ),
                SizedBox(height: 25,),
                Container(
                  height: 60,
                  child: Buttons(
                    title: "إنشاء الحساب",
                    radius: 10,
                    horizontalMargin: 30,

                    onPressed: (){
                      if(_formKey.currentState.validate()){
                        _userProvider.register(jsoMap: jsonMap,context: context);

                      }
                    },
                  ),
                ),
                SizedBox(height: 25,),
              ],),
            ),
          ),
        ),
      ),
    );
  }
}
