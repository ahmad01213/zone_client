class Field {
  int id;
  String name;
  String image;
  String status;

  Field.fromJson(json) {
    id = json["id"];
    name = json["name"];
    image = json["image"];
    status = json["status"];
  }
}
