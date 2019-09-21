import 'package:flutter/material.dart';

import 'news_fetcher.dart';

class NewsSearchDelegate extends SearchDelegate {
  final NewsFetcher _newsFetcher = NewsFetcher();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = '';
          }
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return Icon(Icons.search);
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      builder: (context, AsyncSnapshot<NewsPost> snapshot) {
        switch(snapshot.connectionState) {
          case ConnectionState.none:
            return null;
          case ConnectionState.active:
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          case ConnectionState.done:
            return ListView(
                padding: EdgeInsets.all(2),
                children:
                  snapshot.data.articles.map(
                          (article) => article.toListTile()).toList());
        }
        return null;
      },
      future: _newsFetcher.getNewsPost(query),);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Column();
  }
}