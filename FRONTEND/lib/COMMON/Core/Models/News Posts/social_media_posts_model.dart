///----------------------------- 🌎 PROJECT IMPORTS -----------------------------///
import 'package:health_pulse/imports.dart';

List<SocialMediaNewsPostsModel> socialMediaNewsPostsModelFromJson(String str) =>
    List<SocialMediaNewsPostsModel>.from(
        json.decode(str).map((x) => SocialMediaNewsPostsModel.fromJson(x)));

String socialMediaNewsPostsModelToJson(List<SocialMediaNewsPostsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SocialMediaNewsPostsModel {
  SocialMediaNewsPostsModel({
    this.sn,
    this.dateCreated,
    this.socialMedia,
    this.postText,
    this.postImageUrl,
    this.userUid,
    this.timeStamp,
    this.username,
    this.userFirstName,
    this.userLastName,
    this.userProfilePicture,
  });

  int? sn;
  String? dateCreated;
  String? socialMedia;
  String? postText;
  String? postImageUrl;
  String? userUid;
  String? timeStamp;
  String? username;
  String? userFirstName;
  String? userLastName;
  String? userProfilePicture;

  factory SocialMediaNewsPostsModel.fromJson(Map<String, dynamic> json) =>
      SocialMediaNewsPostsModel(
        sn: json["sn"] ?? null,
        dateCreated: json["dateCreated"] ?? null,
        socialMedia: json["socialMedia"] ?? null,
        postText: json["postText"] ?? null,
        postImageUrl: json["postImageUrl"] ?? null,
        timeStamp: json["timeStamp"] ?? null,
        userUid: json["userUid"] ?? null,
        username: json["username"] ?? null,
        userFirstName: json["userFirstName"] ?? null,
        userLastName: json["userLastName"] ?? null,
        userProfilePicture: json["userProfilePicture"] ?? null,
      );

  Map<String, dynamic> toJson() => {
    "sn": sn ?? null,
    "dateCreated": dateCreated ?? null,
    "socialMedia": socialMedia ?? null,
    "postText": postText ?? null,
    "postImageUrl": postImageUrl ?? null,
    "createdAt": timeStamp ?? null,
    "userUid": userUid ?? null,
    "username": username ?? null,
    "userFirstName": userFirstName ?? null,
    "userLastName": userLastName ?? null,
    "userProfilePicture": userProfilePicture ?? null,
  };
}

