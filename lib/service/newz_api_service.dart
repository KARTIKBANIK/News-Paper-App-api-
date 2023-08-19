import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:newz_app/model/news_model.dart';
import 'package:newz_app/widgets/const.dart';
import 'package:url_launcher/link.dart';

class NewsApiService {
  /*Future getAllNews() async {
    // https://newsapi.org/v2/everything?q=bitcoin&apiKey=ad3e33e29eb7452e824fa3ac498c3054

    var link = Uri.https("$baseUrl", "v2/everything", {
      "q": "bitcoin",
    });

    var response = await http.get(link, headers: {"X-Api-Key": "$apiKey"});

    print("Responseeee      isssssss sss : ${response.body}");
  }*/

  Future<List<Articles>> fetchNewsData() async {
    List<Articles> newsList = [];
    var link = Uri.parse(
        "https://newsapi.org/v2/everything?q=bitcoin&apiKey=ad3e33e29eb7452e824fa3ac498c3054");
    var response = await http.get(link);

    var data = jsonDecode(response.body);
    Articles articles;
    for (var i in data["articles"]) {
      articles = Articles.fromJson(i);
      newsList.add(articles);
    }
    return newsList;
    // print("Responseeee      isssssss sss : ${response.body}");
  }
}
