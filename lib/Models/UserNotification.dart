class UserNotification{
  int id;
  int user_id;
  String title;
  String body;
  String image;
  String date;

  UserNotification.fromJson(json){
    id = json['id'];
    user_id = json['user_id'];
    title = json['title'];
    body = json['body'];
    image = json['image'];
    date = json['date'];
  }
}