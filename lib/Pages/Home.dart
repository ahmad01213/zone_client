import 'dart:io';
import 'package:arkan/Models/Field.dart';
import 'package:arkan/Pages/CategoryDetails.dart';
import 'package:arkan/Pages/search_market.dart';
import 'package:arkan/Providers/HomeProvider.dart';
import 'package:arkan/helpers/helpers.dart';
import 'package:arkan/widgets/SizedBoxWidget.dart';
import 'package:arkan/widgets/Texts.dart';
import 'package:arkan/widgets/home_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:provider/provider.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> itemList = [];

  @override
  void initState() {
    for (int count = 0; count < 50; count++) {
      itemList.add("Item $count");
    }
  }

  HomeProvider _homeProvider;
  String city="";
  @override
  Widget build(BuildContext context) {
    if (_homeProvider == null) {
      _homeProvider = Provider.of(context);
      _homeProvider.getHome();
      screenWidth = MediaQuery.of(context).size.width;
      screenHight = MediaQuery.of(context).size.height;
    }
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.2),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          // this will hide Drawer hamburger icon
          actions: <Widget>[Container()],
          elevation: 0,
          title: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () async {
                   await  showLocationPicker(
                        context,
                        Platform.isAndroid
                            ? "AIzaSyDFZhFfswZpcjeUDYm6C7H46JLdSonK0f4"
                            : "AIzaSyDJ6UDHt4avEm0mjMYTBD5SHdHkd4Odau4",
                        // initialCenter: LatLng(31.1975844, 29.9598339),
                        myLocationButtonEnabled: true,
                        layersButtonEnabled: false,
                        language: "ar",
                        appBarColor: Colors.white, onConfirm: (LocationResult loc) {
                          locationData =loc.latLng;

                          pop(context);
                          setState(() {
                            city =loc.address.split("،")[1];

                          });


                    },
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
                              title: city,
                              fSize: 18,
                              color: Colors.black,
                              weight: FontWeight.bold,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.arrow_drop_down_outlined,
                          size: 20,
                          color: Colors.black,
                        )
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
      body: _homeProvider.loading
          ? Center(
              child: SpinKitRing(
                size: 60,
                color: mainColor,
                lineWidth: 7,
                duration: Duration(milliseconds: 600),
              ),
            )
          : NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxScrolled) {
                return <Widget>[createSilverAppBar1(), createSilverAppBar2()];
              },
              body: buildFieldList(_homeProvider.fields)),
    );
  }

  buildFieldList(List<Field> items) {
    return Container(
      width: screenWidth,
      child: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Box(20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Texts(title: "الخدمات الأكثر طلبا", fSize: 17,color: Colors.black54,weight: FontWeight.bold,),
          ),
          GridView.count(
            crossAxisCount: 2,
            childAspectRatio: (1.3 / 1),
            crossAxisSpacing: 5,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            mainAxisSpacing: 5,
            //physics:BouncingScrollPhysics(),
            children: items
                .map(
                  (data) => InkWell(
                    onTap: (){
                      pushPage(context: context,page: CategoryDetails(data));
                    },
                    child: Padding(
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
                                child: Texts(
                                  title: data.name,
                                  fSize: 18,
                                  color: Colors.white,
                                  weight: FontWeight.w500,
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  SliverAppBar createSilverAppBar1() {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.transparent,

      expandedHeight: 200,
      floating: false,
      automaticallyImplyLeading: false,


      elevation: 0,
      flexibleSpace: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return FlexibleSpaceBar(
          collapseMode: CollapseMode.pin,

          background: Container(
              height: 150,
              child: HomeSlider(
                imagesUrlList: _homeProvider.sliders,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.45,
                autoPlay: false,
              )),
        );
      }),
    );
  }

  SliverAppBar createSilverAppBar2() {
    return SliverAppBar(
      pinned: true,
      automaticallyImplyLeading: false,

      elevation: 0,
      backgroundColor: Colors.white,
      title: InkWell(
        onTap: (){
          pushPage(context: context,page: SearchMarket());
        },
        child: Container(
          width: double.infinity,
          color: Colors.white,
          margin: EdgeInsets.only(top: 5),
          height: 50,
          child: Row(
            children: [
              Icon(
                Icons.search,
                size: 30,
                color: Colors.black54,
              ),
              SizedBox(width: 10,),
              Texts(
                title: "ابحث عن متجر ، مطعم كافي أو أي مكان",
                fSize: 17,
                color: Colors.black54,
              )
            ],
          ),
        ),
      ),
    );
  }
}
