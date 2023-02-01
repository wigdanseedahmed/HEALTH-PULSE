import 'package:health_pulse/imports.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class SourceModel {
  SourceModel({this.name});

  String? name;

  factory SourceModel.fromJson(Map<String, dynamic> json) => SourceModel(
    name: json['name'] as String,
  );

  Map<String, dynamic> toJson() => <String, dynamic>{
    'name': name,
  };

  @override
  String toString() {
    return 'Source{name: $name}';
  }
}