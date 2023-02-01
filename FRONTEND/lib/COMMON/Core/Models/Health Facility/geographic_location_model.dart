///----------------------------- 🌎 PROJECT IMPORTS -----------------------------///
import 'package:health_pulse/imports.dart';

List<GeographicLocationMapModel> geographicLocationMapFromJson(String str) =>
    List<GeographicLocationMapModel>.from(
        json.decode(str).map((x) => GeographicLocationMapModel.fromJson(x)));

String geographicLocationMapToJson(List<GeographicLocationMapModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GeographicLocationMapModel {
  GeographicLocationMapModel({
    this.name,
    this.type,
    this.locality,
    this.lat,
    this.long,
    this.address,
    this.imagePath,
    this.rank,
  });

  String? name;
  String? type;
  String? locality;
  double? lat;
  double? long;
  String? address;
  String? imagePath;
  double? rank;

  factory GeographicLocationMapModel.fromJson(Map<String, dynamic> json) =>
      GeographicLocationMapModel(
        name: json["Name"] == null ? null : json["Name"],
        type: json["Type"] == null ? null : json["Type"],
        locality: json["Locality"] == null ? null : json["Locality"],
        lat: json["Lat"] == null ? null : json["Lat"].toDouble(),
        long: json["Long"] == null ? null : json["Long"].toDouble(),
        address: json["Address"] == null ? null : json["Address"],
        imagePath: json["imagePath"] == null ? null : json["imagePath"],
        rank: json["rank"] == null ? null : json["rank"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "Name": name == null ? null : name,
        "Type": type == null ? null : type,
        "Locality": locality == null ? null : locality,
        "Lat": lat == null ? null : lat,
        "Long": long == null ? null : long,
        "Address": address == null ? null : address,
        "imagePath": imagePath == null ? null : imagePath,
        "rank": rank == null ? null : rank,
      };
}
