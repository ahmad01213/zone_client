class Slide{
  int id;
  String image;
  Slide.fromJson(json) {
    id = json["id"];
    image = json["image"];
  }
}