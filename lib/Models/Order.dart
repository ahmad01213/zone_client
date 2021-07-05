class Order{
  int id;
  int address_id;
  int market_id;
  int price;
  int user_id;
  int delivery_id;
  int status;
  double market_lat;
  double market_lng;
  double user_lat;
  double user_lng;
  double market_distance;
  String username;
  String marketname;
  String marketimage;
  String date;
  int rate;


  Order.fromJson(json){
    id = json['id'];
    address_id = json['address_id'];
    market_id = json['market_id'];
    price = json['price'];
    user_id = json['user_id'];
    delivery_id = json['delivery_id'];
    status = json['status'];
    market_lat = json['market_lat'].toDouble();
    market_lng = json['market_lng'].toDouble();
    user_lat = json['user_lat'].toDouble();
    user_lng = json['user_lng'].toDouble();
    market_distance = json['market_distance'].toDouble();
    username = json['username'];
    marketname = json['marketname'];
    rate = json['market_rate'];
    date = json['date'];
    marketimage = json['marketimage'];
  }
}