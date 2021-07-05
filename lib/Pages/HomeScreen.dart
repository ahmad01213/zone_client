import 'package:arkan/Models/Field.dart';
import 'package:arkan/Models/Market.dart';
import 'package:arkan/Pages/CategoryDetails.dart';
import 'package:arkan/Pages/SignIn.dart';
import 'package:arkan/Providers/HomeProvider.dart';
import 'package:arkan/helpers/helpers.dart';
import 'package:arkan/widgets/SizedBoxWidget.dart';
import 'package:arkan/widgets/Texts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../widgets/home_slider.dart';

class HomeScreen extends StatelessWidget {
  HomeProvider _homeProvider;
  @override
  Widget build(BuildContext context) {
    if (_homeProvider == null) {
      _homeProvider = Provider.of(context);
      _homeProvider.getHome();
      screenWidth = MediaQuery.of(context).size.width;
      screenHight = MediaQuery.of(context).size.height;
    }
    return Container(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey.withOpacity(0.2),
          key: scaffoldKey,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(68),
            child: AppBar(
              centerTitle: true,
              automaticallyImplyLeading: false,
              // this will hide Drawer hamburger icon
              actions: <Widget>[Container()],
              elevation: 0,
              title: Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        showLocationPicker(
                            context, "AIzaSyDFZhFfswZpcjeUDYm6C7H46JLdSonK0f4",
                            initialCenter: LatLng(31.1975844, 29.9598339),
                            myLocationButtonEnabled: true,
                            layersButtonEnabled: false,
                            language: "ar",
                            appBarColor: Colors.white,
                            searchBarBoxDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            )
                            // countries: ['AE', 'NG'],
                            );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Texts(
                                  title: "التوصيل إلي ",
                                  fSize: 15,
                                  color: Colors.black54,
                                ),
                                Texts(
                                  title: "الحمرا",
                                  fSize: 18,
                                  color: Colors.black,
                                  weight: FontWeight.bold,
                                ),
                              ],
                            ),
                            SizedBox(width: 10,),
                            Icon(Icons.arrow_drop_down_outlined,size: 20,color: Colors.black,)
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              backgroundColor: Colors.white,
            ),
          ),
          body:  _homeProvider.loading
              ? Center(
                child: SpinKitRing(
                  size: 25,
                  color: mainColor,
                  lineWidth: 5,
                  duration: Duration(milliseconds: 700),
                ),
              )
              : ListView(
            shrinkWrap: true,
                children: [
                  Container(
                      height: 150,
                      child: HomeSlider(
                        imagesUrlList: _homeProvider.sliders,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.45,
                        autoPlay: false,
                      )),
                  Container(
                    width: double.infinity,
                    color: Colors.white,
                    margin: EdgeInsets.only(top: 5),
                    height: 50,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 15.0, left: 15),
                          child: Icon(
                            Icons.search,
                            size: 30,
                            color: Colors.black54,
                          ),
                        ),
                        Texts(
                          title: "ابحث عن متجر ، مطعم كافي أو أي مكان",
                          fSize: 17,
                          color: Colors.black54,
                        )
                      ],
                    ),
                  ),
                Box(20)
,                buildFieldList(_homeProvider.fields)
                ],
              ),
          drawer: Drawer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 56,
                ),
                InkWell(
                  onTap: () {
                    // showMaterialModalBottomSheet(
                    //     duration: Duration(milliseconds: 300),
                    //     backgroundColor: Colors.transparent,
                    //     context: context,
                    //     builder: (context) =>SignInSheet()
                    // );

                    pushPage(context: context, page: SignInScreen());
                  },
                  child: Container(
                    height: 45,
                    width: 160,
                    decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40),
                            bottomRight: Radius.circular(40))),
                    child: Center(
                      child: Text(
                        "Sign in / Sign up",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 70,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            "imgs/home.png",
                            width: 25,
                            fit: BoxFit.fill,
                          ),
                          SizedBox(
                            width: 18,
                          ),
                          Text(
                            "Home",
                            style: TextStyle(
                                color: textColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            "imgs/list.png",
                            width: 25,
                            fit: BoxFit.fill,
                          ),
                          SizedBox(
                            width: 18,
                          ),
                          Text(
                            "Past orders",
                            style: TextStyle(
                                color: textColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            "imgs/offer.png",
                            width: 25,
                            fit: BoxFit.fill,
                          ),
                          SizedBox(
                            width: 18,
                          ),
                          Text(
                            "Voichers",
                            style: TextStyle(
                                color: textColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            "imgs/settings.png",
                            width: 25,
                            fit: BoxFit.fill,
                          ),
                          SizedBox(
                            width: 18,
                          ),
                          Text(
                            "Settings",
                            style: TextStyle(
                                color: textColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  Color gradientStart = Colors.transparent;
  Color gradientEnd = Colors.black;
  buildFieldList(List<Field> items){
    return Container(
      width: screenWidth,
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: (1.3 / 1),
        crossAxisSpacing: 5,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        mainAxisSpacing: 5,
        //physics:BouncingScrollPhysics(),
        children: items
            .map(
              (data) => Padding(
                padding: const EdgeInsets.all(12.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Stack(
                    children: [
                      Image.network(

                        data.image,
                        fit: BoxFit.cover,
                        height: double.infinity,
                        width: double.infinity,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.1),
                              Colors.black.withOpacity(0.4),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),

                      Positioned(
                          bottom: 10,
                          right: 10,
                          child: Texts(title: data.name,fSize: 18,color: Colors.white,weight: FontWeight.w500,)

                      )

                    ],
                  ),
                ),
              ),
        )
            .toList(),
      ),
    );
  }

  buildMarketList({List<Market> markets, String title}) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Text(
              title,
              style: TextStyle(color: textColor, fontSize: 18),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 250,
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 13),
              itemBuilder: (ctx, i) {
                return Container(
                  width: 250,
                  margin: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                            imageUrl: filesUrl + markets[i].image,
                            width: 250,
                            height: 113,
                            fit: BoxFit.fill),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            markets[i].title,
                            style: TextStyle(color: textColor, fontSize: 16),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                size: 20,
                                color: mainColor,
                              ),
                              Text(
                                markets[i].rate.toString(),
                                style: TextStyle(color: mainColor),
                              ),
                              Text(
                                "(100)",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        markets[i].summary,
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                        maxLines: 2,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Delivery: Free",
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                          Text(
                            "Deliver in 45 mins",
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
              itemCount: markets.length,
              scrollDirection: Axis.horizontal,
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      );
  List<String> sliders = [
    "2.png",
    "3.png",
    "4.png",
    "2.png",
    "3.png",
    "2.png",
    "3.png",
    "4.png",
    "2.png",
    "3.png",
  ];



  List<String> imgs = [
    "4.png",
    "3.png",
    "4.png",
    "2.png",
    "3.png",
    "2.png",
    "3.png",
    "4.png",
    "2.png",
    "3.png",
    "2.png",
    "3.png",
    "4.png",
    "2.png",
    "3.png",
    "2.png",
    "3.png",
    "4.png",
    "2.png",
    "3.png",
    "2.png",
    "3.png",
    "4.png",
    "2.png",
    "3.png",
    "2.png",
    "3.png",
    "4.png",
    "2.png",
    "3.png",
    "2.png",
    "3.png",
    "4.png",
    "2.png",
    "3.png",
    "2.png",
    "3.png",
    "4.png",
    "2.png",
    "3.png",
    "2.png",
    "3.png",
    "4.png",
    "2.png",
    "3.png",
    "2.png",
    "3.png",
    "4.png",
    "2.png",
    "3.png",
  ];
}
