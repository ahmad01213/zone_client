import 'package:arkan/Pages/SignIn.dart';
import 'package:arkan/Pages/navigationPage.dart';
import 'package:arkan/Providers/UserProvider.dart';
import 'package:arkan/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  UserProvider _userProvider;
  initData(context) async {
    // signOut(ctx: context,page: SignInScreen());
    if(_userProvider==null){
      _userProvider=Provider.of(context);
     await readToken();
     await getLocation();
     if(user.id!=null){
       await _userProvider.getUserInfo(context: context,id: user.id);
       replacePage(context: context,page: NavigationPage());

     }else{
       replacePage(context: context,page: NavigationPage());

     }
    }
  }
  @override
  Widget build(BuildContext context) {
    initData(context);
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset('imgs/logo.png',height: 150,width: 150,))),
      ),
    );
  }

  @override
  void initState() {

    super.initState();
  }
}
