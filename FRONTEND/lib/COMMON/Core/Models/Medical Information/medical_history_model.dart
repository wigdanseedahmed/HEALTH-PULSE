///----------------------------- 🌎 PROJECT IMPORTS -----------------------------///
import 'package:health_pulse/imports.dart';

List<MedicalHistoryModel> medicalHistoryModelFromJson(String str) =>
    List<MedicalHistoryModel>.from(
        json.decode(str).map((x) => MedicalHistoryModel.fromJson(x)));

String medicalHistoryModelToJson(List<MedicalHistoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// name, age and address
// health conditions
// treatments and medicines
// allergies and past reactions to medicines
// tests, scans and X-ray results
// specialist care, such as maternity or mental health
// lifestyle information, such as whether you smoke or drink
// hospital admission and discharge information

class MedicalHistoryModel {
  ///------------------------------------------- CONSTRUCTOR -------------------------------------------///
  MedicalHistoryModel({

    ///------------- EMERGENCY CONTACT -------------///
    this.emergencyContactName,
    this.emergencyContactPhoneNumber,
    this.emergencyContactRelationshipToYou,

    ///------------- BEST INTEREST CONTACT -------------///
    this.bestInterestContactName,
    this.bestInterestContactPhoneNumber,
    this.bestInterestContactRelationshipToYou,

    ///------------- DOCTOR-------------///
    this.doctorContactName,
    this.doctorPhoneNumber,
    this.doctorAddress,

    ///------------- UPDATED AND CREATED -------------///
    this.dateCreated,
    this.dateUpdated,
  });

  ///------------------------------------------- VARIABLES -------------------------------------------///

  ///------------- EMERGENCY CONTACT -------------///
  String? emergencyContactName;
  String? emergencyContactPhoneNumber;
  String? emergencyContactRelationshipToYou;

  ///------------- BEST INTEREST CONTACT -------------///
  String? bestInterestContactName;
  String? bestInterestContactPhoneNumber;
  String? bestInterestContactRelationshipToYou;

  ///------------- DOCTOR-------------///
  String? doctorContactName;
  String? doctorPhoneNumber;
  String? doctorAddress;

  ///------------- UPDATED AND CREATED -------------///
  String? dateCreated;
  String? dateUpdated;

  ///------------------------------------------- FROM JSON -------------------------------------------///
  factory MedicalHistoryModel.fromJson(Map<String, dynamic> json) =>
      MedicalHistoryModel(

        ///------------- EMERGENCY CONTACT -------------///
        emergencyContactName: json["emergencyContactName"] ?? null,
        emergencyContactPhoneNumber: json["emergencyContactPhoneNumber"] ?? null,
        emergencyContactRelationshipToYou: json["emergencyContactRelationshipToYou"] ?? null,

        ///------------- BEST INTEREST CONTACT -------------///
        bestInterestContactName: json["bestInterestContactName"] ?? null,
        bestInterestContactPhoneNumber: json["bestInterestContactPhoneNumber"] ?? null,
        bestInterestContactRelationshipToYou: json["bestInterestContactRelationshipToYou"] ?? null,


        ///------------- DOCTOR-------------///
        doctorContactName: json["doctorContactName"] ?? null,
        doctorPhoneNumber: json["doctorPhoneNumber"] ?? null,
        doctorAddress: json["doctorAddress"] ?? null,

        ///------------- UPDATED AND CREATED -------------///
        dateCreated: json["dateCreated"] ?? null,
        dateUpdated: json['dateUpdated'] ?? null,
      );


  ///------------------------------------------- TO JSON -------------------------------------------///
  Map<String, dynamic> toJson() => {

  ///------------- EMERGENCY CONTACT -------------///
  "emergencyContactName": emergencyContactName ?? null,
  "emergencyContactPhoneNumber": emergencyContactPhoneNumber ?? null,
  "emergencyContactRelationshipToYou": emergencyContactRelationshipToYou ?? null,

    ///------------- BEST INTEREST CONTACT -------------///
    "bestInterestContactName": bestInterestContactName ?? null,
    "bestInterestContactPhoneNumber": bestInterestContactPhoneNumber ?? null,
    "bestInterestContactRelationshipToYou": bestInterestContactRelationshipToYou ?? null,


  ///------------- DOCTOR-------------///
  "doctorContactName": doctorContactName ?? null,
  "doctorPhoneNumber": doctorPhoneNumber ?? null,
  "doctorAddress": doctorAddress ?? null,

    ///------------- UPDATED AND CREATED -------------///
    "dateCreated": dateCreated ?? null,
    "dateUpdated": dateUpdated ?? null,
  };
}
