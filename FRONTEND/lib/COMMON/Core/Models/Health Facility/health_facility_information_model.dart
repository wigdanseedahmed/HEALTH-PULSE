///----------------------------- 🌎 PROJECT IMPORTS -----------------------------///
import 'package:health_pulse/imports.dart';

List<HealthFacilityInformationModel> healthFacilityInformationFromJson(
        String str) =>
    List<HealthFacilityInformationModel>.from(json
        .decode(str)
        .map((x) => HealthFacilityInformationModel.fromJson(x)));

String healthFacilityInformationToJson(
        List<HealthFacilityInformationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HealthFacilityInformationModel {
  HealthFacilityInformationModel({
    this.ID,
    this.uuid,
    this.osm_id,
    this.osm_type,
    this.completeness,
    this.is_in_health_zone,
    this.data_source,
    this.file_name,
    this.medical_facility_name_en,
    this.medical_facility_name_ar,
    this.doctor_name,
    this.registration_number,
    this.operator,
    this.sector_type,
    this.facility_type,
    this.healthcare,
    this.amenity,
    this.health_amenity_type,
    this.year_open,
    this.speciality,
    this.ownership_type,
    this.owner,
    this.owner_contact_number,
    this.medical_director_administrative,
    this.medical_director_administrative_contact_number,
    this.contact_number,
    this.optional_contact_number,
    this.address,
    this.addr_city,
    this.addr_locality,
    this.addr_administrativeUnit,
    this.addr_neighbourhood,
    this.addr_blockNumber,
    this.addr_houseNumber,
    this.addr_street,
    this.addr_postcode,
    this.lat,
    this.long,
    this.licencing_type,
    this.new_renew,
    this.licencing_years,
    this.licence_owner_name,
    this.insurance,
    this.insurance_sector_type,
    this.insurance_provided,
    this.opening_hours,
    this.water_source,
    this.staff_doctors,
    this.electricity,
    this.operational_status,
    this.source,
    this.is_in_health_area,
    this.hidden,
    this.emergency,
    this.staff_nurses,
    this.wheelchair,
    this.beds,
    this.url,
    this.dispensing,
    this.operator_type,
    this.changeset_id,
    this.changeset_timestamp,
    this.changeset_user,
    this.changeset_version,
    this.imagePath,
    this.rank,
  });

  int? ID;
  String? uuid;
  String? osm_id;
  String? osm_type;
  String? completeness;
  String? is_in_health_zone;
  String? data_source;
  String? file_name;
  String? medical_facility_name_en;
  String? medical_facility_name_ar;
  String? doctor_name;
  String? registration_number;
  String? operator;
  String? sector_type;
  String? facility_type;
  String? healthcare;
  String? amenity;
  String? health_amenity_type;
  String? year_open;
  List<String>? speciality;
  String? ownership_type;
  String? owner;
  String? owner_contact_number;
  String? medical_director_administrative;
  String? medical_director_administrative_contact_number;
  String? contact_number;
  String? optional_contact_number;
  String? address;
  String? addr_city;
  String? addr_locality;
  String? addr_administrativeUnit;
  String? addr_neighbourhood;
  String? addr_blockNumber;
  String? addr_houseNumber;
  String? addr_street;
  String? addr_postcode;
  double? lat;
  double? long;
  String? licencing_type;
  String? new_renew;
  List<String>? licencing_years;
  String? licence_owner_name;
  String? insurance;
  List<String>? insurance_sector_type;
  List<String>? insurance_provided;
  List<String>? opening_hours;
  String? water_source;
  String? staff_doctors;
  String? electricity;
  String? operational_status;
  List<String>? source;
  String? is_in_health_area;
  String? hidden;
  String? emergency;
  String? staff_nurses;
  String? wheelchair;
  String? beds;
  String? url;
  String? dispensing;
  String? operator_type;
  String? changeset_id;
  String? changeset_timestamp;
  String? changeset_user;
  String? changeset_version;
  String? imagePath;
  double? rank;

  factory HealthFacilityInformationModel.fromJson(Map<String, dynamic> json) =>
      HealthFacilityInformationModel(
        ID: json["ID"] == null ? null : json["ID"].toInt(),
        uuid: json["uuid"] ?? null,
        osm_id: json["osm_id"] ?? null,
        osm_type: json["osm_type"] ?? null,
        completeness: json["completeness"] ?? null,
        is_in_health_zone: json["is_in_health_zone"] ?? null,
        data_source: json["data_source"] ?? null,
        file_name: json["file_name"] ?? null,
        medical_facility_name_en: json["medical_facility_name_en"] ?? null,
        medical_facility_name_ar: json["medical_facility_name_ar"] ?? null,
        doctor_name: json["doctor_name"] ?? null,
        registration_number: json["registration_number"] ?? null,
        operator: json["operator"] ?? null,
        sector_type: json["sector_type"] ?? null,
        facility_type: json["facility_type"] ?? null,
        healthcare: json["healthcare"] ?? null,
        amenity: json["amenity"] ?? null,
        health_amenity_type: json["health_amenity_type"] ?? null,
        year_open: json["year_open"] ?? null,
        speciality: json["speciality"] == null
            ? null
            : List<String>.from(json["speciality"].map((x) => x)),
        ownership_type: json["ownership_type"] ?? null,
        owner: json["owner"] ?? null,
        owner_contact_number: json["owner_contact_number"] ?? null,
        medical_director_administrative:
            json["medical_director_administrative"] ?? null,
        medical_director_administrative_contact_number:
            json["medical_director_administrative_contact_number"] ?? null,
        contact_number: json["contact_number"] ?? null,
        optional_contact_number: json["optional_contact_number"] ?? null,
        address: json["address"] ?? null,
        addr_city: json["addr_city"] ?? null,
        addr_locality: json["addr_locality"] ?? null,
        addr_administrativeUnit: json["addr_administrativeUnit"] ?? null,
        addr_neighbourhood: json["addr_neighbourhood"] ?? null,
        addr_blockNumber: json["addr_blockNumber"] ?? null,
        addr_houseNumber: json["addr_houseNumber"] ?? null,
        addr_street: json["addr_street"] ?? null,
        addr_postcode: json["addr_postcode"] ?? null,
        lat: json["lat"] == null ? null : json["lat"].toDouble(),
        long: json["long"] == null ? null : json["long"].toDouble(),
        licencing_type: json["licencing_type"] ?? null,
        new_renew: json["new_renew"] ?? null,
        licencing_years: json["licencing_years"] == null
            ? null
            : List<String>.from(json["licencing_years"].map((x) => x)),
        licence_owner_name: json["licence_owner_name"] ?? null,
        insurance: json["insurance"] ?? null,
        insurance_sector_type: json["insurance_sector_type"] == null
            ? null
            : List<String>.from(json["insurance_sector_type"].map((x) => x)),
        insurance_provided: json["insurance_provided"] == null
            ? null
            : List<String>.from(json["insurance_provided"].map((x) => x)),
        opening_hours: json["opening_hours"] == null
            ? null
            : List<String>.from(json["opening_hours"].map((x) => x)),
        water_source: json["water_source"] ?? null,
        staff_doctors: json["staff_doctors"] ?? null,
        electricity: json["electricity"] ?? null,
        operational_status: json["operational_status"] ?? null,
        source: json["source"] == null
            ? null
            : List<String>.from(json["source"].map((x) => x)),
        is_in_health_area: json["is_in_health_area"] ?? null,
        hidden: json["hidden"] ?? null,
        emergency: json["emergency"] ?? null,
        staff_nurses: json["staff_nurses"] ?? null,
        wheelchair: json["wheelchair"] ?? null,
        beds: json["beds"] ?? null,
        url: json["url"] ?? null,
        dispensing: json["dispensing"] ?? null,
        operator_type: json["operator_type"] ?? null,
        changeset_id: json["changeset_id"] ?? null,
        changeset_timestamp: json["changeset_timestamp"] ?? null,
        changeset_user: json["changeset_user"] ?? null,
        changeset_version: json["changeset_version"] ?? null,
        imagePath: json["imagePath"] ?? null,
        rank: json["rank"] == null ? null : json["rank"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "ID": ID ?? null,
        "uuid": uuid ?? null,
        "osm_id": osm_id ?? null,
        'osm_type': osm_type ?? null,
        "completeness": completeness ?? null,
        "is_in_health_zone": is_in_health_zone ?? null,
        "data_source": data_source ?? null,
        "file_name": file_name ?? null,
        "medical_facility_name_en": medical_facility_name_en ?? null,
        "medical_facility_name_ar": medical_facility_name_ar ?? null,
        "doctor_name": doctor_name ?? null,
        "registration_number": registration_number ?? null,
        "operator": operator ?? null,
        "sector_type": sector_type ?? null,
        "facility_type": facility_type ?? null,
        "healthcare": healthcare ?? null,
        "amenity": amenity ?? null,
        "health_amenity_type": health_amenity_type ?? null,
        "year_open": year_open ?? null,
        "speciality": speciality == null
            ? null
            : List<dynamic>.from(speciality!.map((x) => x)),
        "ownership_type": ownership_type ?? null,
        "owner": owner ?? null,
        "owner_contact_number": owner_contact_number ?? null,
        "medical_director_administrative":
            medical_director_administrative ?? null,
        "medical_director_administrative_contact_number":
            medical_director_administrative_contact_number ?? null,
        "contact_number": contact_number ?? null,
        "optional_contact_number": optional_contact_number ?? null,
        "address": address ?? null,
        "addr_city": addr_city ?? null,
        "addr_locality": addr_locality ?? null,
        "addr_administrativeUnit": addr_administrativeUnit ?? null,
        "addr_neighbourhood": addr_neighbourhood ?? null,
        "addr_blockNumber": addr_blockNumber ?? null,
        "addr_houseNumber": addr_houseNumber ?? null,
        "addr_street": addr_street ?? null,
        "addr_postcode": addr_postcode ?? null,
        "lat": lat ?? null,
        "long": long ?? null,
        "licencing_type": licencing_type ?? null,
        "new_renew": new_renew ?? null,
        "licencing_years": licencing_years ?? null,
        "licence_owner_name": licence_owner_name ?? null,
        "insurance": insurance ?? null,
        "insurance_sector_type": insurance_sector_type == null
            ? null
            : List<dynamic>.from(insurance_sector_type!.map((x) => x)),
        "insurance_provided": insurance_provided ?? null,
        "opening_hours": opening_hours == null
            ? null
            : List<dynamic>.from(opening_hours!.map((x) => x)),
        "water_source": water_source ?? null,
        "staff_doctors": staff_doctors ?? null,
        "electricity": electricity ?? null,
        "operational_status": operational_status ?? null,
        "source":
            source == null ? null : List<dynamic>.from(source!.map((x) => x)),
        "is_in_health_area": is_in_health_area ?? null,
        "hidden": hidden ?? null,
        "emergency": emergency ?? null,
        "staff_nurses": staff_nurses ?? null,
        "wheelchair": wheelchair ?? null,
        "beds": beds ?? null,
        "url": url ?? null,
        "dispensing": dispensing ?? null,
        "operator_type": operator_type ?? null,
        "changeset_id": changeset_id ?? null,
        "changeset_timestamp": changeset_timestamp ?? null,
        "changeset_user": changeset_user ?? null,
        "changeset_version": changeset_version ?? null,
        "imagePath": imagePath ?? null,
        "rank": rank ?? null,
      };
}
