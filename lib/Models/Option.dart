class Option{
  int id;
  String name;
  String image;
  int price;

  Option.fromJson(json) {
    id = json["id"];
    name = json["name"];
    image = json["image"];
    price = json["price"];
  }
}