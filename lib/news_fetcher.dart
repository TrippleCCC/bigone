import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:flutter/material.dart';

import 'dart:convert';

// Class that fetches news article from News API
class NewsFetcher {
  final String _apiKey = "68b2d2939dc548098b627a8cb35785f1";
  final String _requestUrl = "https://newsapi.org/v2/top-headlines?country=us";

  String _getFullRequestUrl(String query) {
    return "$_requestUrl&apiKey=$_apiKey&q=$query";
  }

  Future<NewsPost> getNewsPost(String query) async {
    final response = await http.get(_getFullRequestUrl(query));

    if (response.statusCode == 200) {
      return NewsPost.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to get news articles");
    }
  }
}

// Class that represents a response from NewsApi.
class NewsPost {
  int totalResults;
  List<NewsArticleData> articles;

  NewsPost({this.totalResults, this.articles});

  factory NewsPost.fromJson(Map<String, dynamic> json) {
    return NewsPost(
        totalResults: json['totalResults'], 
        articles: _getArticleData(json['articles']),);
  }

  static List<NewsArticleData> _getArticleData(List<dynamic> articleJsons) {
    return articleJsons.map((articleJson) => NewsArticleData.fromJson(articleJson)).toList();
  }
}

// Class that represents a single news article
class NewsArticleData {
  String source;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;

  NewsArticleData({this.source, this.author, this.title, this.description, this.url, this.urlToImage});

  factory NewsArticleData.fromJson(Map<String, dynamic> articleJson) {
    return NewsArticleData(
      source: articleJson['source']['name'] ?? "",
      author: articleJson['author'] ?? "",
      title: articleJson['title'] ?? "",
      description: articleJson['description'] ?? "",
      url: articleJson['url'] ?? "",
      urlToImage: articleJson['urlToImage']) ?? "";
  }

  ListTile toListTile() {
    return ListTile(
      title: Text(title.toUpperCase()),
      subtitle: Text("By $author - $source"),
      onTap: () {},);
  }
}