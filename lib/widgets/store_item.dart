import 'package:arkan/Models/Market.dart';
import 'package:arkan/Pages/ResturanScreen.dart';
import 'package:arkan/helpers/helpers.dart';
import 'package:arkan/widgets/SizedBoxWidget.dart';
import 'package:arkan/widgets/Texts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class StoreItem extends StatelessWidget {
  Market market ;
   StoreItem(this.market);
   @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        pushPage(context: context,page: ResturantScreen(market));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
        Row(
          children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: CachedNetworkImage(
              imageUrl: market.image,
              height: 80,
              width: 80,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 5,),

          Container(color: Colors.grey,height: 50,width: 0.4,),
          SizedBox(width: 15,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleText(title:market.title ),
              SizedBox(width: 15,),
              Row(
                children: [
                  Icon(
                    Icons.location_on_sharp,
                    color: socondColor,
                    size: 18,
                  ),
                  SizedBox(width: 15,),
                  subTitleText(title: market.distance.toString()+"  كم  "),
                ],
              )
            ],
          ),
        ],)
,
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(

              children: [
              SizedBox(width: 20,),
              Container(color: Colors.grey,height: 50,width: 0.4,),
              SizedBox(width: 15,),
              Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.star,color: Colors.orangeAccent,size: 15,),
                        Texts(title:" "+ market.rate.toString(),fSize: 15,weight: FontWeight.bold,),
                      ],
                    ),
                    Box(10),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 0),
                        child: Texts(title:market.isClosed?"مغلق": "مفتوح",color: Colors.white,fSize: 8,weight: FontWeight.bold,),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color:market.isClosed?Colors.grey: Colors.green
                        )

                    ),

                  ],),
              )
            ],),
          )
          ],
        ),
      ),
    );
  }

}
