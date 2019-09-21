import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:url_launcher/url_launcher.dart';

import 'news_fetcher.dart';

class ArticlePage extends StatefulWidget {
  final NewsArticleData data;

  ArticlePage(this.data);

  @override
  State<StatefulWidget> createState() {
    return ArticlePageState();
  }
}

class ArticlePageState extends State<ArticlePage> {
  final goToArticle = "Go to article";
  ScrollController _hideFabController;
  bool _isVisible;

  @override
  void initState() {
    super.initState();
    _isVisible = true;
    _hideFabController = new ScrollController();
    _hideFabController.addListener(() {
      if (_hideFabController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (_isVisible) {
          setState(() {
            _isVisible = false;
          });
        }
      } else {
        if (_hideFabController.position.userScrollDirection ==
            ScrollDirection.forward) {
          if (!_isVisible) {
            setState(() {
              _isVisible = true;
            });
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.red,
      ),
      appBar: AppBar(
        title: Text("Bigone"),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: SingleChildScrollView(
        controller: _hideFabController,
        child: Column(
          children: <Widget>[
            Center(
              child: widget.data.urlToImage.isNotEmpty
                  ? Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Image.network(
                        widget.data.urlToImage,
                        color: Colors.grey,
                        colorBlendMode: BlendMode.overlay,
                      ),
                    )
                  : null,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
              child: Text(
                widget.data.title,
                style: TextStyle(fontFamily: "Roboto", fontSize: 36),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
              child: InkWell(
                child: Align(
                  child: Text(
                    goToArticle,
                    style: TextStyle(color: Colors.lightBlue, fontSize: 18),
                  ),
                  alignment: Alignment.centerLeft,
                ),
                onTap: () => launch(widget.data.url),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "By " + widget.data.author + " - " + widget.data.source,
                  style: TextStyle(fontFamily: "Roboto", fontSize: 18),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
              child: Text(widget.data.description,
                  style: TextStyle(fontFamily: "Roboto", fontSize: 23)),
            ),
          ],
        ),
      ),
    );
  }
}
