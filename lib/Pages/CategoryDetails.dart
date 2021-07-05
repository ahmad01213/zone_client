import 'package:arkan/Models/Field.dart';
import 'package:arkan/Providers/FieldProvider.dart';
import 'package:arkan/helpers/helpers.dart';
import 'package:arkan/widgets/Texts.dart';
import 'package:arkan/widgets/loading_list.dart';
import 'package:arkan/widgets/store_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class CategoryDetails extends StatelessWidget {
  FieldProvider _fieldProvider;
  Field field;
  CategoryDetails(this.field);
  @override
  Widget build(BuildContext context) {
    if (_fieldProvider == null) {
      _fieldProvider = Provider.of(context);
      _fieldProvider.fieldMarketsLoad = true;
      _fieldProvider.getFieldMarkets(id: field.id);
    }
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(68),
            child: AppBar(
              centerTitle: true,
              leading: IconButton(icon: Icon(Icons.arrow_back,),onPressed: ()=>pop(context),),
              elevation: 1,
              title: Texts(title: field.name,fSize: 18,weight: FontWeight.bold,),
              backgroundColor: Colors.white,
            ),
          ),
          body:_fieldProvider.fieldMarketsLoad?LoadingListPage(): ListView.separated(
            padding: EdgeInsets.only(top: 10),
              separatorBuilder: (BuildContext context, int index) =>
                  Divider(height: 1),
              itemCount:_fieldProvider.fieldMarkets.length,
              physics: BouncingScrollPhysics(),
              itemBuilder: (ctx, i) {
                return  StoreItem(_fieldProvider.fieldMarkets[i]);
              })
        ),
      ),
    );
  }
}
