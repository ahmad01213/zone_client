class User{
  int id;
  String name;
  String email;
  String phone;
  String image;
  String role;
  User(){}
  User.fromJson(json) {
    id = json["id"];
    email = json["email"];
    name = json["name"];
    phone = json["phone"];
    image = json["image"];
    role = json["role"];
  }
}