import 'package:health_pulse/imports.dart';
import 'package:json_annotation/json_annotation.dart';

List<NewsCategoryModel> newsCategoryFromJson(String str) =>
    List<NewsCategoryModel>.from(
        json.decode(str).map((x) => NewsCategoryModel.fromJson(x)));

String newsCategoryToJson(List<NewsCategoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
class NewsCategoryModel {
  NewsCategoryModel({
    this.image,
    this.title,
  });

  String? image;
  String? title;

  factory NewsCategoryModel.fromJson(Map<String, dynamic> json) =>
      NewsCategoryModel(
        image: json["image"] == null ? null : json["image"],
        title: json["title"] == null ? null : json["title"],
      );

  Map<String, dynamic> toJson() => {
    "image": image == null ? null : image,
    "title": title == null ? null : title,
  };

  @override
  String toString() {
    return 'Category{image: $image, title: $title}';
  }
}

