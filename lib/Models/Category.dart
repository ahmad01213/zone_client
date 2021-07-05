class Catagory{
  int id;
  String name;
  String image;
  String status;

  Catagory.fromJson(json) {
    id = json["id"];
    name = json["name"];
    image = json["image"];
    status = json["status"];
  }
}