import 'package:fello_assignment/model/news_model.dart';
import 'package:flutter/material.dart';

class NewsCard extends StatelessWidget {
  final Article article;

  NewsCard(this.article);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Container(
              margin: EdgeInsets.all(10),
              child: Image.network(article.urlToImage)),
          ListTile(
            title: Text(
              article.title,
              style:
                  TextStyle(fontFamily: 'Europa', fontWeight: FontWeight.w700),
            ),
            subtitle: Text(
              article.description,
              style: TextStyle(
                fontFamily: 'Europa',
              ),
            ),
          )
        ],
      ),
    );
  }
}
