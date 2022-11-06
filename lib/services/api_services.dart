import 'dart:convert';


import 'package:http/http.dart';

import '../Model/article_model.dart';

class ApiService {

  final endPointUrl =
      "https://newsapi.org/v2/everything?q=keyword&apiKey=26b34b96a8544cb5b56bbc620eb88ab1";
  final uri = Uri.parse("https://newsapi.org/v2/everything?q=keyword&apiKey=26b34b96a8544cb5b56bbc620eb88ab1");

  Future<List<Article>?> getArticle() async {
    Response res = await get(uri);

    if (res.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(res.body);

      List<dynamic> body = json['articles'];
      print("body");
      print(body[1]);
      List<Article> articles =
      body.map((dynamic item) => Article.fromJson(item)).toList();
      print("articles.length");
      print(articles.length);
      return articles;
    } else {
      throw ("Can't get the Articles");
    }

  }
}