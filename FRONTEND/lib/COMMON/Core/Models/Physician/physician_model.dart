///----------------------------- 🌎 PROJECT IMPORTS -----------------------------///
import 'package:health_pulse/imports.dart';

List<PhysicianModel> physicianModelFromJson(String str) => List<PhysicianModel>.from(json.decode(str).map((x) => PhysicianModel.fromJson(x)));

String physicianModelToJson(List<PhysicianModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PhysicianModel {
  PhysicianModel({
    this.sn,
    this.fullName,
    this.firstName,
    this.lastName,
    this.imagePath,
    this.email,
    this.password,
    this.confirmedPassword,
    this.jobTitle,
    this.medicalFacilityName,
    this.medicalFacilityAddress,
    this.biography,
    this.medicalEducation,
    this.residency,
    this.internship,
    this.fellowship,
    this.physicianHistory,
    this.prefix,
    this.specialty,
    this.medicalFieldSpeciality,
    this.rank,
    this.phoneNumber,
    this.appointments,
    this.address,
    this.addr_city,
    this.addr_locality,
    this.addr_administrativeUnit,
    this.addr_neighbourhood,
    this.addr_blockNumber,
    this.addr_houseNumber,
    this.addr_street,
    this.addr_postcode,
    this.working_hours,
  });

  String? sn;
  String? fullName;
  String? firstName;
  String? lastName;
  String? imagePath;
  String? email;
  String? password;
  String? confirmedPassword;
  String? jobTitle;
  List<String>? medicalFacilityName;
  List<String>? medicalFacilityAddress;
  String? biography;
  String? physicianHistory;
  String? medicalEducation;
  String? residency;
  String? internship;
  String? fellowship;
  String? prefix;
  String? specialty;
  String? medicalFieldSpeciality;
  double? rank;
  String? phoneNumber;
  String? appointments;
  String? address;
  String? addr_city;
  String? addr_locality;
  String? addr_administrativeUnit;
  String? addr_neighbourhood;
  String? addr_blockNumber;
  String? addr_houseNumber;
  String? addr_street;
  String? addr_postcode;
  List<String>? working_hours;

  factory PhysicianModel.fromJson(Map<String, dynamic> json) => PhysicianModel(
    sn: json["sn"] == null ? null : json["sn"],
    fullName: json["fullName"] ?? null,
    firstName: json["firstName"] ?? null,
    lastName: json["lastName"] ?? null,
    imagePath: json["imagePath"] ?? null,
    email: json["email"] ?? null,
    password: json["password"] ?? null,
    confirmedPassword: json["confirmedPassword"] ?? null,
    jobTitle: json["jobTitle"] ?? null,
    medicalFacilityName: json["medicalFacilityName"] == null
        ? null
        : List<String>.from(json["medicalFacilityName"].map((x) => x)),
    medicalFacilityAddress: json["medicalFacilityAddress"] == null
        ? null
        : List<String>.from(json["medicalFacilityAddress"].map((x) => x)),
    biography: json["biography"] ?? null,
    physicianHistory: json["physicianHistory"] ?? null,
    medicalEducation: json["medicalEducation"] ?? null,
    residency: json["residency"] ?? null,
    internship: json["internship"] ?? null,
    fellowship: json["fellowship"] ?? null,
    prefix: json["prefix"] ?? null,
    medicalFieldSpeciality: json["medicalFieldSpeciality"] ?? null,
    specialty: json["specialty"] ?? null,
    rank: json["rank"] == null? null : json["rank"].toDouble(),
    phoneNumber: json["phoneNumber"] ?? null,
    appointments: json["appointments"] ?? null,
    address: json["address"] ?? null,
    addr_city: json["addr_city"] ?? null,
    addr_locality:
    json["addr_locality"] ?? null,
    addr_administrativeUnit: json["addr_administrativeUnit"] ?? null,
    addr_neighbourhood: json["addr_neighbourhood"] ?? null,
    addr_blockNumber:
    json["addr_blockNumber"] ?? null,
    addr_houseNumber:
    json["addr_houseNumber"] ?? null,
    addr_street: json["addr_street"] ?? null,
    addr_postcode:
    json["addr_postcode"] ?? null,
    working_hours: json["working_hours"] == null
        ? null
        : List<String>.from(json["working_hours"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "sn": sn ?? null,
    "fullName": fullName ?? null,
    "firstName": firstName ?? null,
    "lastName": lastName ?? null,
    "imagePath": imagePath ?? null,
    "email": email ?? null,
    "password": password ?? null,
    "confirmedPassword": confirmedPassword ?? null,
    "jobTitle": jobTitle?? null,
    "medicalFacilityName": medicalFacilityName == null
        ? null
        : List<dynamic>.from(medicalFacilityName!.map((x) => x)),
   "medicalFacilityAddress": medicalFacilityAddress == null
       ? null
       : List<dynamic>.from(medicalFacilityAddress!.map((x) => x)),
    "biography": biography ?? null,
    "physicianHistory": physicianHistory ?? null,
    "medicalEducation": medicalEducation ?? null,
    "residency": residency ?? null,
    "internship": internship ?? null,
    "fellowship": fellowship ?? null,
    "prefix": prefix ?? null,
    "specialty": specialty ?? null,
    "medicalFieldSpeciality": medicalFieldSpeciality ?? null,
    "rank": rank ?? null,
    "phoneNumber": phoneNumber ?? null,
    "appointments": appointments ?? null,
    "address": address ?? null,
    "addr_city": addr_city ?? null,
    "addr_locality": addr_locality ?? null,
    "addr_administrativeUnit":
    addr_administrativeUnit ?? null,
    "addr_neighbourhood":
    addr_neighbourhood ?? null,
    "addr_blockNumber": addr_blockNumber ?? null,
    "addr_houseNumber": addr_houseNumber ?? null,
    "addr_street": addr_street ?? null,
    "addr_postcode": addr_postcode ?? null,
    "working_hours": working_hours == null
        ? null
        : List<dynamic>.from(working_hours!.map((x) => x)),
  };
}

