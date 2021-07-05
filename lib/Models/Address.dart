class Address{
  int id;
  int user_id;
  String city;
  String street;
  int block;
  int building;
  int floor;
  int flat_no;
  String additional_directions;
  String lable;
  String phone;
  double lat;
  double lng;

  Address.fromJson(json) {
    id = json["id"];
    user_id = json["user_id"];
    city = json["city"];
    street = json["street"];
    block = json["block"];
    building = json["building"];
    floor = json["floor"];
    flat_no = json["flat_no"];
    additional_directions = json["additional_directions"];
    lable = json["lable"];
    phone = json["phone"];
    lat = json["lat"];
    lng = json["lng"];
  }
}