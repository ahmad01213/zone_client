class Market{
  int id;
  String title;
  int user_id;
  int balance;
  String image;
  int field_id;
  bool isClosed;
  double lat;
  double lng;
  String status;
  String summary;
  int rate;
  double distance;
  int order_count;
  int picks;

  Market.fromJson(json) {
    id = json["id"];
    user_id = json["user_id"];
    title = json["title"];
    balance = json["balance"];
    image = json["image"];
    field_id = json["field_id"];
    lat = json["lat"].toDouble();
    lng = json["lng"].toDouble();
    status = json["status"];
    summary = json["summary"];
    rate = json["rate"];
    isClosed = json["isClosed"]==0?false:true;
    order_count = json["order_count"];
    picks = json["picks"];
  }

}