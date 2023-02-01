import 'package:health_pulse/imports.dart';

List<VaccineDigitizationModel> vaccineDigitizationFromJson(String str) =>
    List<VaccineDigitizationModel>.from(
        json.decode(str).map((x) => VaccineDigitizationModel.fromJson(x)));

String vaccineDigitizationToJson(List<VaccineDigitizationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VaccineDigitizationModel {
  VaccineDigitizationModel({
    this.name,
    this.type,
    this.addedOn,
    this.barCodeResultString,
    this.barCodeResult,
  });

  String? name;
  String? type;
  String? addedOn;
  String? barCodeResultString;
  String? barCodeResult;

  factory VaccineDigitizationModel.fromJson(Map<String, dynamic> json) =>
      VaccineDigitizationModel(
        name: json["name"] == null ? null : json["name"],
        type: json["type"] == null ? null : json["type"],
        addedOn: json["addedOn"] == null ? null : json["addedOn"],
        barCodeResultString: json["barCodeResultString"] == null
            ? null
            : json["barCodeResultString"],
        barCodeResult:
            json["barCodeResult"] == null ? null : json["barCodeResult"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "type": type == null ? null : type,
        "addedOn": type == addedOn ? null : addedOn,
        "barCodeResultString":
            barCodeResultString == null ? null : barCodeResultString,
        "barCodeResult": barCodeResult == null ? null : barCodeResult,
      };
}
