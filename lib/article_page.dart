import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'news_fetcher.dart';

class ArticlePage extends StatelessWidget {
  NewsArticleData data;

  ArticlePage(this.data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Center(
              child: data.urlToImage.isNotEmpty
                  ? Padding(
                      padding: EdgeInsets.all(5),
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Image.network(data.urlToImage),
                      ))
                  : null,
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: Text(data.title),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: Text(data.source),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: Text(data.author),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: Text(data.description),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: InkWell(
                child: Text(data.url),
                onTap: () => launch(data.url),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
