///----------------------------- 🌎 PROJECT IMPORTS -----------------------------///
import 'package:health_pulse/imports.dart';

List<UserModel> userModelListFromJson(String str) =>
    List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String userModelListToJson(List<UserModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.sn,
    this.prefix,
    this.username,
    this.fullName,
    this.firstName,
    this.lastName,
    this.userPhotoURL,
    this.userPhotoFile,
    this.userPhotoName,
    this.nationality,
    this.occupation,
    this.email,
    this.password,
    this.confirmedPassword,
    this.userHealthScore,
    this.userWeight,
    this.userHeight,
    this.userAge,
    this.userAddress,
    this.userBmi,
    this.userLanguage,
    this.userPhoneNumber,
    this.userGender,
    this.userDateOfBirth,
    this.phoneNumber,
    this.optionalPhoneNumber,
    this.emergencyContacts,
    this.chronicDiseaseList,
    this.bookmarkedHealthPersonnelList,
    this.bookmarkedHealthFacilitiesList,
    this.vaccineCertificatesList,
    this.dateUpdated,
    this.dateCreate,
    this.selectedTheme,
  });

  int? sn;
  String? prefix;
  String? username;
  String? fullName;
  String? firstName;
  String? lastName;
  String? userPhotoURL;
  String? userPhotoName;
  String? userPhotoFile;
  String? nationality;
  String? occupation;
  String? email;
  String? password;
  String? confirmedPassword;
  double? userHealthScore;
  double? userWeight;
  double? userHeight;
  String? userAge;
  String? userAddress;
  double? userBmi;
  String? userLanguage;
  String? userPhoneNumber;
  String? optionalPhoneNumber;
  String? userGender;
  String? userDateOfBirth;
  String? phoneNumber;
  List<EmergencyContactModel>? emergencyContacts;
  List<String>? chronicDiseaseList;
  List<String>? bookmarkedHealthPersonnelList;
  List<String>? bookmarkedHealthFacilitiesList;
  List<VaccineDigitizationModel>? vaccineCertificatesList;
  DateTime? dateUpdated;
  DateTime? dateCreate;
  String? selectedTheme;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        sn: json["sn"] ?? null,
        prefix: json["prefix"] ?? null,
        username: json["username"] ?? null,
        fullName: json["fullName"] ?? null,
        firstName: json["firstName"] ?? null,
        lastName: json["lastName"] ?? null,
        userPhotoURL: json["userPhotoURL"] ?? null,
        userPhotoName: json["userPhotoName"] ?? null,
        userPhotoFile: json["userPhotoFile"] ?? null,
        nationality: json["nationality"] ?? null,
        occupation: json["occupation"] ?? null,
        email: json["email"] ?? null,
        password: json["password"] ?? null,
        confirmedPassword: json["confirmedPassword"] ?? null,
        userHealthScore: json["userHealthScore"] == null
            ? null
            : json["userHealthScore"].toDouble(),
        userWeight:
            json["userWeight"] == null ? null : json["userWeight"].toDouble(),
        userHeight:
            json["userHeight"] == null ? null : json["userHeight"].toDouble(),
        userAge: json["userAge"] ?? null,
        userAddress: json["userAddress"] ?? null,
        userBmi: json["userBmi"] == null ? null : json["userBmi"].toDouble(),
        userLanguage: json["userLanguage"] ?? null,
        userPhoneNumber: json["userPhoneNumber"] ?? null,
        userGender: json["userGender"] ?? null,
        userDateOfBirth: json["userDateOfBirth"] ?? null,
        phoneNumber: json["phoneNumber"] ?? null,
        optionalPhoneNumber: json["optionalPhoneNumber"] ?? null,
        emergencyContacts: json['emergencyContacts'] == null
            ? null
            : List<EmergencyContactModel>.from(json["emergencyContacts"]
                .map((x) => EmergencyContactModel.fromJson(x))),
        chronicDiseaseList: json["chronicDiseaseList"] == null
            ? null
            : List<String>.from(json["chronicDiseaseList"].map((x) => x)),
        bookmarkedHealthPersonnelList:
            json["bookmarkedHealthPersonnelList"] == null
                ? null
                : List<String>.from(
                    json["bookmarkedHealthPersonnelList"].map((x) => x)),
        bookmarkedHealthFacilitiesList:
            json["bookmarkedHealthFacilitiesList"] == null
                ? null
                : List<String>.from(
                    json["bookmarkedHealthFacilitiesList"].map((x) => x)),
        vaccineCertificatesList: json["vaccineCertificatesList"] == null
            ? null
            : List<VaccineDigitizationModel>.from(
                json["vaccineCertificatesList"]
                    .map((x) => VaccineDigitizationModel.fromJson(x))),
        dateUpdated: json["dateUpdated"] == null
            ? null
            : DateTime.parse(json["dateUpdated"]),
        dateCreate: json["dateCreate"] == null
            ? null
            : DateTime.parse(json["dateCreate"]),
        selectedTheme: json["selectedTheme"] ?? null,
      );

  Map<String, dynamic> toJson() => {
        "sn": sn ?? null,
        "prefix": prefix ?? null,
        "username": username ?? null,
        "fullName": fullName ?? null,
        "firstName": firstName ?? null,
        "lastName": lastName ?? null,
        "userPhotoURL": userPhotoURL ?? null,
        "userPhotoName": userPhotoName ?? null,
        "userPhotoFile": userPhotoFile ?? null,
        "nationality": nationality ?? null,
        "occupation": occupation ?? null,
        "email": email ?? null,
        "password": password ?? null,
        "confirmedPassword": confirmedPassword ?? null,
        "userHealthScore": userHealthScore ?? null,
        "userWeight": userWeight ?? null,
        "userHeight": userHeight ?? null,
        "userAge": userAge ?? null,
        "userAddress": userAddress ?? null,
        "userBMI": userBmi ?? null,
        "userLanguage": userLanguage ?? null,
        "userPhoneNumber": userPhoneNumber ?? null,
        "userGender": userGender ?? null,
        "userDateOfBirth": userDateOfBirth ?? null,
        "phoneNumber": phoneNumber ?? null,
        "optionalPhoneNumber": optionalPhoneNumber ?? null,
        "emergencyContacts": emergencyContacts == null
            ? null
            : List<dynamic>.from(emergencyContacts!.map((x) => x.toJson())),
        "chronicDiseaseList": chronicDiseaseList == null
            ? null
            : List<dynamic>.from(chronicDiseaseList!.map((x) => x)),
        "bookmarkedHealthPersonnelList": bookmarkedHealthPersonnelList == null
            ? null
            : List<dynamic>.from(bookmarkedHealthPersonnelList!.map((x) => x)),
        "bookmarkedHealthFacilitiesList": bookmarkedHealthFacilitiesList == null
            ? null
            : List<dynamic>.from(bookmarkedHealthFacilitiesList!.map((x) => x)),
        "vaccineCertificatesList": vaccineCertificatesList == null
            ? null
            : List<dynamic>.from(
                vaccineCertificatesList!.map((x) => x.toJson())),
        "dateUpdated":
            dateUpdated == null ? null : dateUpdated!.toIso8601String(),
        "dateCreate": dateCreate == null ? null : dateCreate!.toIso8601String(),
        "selectedTheme": selectedTheme ?? null,
      };
}
