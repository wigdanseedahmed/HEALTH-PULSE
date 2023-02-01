///----------------------------- 🌎 PROJECT IMPORTS -----------------------------///
import 'package:health_pulse/imports.dart';

List<EmergencyContactModel> emergencyContactModelListFromJson(String str) =>
    List<EmergencyContactModel>.from(
        json.decode(str).map((x) => EmergencyContactModel.fromJson(x)));

String emergencyContactModelListToJson(List<EmergencyContactModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

EmergencyContactModel emergencyContactModelFromJson(String str) =>
    EmergencyContactModel.fromJson(json.decode(str));

String emergencyContactModelToJson(EmergencyContactModel data) =>
    json.encode(data.toJson());

class EmergencyContactModel {
  EmergencyContactModel({
    this.emergencyNumber,
    this.emergencyContactName,
    this.emergencyContactCellPhoneNumber,
    this.emergencyContactHomePhoneNumber,
    this.emergencyContactWorkPhoneNumber,
    this.emergencyContactRelationshipToYou,
    this.emergencyContactAddress,
  });

  int? emergencyNumber;
  String? emergencyContactName;
  String? emergencyContactCellPhoneNumber;
  String? emergencyContactHomePhoneNumber;
  String? emergencyContactWorkPhoneNumber;
  String? emergencyContactRelationshipToYou;
  String? emergencyContactAddress;

  factory EmergencyContactModel.fromJson(Map<String, dynamic> json) =>
      EmergencyContactModel(
        emergencyNumber: json["emergencyNumber"] == null
            ? null
            : json["emergencyNumber"].toInt(),
        emergencyContactName: json["emergencyContactName"] ?? null,
        emergencyContactCellPhoneNumber:
            json["emergencyContactCellPhoneNumber"] ?? null,
        emergencyContactHomePhoneNumber:
            json["emergencyContactHomePhoneNumber"] ?? null,
        emergencyContactWorkPhoneNumber:
            json["emergencyContactWorkPhoneNumber"] ?? null,
        emergencyContactRelationshipToYou:
            json["emergencyContactRelationshipToYou"] ?? null,
          emergencyContactAddress: json["emergencyContactAddress"] ?? null,
      );

  Map<String, dynamic> toJson() => {
        "emergencyNumber": emergencyNumber ?? null,
        "emergencyContactName": emergencyContactName ?? null,
        "emergencyContactCellPhoneNumber":
            emergencyContactCellPhoneNumber ?? null,
        "emergencyContactHomePhoneNumber":
            emergencyContactHomePhoneNumber ?? null,
        "emergencyContactWorkPhoneNumber":
            emergencyContactWorkPhoneNumber ?? null,
        "emergencyContactRelationshipToYou":
            emergencyContactRelationshipToYou ?? null,
    "emergencyContactAddress": emergencyContactAddress ?? null,
      };
}
