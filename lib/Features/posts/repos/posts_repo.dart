import 'dart:convert';
import 'dart:math';

import 'package:bloc_with_api/Features/posts/models/posts_data_ui_model.dart';
import 'package:http/http.dart' as http;

class PostsRepo {
  static Future<List<Temperatures>> fetchposts() async {
    var client = http.Client();
    List<Temperatures> posts = [];
    try {
      var response = await client
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      //body: {'name': 'doodle', 'color': 'blue'});
//print(response.body);

      List result = jsonDecode(response.body);
      for (int i = 0; i < result.length; i++) {
        Temperatures post =
            Temperatures.fromMap(result[i] as Map<String, dynamic>);
        posts.add(post);
      }
      return posts;
    } catch (e) {
      log(e.toString() as num);
      return [];
    }
  }

  static Future<bool> addPost() async {
    var client = http.Client();

    try {
      var response = await client
          .post(Uri.parse('https://jsonplaceholder.typicode.com/posts'), body: {
        "title": "Flutter Developer",
        "body": "Experienced",
        "userId": "34"
      });
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString() as num);
      return false;
    }
  }
}
