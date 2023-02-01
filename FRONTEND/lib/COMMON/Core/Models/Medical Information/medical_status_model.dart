///----------------------------- 🌎 PROJECT IMPORTS -----------------------------///
import 'package:health_pulse/imports.dart';

List<MedicalStatusModel> medicalStatusModelFromJson(String str) =>
    List<MedicalStatusModel>.from(
        json.decode(str).map((x) => MedicalStatusModel.fromJson(x)));

String medicalStatusModelToJson(List<MedicalStatusModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MedicalStatusModel {
  MedicalStatusModel({
    this.sn,
    this.dateCreated,
    this.dateUpdated,
    this.testName,
    this.illnessName,
    this.testResult,
    this.testResultPercentage,
  });

  int? sn;
  String? dateCreated;
  String? dateUpdated;
  String? testName;
  String? illnessName;
  String? testResult;
  double? testResultPercentage;

  factory MedicalStatusModel.fromJson(Map<String, dynamic> json) =>
      MedicalStatusModel(
        sn: json["sn"] ?? null,
        dateCreated: json["dateCreated"] ?? null,
        dateUpdated: json['dateUpdated'] ?? null,
        testName: json["testName"] ?? null,
        illnessName: json['illnessName'] ?? null,
        testResult: json["testResult"] ?? null,
        testResultPercentage: json["testResultPercentage"] == null
            ? null
            : json["testResultPercentage"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
    "sn": sn ?? null,
    "dateCreated": dateCreated ?? null,
    "dateUpdated": dateUpdated ?? null,
    "testName": testName ?? null,
    "illnessName": illnessName ?? null,
    "testResult": testResult ?? null,
    "testResultPercentage": testResultPercentage ?? null,
  };
}
