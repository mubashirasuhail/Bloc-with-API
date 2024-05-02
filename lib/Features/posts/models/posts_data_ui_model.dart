import 'dart:convert';

List<Temperatures> temperaturesFromJson(String str) => List<Temperatures>.from(
    json.decode(str).map((x) => Temperatures.fromMap(x)));

String temperaturesToJson(List<Temperatures> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Temperatures {
  int userId;
  int id;
  String title;
  String body;

  Temperatures({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory Temperatures.fromMap(Map<String, dynamic> json) => Temperatures(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
      );

  Map<String, dynamic> toMap() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
      };
}
