import 'package:health_pulse/imports.dart';
import 'package:json_annotation/json_annotation.dart';

List<ResponseTopHeadlinesNewsModel> responseTopHeadlinesNewsFromJson(
        String str) =>
    List<ResponseTopHeadlinesNewsModel>.from(
        json.decode(str).map((x) => ResponseTopHeadlinesNewsModel.fromJson(x)));

String responseTopHeadlinesNewsToJson(
        List<ResponseTopHeadlinesNewsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
class ResponseTopHeadlinesNewsModel {
  ResponseTopHeadlinesNewsModel({
    this.status,
    this.totalResults,
    this.articles,
  });

  String? status;
  int? totalResults;
  List<ArticleModel?>? articles;
  @JsonKey(ignore: true)
  String? error;

  ResponseTopHeadlinesNewsModel.withError(this.error);

  factory ResponseTopHeadlinesNewsModel.fromJson(Map<String, dynamic> json) =>
      ResponseTopHeadlinesNewsModel(
        status: json['status'] as String,
        totalResults: json['totalResults'] as int,
        articles: (json['articles'] as List)
            .map((e) => e == null
                ? null
                : ArticleModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'totalResults': totalResults,
        'articles': articles,
      };

  @override
  String toString() {
    return 'ResponseTopHeadlinesNews{status: $status, totalResults: $totalResults, articles: $articles, error: $error}';
  }
}


