///----------------------------- 🌎 PROJECT IMPORTS -----------------------------///
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
    this.idNumber,
    this.dose1Date,
    this.dose1Batch,
    this.dose1Manufacturer,
    this.dose1Location,
    this.dose2Date,
    this.dose2Batch,
    this.dose2Manufacturer,
    this.dose2Location,
    this.dose3Date,
    this.dose3Batch,
    this.dose3Manufacturer,
    this.dose3Location,
  });

  String? name;
  String? type;
  String? addedOn;
  String? barCodeResultString;
  String? barCodeResult;
  String? idNumber;
  String? dose1Date;
  String? dose1Batch;
  String? dose1Manufacturer;
  String? dose1Location;
  String? dose2Date;
  String? dose2Batch;
  String? dose2Manufacturer;
  String? dose2Location;
  String? dose3Date;
  String? dose3Batch;
  String? dose3Manufacturer;
  String? dose3Location;

  factory VaccineDigitizationModel.fromJson(Map<String, dynamic> json) =>
      VaccineDigitizationModel(
        name: json["name"] ?? null,
        type: json["type"] ?? null,
        addedOn: json["addedOn"] ?? null,
        barCodeResultString: json["barCodeResultString"] ?? null,
        barCodeResult: json["barCodeResult"] ?? null,
        idNumber: json["idNumber"] ?? null,
        dose1Date: json["dose1Date"] ?? null,
        dose1Batch: json["dose1Batch"] ?? null,
        dose1Manufacturer: json["dose1Manufacturer"] ?? null,
        dose1Location: json["dose1Location"] ?? null,
        dose2Date: json["dose2Date"] ?? null,
        dose2Batch: json["dose2Batch"] ?? null,
        dose2Manufacturer: json["dose2Manufacturer"] ?? null,
        dose2Location: json["dose2Location"] ?? null,
        dose3Date: json["dose3Date"] ?? null,
        dose3Batch: json["dose3Batch"] ?? null,
        dose3Manufacturer: json["dose3Manufacturer"] ?? null,
        dose3Location: json["dose3Location"] ?? null,
      );

  Map<String, dynamic> toJson() => {
        "name": name ?? null,
        "type": type ?? null,
        "addedOn": type == addedOn ? null : addedOn,
        "barCodeResultString": barCodeResultString ?? null,
        "barCodeResult": barCodeResult ?? null,
        "idNumber": idNumber ?? null,
        "dose1Date": dose1Date ?? null,
        "dose1Batch": dose1Batch ?? null,
        "dose1Manufacturer": dose1Manufacturer ?? null,
        "dose1Location": dose1Location ?? null,
        "dose2Date": dose2Date ?? null,
        "dose2Batch": dose2Batch ?? null,
        "dose2Manufacturer": dose2Manufacturer ?? null,
        "dose2Location": dose2Location ?? null,
        "dose3Date": dose3Date ?? null,
        "dose3Batch": dose3Batch ?? null,
        "dose3Manufacturer": dose3Manufacturer ?? null,
        "dose3Location": dose3Location ?? null,
      };
}
