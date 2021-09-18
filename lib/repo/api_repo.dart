import 'dart:convert';
import 'dart:developer';

import 'package:fello_assignment/model/news_model.dart';
import 'package:http/http.dart' as http;

class ApiRepo {
  static Future<NewsModel> getNewsArticles(
      {required int pageNumber, int itemsPerPage = 20}) async {
    var apiResponse = await http.get(Uri.parse(
        'https://newsapi.org/v2/everything?q=apple&from=2021-09-16&to=2021-09-16&sortBy=popularity&page=$pageNumber&pageSize=$itemsPerPage&apiKey=81d56336c65e45ff9582e517cea6ea23'));
    log("status code ${apiResponse.statusCode}");
    if (apiResponse.statusCode == 200) {
      NewsModel model = NewsModel.fromMap(json.decode(apiResponse.body));
      return model;
    } else {
      throw 'Failed to load';
    }
  }
}
