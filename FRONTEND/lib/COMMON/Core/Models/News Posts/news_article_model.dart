///----------------------------- 🌎 PROJECT IMPORTS -----------------------------///
import 'package:health_pulse/imports.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ArticleModel {
  ArticleModel({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedDate,
    this.publishedBy,
    this.content,
    this.category,
  });

  SourceModel? source;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedDate;
  String? publishedBy;
  String? content;
  List<String>? category;

  factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
    source: json['source'] == null
        ? null
        : SourceModel.fromJson(json['source'] as Map<String, dynamic>),
    author: json['author'] as String,
    title: json['title'] as String,
    description: json['description'] as String,
    url: json['url'] as String,
    urlToImage: json['urlToImage'] as String,
    publishedDate: json['publishedDate'] as String,
    publishedBy: json['publishedBy'] as String,
    content: json['content'] as String,
      category: json["category"] == null
          ? null
          : List<String>.from(json["category"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => <String, dynamic>{
    'source': source,
    'author': author,
    'title': title,
    'description': description,
    'url': url,
    'urlToImage': urlToImage,
    'publishedDate': publishedDate,
    'publishedBy': publishedBy,
    'content': content,
    'category': category == null
        ? null
        : List<dynamic>.from(category!.map((x) => x)),
  };

  @override
  String toString() {
    return 'Article{source: $source, author: $author, title: $title, description: $description, url: $url, urlToImage: $urlToImage, publishedAt: $publishedDate, content: $content, category: $category}';
  }
}