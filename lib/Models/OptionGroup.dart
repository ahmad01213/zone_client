import 'package:arkan/Models/Option.dart';

class OptionGroup {
  int id;
  String name;
  int food_id;
  List<Option> options;


  OptionGroup.fromJson(json) {
    id = json["id"];
    food_id = json["food_id"];
    name = json["name"];

  }
}
