import 'package:arkan/Models/Food.dart';
import 'package:arkan/Models/Market.dart';
import 'package:arkan/Pages/CartPage.dart';
import 'package:arkan/Providers/FoodProvider.dart';
import 'package:arkan/Providers/MarketProvider.dart';
import 'package:arkan/widgets/Texts.dart';
import 'package:arkan/helpers/helpers.dart';
import 'package:arkan/widgets/SizedBoxWidget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'FoodDetail.dart';

class ResturantScreen extends StatefulWidget {
  Market market;
  ResturantScreen(this.market);
  @override
  _ResturantScreenState createState() => _ResturantScreenState();
}

FoodProvider _foodProvider;

class _ResturantScreenState extends State<ResturantScreen>
    with SingleTickerProviderStateMixin {
  int selectedIndex = 0;
  MarketProvider _marketProvider;
  getInitialData() async {
    _marketProvider.foods = [];
    await _marketProvider.getCategories();
    _marketProvider.loading = true;

    await _marketProvider.getMarkeCategoryFoods(
        catId: _marketProvider.categories[0].id, marketId: widget.market.id);
    _tabController = TabController(
        length: _marketProvider.categories.length,
        initialIndex: 0,
        vsync: this);

    // _marketProvider.getCarts();
  }

  TabController _tabController;

  @override
  Widget build(BuildContext context) {
    if (_marketProvider == null) {
      _marketProvider = Provider.of(context);
      _foodProvider = Provider.of(context);
      getInitialData();
    }

    return Container(
        color: Colors.white,
        child: SafeArea(
          child: Scaffold(
            bottomSheet: Container(
              height: 50,
              color: socondColor,
              child: InkWell(
                onTap: () {
                  if(_marketProvider.ordersPrice>0)
                  pushPage(context: context, page: CartPage(market: widget.market,totalCost: _marketProvider.ordersPrice,));
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(0)),
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Texts(
                        title: " | " +
                            _marketProvider.carts.length.toString() +
                            " |    " +
                            "إكمال الطلب",
                        fSize: 17,
                        weight: FontWeight.w300,
                        color: Colors.white,
                      ),
                      Texts(
                        title: '${_marketProvider.ordersPrice.toString()} ريال ',
                        fSize: 17,
                        weight: FontWeight.w300,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxScrolled) {
                return <Widget>[createSilverAppBar1(), createSilverAppBar2()];
              },
              body: _marketProvider.loading
                  ? Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: Center(
                        child: SpinKitRing(
                          size: 60,
                          color: mainColor,
                          lineWidth: 7,
                          duration: Duration(milliseconds: 600),
                        ),
                      )

                    )
                  : ListView.separated(
                padding: EdgeInsets.only(bottom: 100),
                      physics: NeverScrollableScrollPhysics(),
                      separatorBuilder: (BuildContext context, int index) =>
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            child: Divider(
                              height: 1,
                              color: mainColor,
                            ),
                          ),
                      shrinkWrap: true,
                      itemCount: _marketProvider.foods.length,
                      itemBuilder: (ctx, i) {
                        return FoodItem(_marketProvider.foods[i],
                            _marketProvider.getCarts);
                      }),
            ),
          ),
        ));
  }

  SliverAppBar createSilverAppBar1() {
    return SliverAppBar(

      automaticallyImplyLeading: false,
      expandedHeight: 200,
      floating: false,
      elevation: 0,
      flexibleSpace: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return FlexibleSpaceBar(
            collapseMode: CollapseMode.pin,
            background: Column(
              children: [
                Container(
                  width: screenWidth,
                  child: Stack(
                    children: [
                      Image.network(
                        widget.market.image,
                        height: 200,
                        width: screenWidth,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                          top: 40,
                          left: 10,
                          right: 10,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.white),
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: Colors.black,
                                    size: 20,
                                  ),
                                ),
                              ),
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.white),
                                child: Icon(
                                  Icons.search,
                                  color: Colors.black,
                                  size: 20,
                                ),
                              )
                            ],
                          ))
                    ],
                  ),
                ),

              ],
            ));
      }),
    );
  }

  SliverAppBar createSilverAppBar2() {
    return SliverAppBar(
      pinned: true,
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      foregroundColor: Colors.white,
      bottom:_tabController==null?null:
    new TabBar(
          labelColor: Colors.grey,
          controller: _tabController,
          onTap: (i) {
            _marketProvider.loading = true;
            _marketProvider.getMarkeCategoryFoods(
                catId: _marketProvider.categories[i].id,
                marketId: widget.market.id);
            setState(() {});
          },
          isScrollable: true,
          indicatorColor: socondColor,
          tabs: _marketProvider.categories
              .map(
                (c) => new Tab(
              text: c.name,
            ),
          )
              .toList()),
        
      title: Column(
        children: [
          Box(20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.market.title,
                    style: TextStyle(
                        color: textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: 20,
                        color: Colors.orangeAccent,
                      ),
                      Text(
                        widget.market.rate.toString(),
                        style: TextStyle(color: mainColor),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
class FoodItem extends StatefulWidget {
  Food food;
  Function update;
  FoodItem(this.food, this.update);
  @override
  _FoodItemState createState() => _FoodItemState();
}
class _FoodItemState extends State<FoodItem> {
  bool load = false;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {

          showMaterialModalBottomSheet(
              duration: Duration(milliseconds: 300),
              backgroundColor: Colors.transparent,
              context: context,
              builder: (BuildContext context) {
                return FoodDetail(widget.food);
              });
        },
        child: Container(
          height: 120,
          width: screenWidth,
          margin: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Texts(
                    title: widget.food.name,
                    fSize: 13,
                    color: Colors.black,
                    weight: FontWeight.bold,
                  ),
                  Box(10),
                  Texts(
                    title: widget.food.desc,
                    fSize: 11,
                    color: Colors.grey,
                  ),
                  Box(20),
                  Row(
                    children: [
                      Texts(
                        title: '${widget.food.price.toString()} ريال ',
                        fSize: 22,
                        color: Colors.black,
                        weight: FontWeight.w500,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      // buildQuantityView(() {}),
                      SizedBox(
                        width: 10,
                      ),
                      // load
                      //     ? Center(
                      //         child: SpinKitRing(
                      //           size: 25,
                      //           color: mainColor,
                      //           lineWidth: 3,
                      //           duration: Duration(milliseconds: 700),
                      //         ),
                      //       )
                      //     : Container(
                      //         width: 30,
                      //         height: 30,
                      //         child: IconButton(
                      //             padding: EdgeInsets.all(0),
                      //             onPressed: () async {
                      //               setState(() {
                      //                 load = true;
                      //               });
                      //               final params = {
                      //                 'user_id': '10',
                      //                 'quantity': quantity.toString(),
                      //                 'food_id': widget.food.id.toString(),
                      //                 'price': (widget.food.price * quantity)
                      //                     .toString(),
                      //                 'options': {}.toString()
                      //               };
                      //               await _foodProvider.addCart(
                      //                   context, params);
                      //               widget.update();
                      //               setState(() {
                      //                 load = false;
                      //               });
                      //             },
                      //             icon: Icon(
                      //               Icons.shopping_cart,
                      //               color: mainColor,
                      //               size: 30,
                      //             )),
                      //       )
                    ],
                  ),
                ],
              ),
              ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: widget.food.image,
                    height: 85,
                    width: 100,
                    fit: BoxFit.cover,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
