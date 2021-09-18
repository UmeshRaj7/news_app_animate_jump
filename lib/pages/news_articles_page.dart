import 'dart:developer';

import 'package:fello_assignment/model/news_model.dart';
import 'package:fello_assignment/repo/api_repo.dart';
import 'package:fello_assignment/widgets/news_card.dart';
import 'package:flutter/material.dart';

class NewsArticlesPage extends StatefulWidget {
  @override
  _NewsArticlesPageState createState() => _NewsArticlesPageState();
}

class _NewsArticlesPageState extends State<NewsArticlesPage> {
  late ScrollController _controller;
  int pageNumber = 0;
  int? maxPage = 0;
  int pageSize = 20;
  List<Article> _articles = [];

  @override
  void initState() {
    // TODO: implement initState
    getArticlesFromApi();
    _controller = ScrollController()..addListener(_listener);
    super.initState();
  }

  void _listener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      getArticlesFromApi();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily News'),
      ),
      body: SafeArea(
        child: ListView.builder(
            controller: _controller,
            itemCount: _articles.length + 1,
            itemBuilder: (context, index) {
              if (index == _articles.length) {
                return _buildProgressIndicator();
              } else {
                return NewsCard(_articles[index]);
              }
            }),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  void getArticlesFromApi() async {
    if (pageNumber <= (maxPage ?? 0)) {
      pageNumber = pageNumber + 1;
      log("page num $pageNumber");
      NewsModel model = await ApiRepo.getNewsArticles(
          pageNumber: pageNumber, itemsPerPage: pageSize);
      maxPage = model.totalResults ~/ pageSize;

      var articles = model.articles;
      print("article id ${articles.map((e) => e.source.id).toList()}");

      setState(() {
        _articles.addAll(articles);
      });
    } else {}
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }
}
