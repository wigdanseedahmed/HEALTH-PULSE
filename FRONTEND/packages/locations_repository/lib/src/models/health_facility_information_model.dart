import 'dart:convert';
import 'dart:core';

List<HealthFacilityInformation> healthFacilityInfoFromJson(String str) =>
    List<HealthFacilityInformation>.from((json.decode(str)).map(
            (Map<String, dynamic> x) => HealthFacilityInformation.fromJson(x))
        as Iterable<dynamic>);

String healthFacilityInfoToJson(List<HealthFacilityInformation> data) =>
    json.encode(
        List<dynamic>.from((data).map((x) => x.toJson()) as Iterable<dynamic>));

class HealthFacilityInformation {
  HealthFacilityInformation({
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

  factory HealthFacilityInformation.fromJson(Map<String, dynamic> json) =>
      HealthFacilityInformation(
        ID: json["ID"] == null ? null : json["ID"].toInt() as int,
        uuid: json["uuid"] == null ? null : json["uuid"] as String,
        osm_id: json["osm_id"] == null ? null : json["osm_id"] as String,
        osm_type: json["osm_type"] == null ? null : json["osm_type"] as String,
        completeness: json["completeness"] == null
            ? null
            : json["completeness"] as String,
        is_in_health_zone: json["is_in_health_zone"] == null
            ? null
            : json["is_in_health_zone"] as String,
        data_source:
            json["data_source"] == null ? null : json["data_source"] as String,
        file_name:
            json["file_name"] == null ? null : json["file_name"] as String,
        medical_facility_name_en: json["medical_facility_name_en"] == null
            ? null
            : json["medical_facility_name_en"] as String,
        medical_facility_name_ar: json["medical_facility_name_ar"] == null
            ? null
            : json["medical_facility_name_ar"] as String,
        doctor_name:
            json["doctor_name"] == null ? null : json["doctor_name"] as String,
        registration_number: json["registration_number"] == null
            ? null
            : json["registration_number"] as String,
        operator: json["operator"] == null ? null : json["operator"] as String,
        sector_type:
            json["sector_type"] == null ? null : json["sector_type"] as String,
        facility_type: json["facility_type"] == null
            ? null
            : json["facility_type"] as String,
        healthcare:
            json["healthcare"] == null ? null : json["healthcare"] as String,
        amenity: json["amenity"] == null ? null : json["amenity"] as String,
        health_amenity_type: json["health_amenity_type"] == null
            ? null
            : json["health_amenity_type"] as String,
        year_open:
            json["year_open"] == null ? null : json["year_open"] as String,
        speciality: json["speciality"] == null
            ? null
            : List<String>.from(
                json["speciality"].map((Map<String, dynamic> x) => x)
                    as Iterable<dynamic>) as List<String>,
        ownership_type: json["ownership_type"] == null
            ? null
            : json["ownership_type"] as String,
        owner: json["owner"] == null ? null : json["owner"] as String,
        owner_contact_number: json["owner_contact_number"] == null
            ? null
            : json["owner_contact_number"] as String,
        medical_director_administrative:
            json["medical_director_administrative"] == null
                ? null
                : json["medical_director_administrative"] as String,
        medical_director_administrative_contact_number:
            json["medical_director_administrative_contact_number"] == null
                ? null
                : json["medical_director_administrative_contact_number"]
                    as String,
        contact_number: json["contact_number"] == null
            ? null
            : json["contact_number"] as String,
        optional_contact_number: json["optional_contact_number"] == null
            ? null
            : json["optional_contact_number"] as String,
        address: json["address"] == null ? null : json["address"] as String,
        addr_city:
            json["addr_city"] == null ? null : json["addr_city"] as String,
        addr_locality: json["addr_locality"] == null
            ? null
            : json["addr_locality"] as String,
        addr_administrativeUnit: json["addr_administrativeUnit"] == null
            ? null
            : json["addr_administrativeUnit"] as String,
        addr_neighbourhood: json["addr_neighbourhood"] == null
            ? null
            : json["addr_neighbourhood"] as String,
        addr_blockNumber: json["addr_blockNumber"] == null
            ? null
            : json["addr_blockNumber"] as String,
        addr_houseNumber: json["addr_houseNumber"] == null
            ? null
            : json["addr_houseNumber"] as String,
        addr_street:
            json["addr_street"] == null ? null : json["addr_street"] as String,
        addr_postcode: json["addr_postcode"] == null
            ? null
            : json["addr_postcode"] as String,
        lat: json["lat"] == null ? null : json["lat"].toDouble() as double,
        long: json["long"] == null ? null : json["long"].toDouble() as double,
        licencing_type: json["licencing_type"] == null
            ? null
            : json["licencing_type"] as String,
        new_renew:
            json["new_renew"] == null ? null : json["new_renew"] as String,
        licencing_years: json["licencing_years"] == null
            ? null
            : List<String>.from(
                json["licencing_years"].map((Map<String, dynamic> x) => x)
                    as Iterable<dynamic>) as List<String>,
        licence_owner_name: json["licence_owner_name"] == null
            ? null
            : json["licence_owner_name"] as String,
        insurance:
            json["insurance"] == null ? null : json["insurance"] as String,
        insurance_provided: json["insurance_provided"] == null
            ? null
            : List<String>.from(
                json["insurance_provided"].map((Map<String, dynamic> x) => x)
                    as Iterable<dynamic>) as List<String>,
        opening_hours: json["opening_hours"] == null
            ? null
            : List<String>.from(
                json["opening_hours"].map((Map<String, dynamic> x) => x)
                    as Iterable<dynamic>) as List<String>,
        water_source: json["water_source"] == null
            ? null
            : json["water_source"] as String,
        staff_doctors: json["staff_doctors"] == null
            ? null
            : json["staff_doctors"] as String,
        electricity:
            json["electricity"] == null ? null : json["electricity"] as String,
        operational_status: json["operational_status"] == null
            ? null
            : json["operational_status"] as String,
        source: json["source"] == null
            ? null
            : List<String>.from(
                json["source"].map((Map<String, dynamic> x) => x)
                    as Iterable<dynamic>) as List<String>,
        is_in_health_area: json["is_in_health_area"] == null
            ? null
            : json["is_in_health_area"] as String,
        hidden: json["hidden"] == null ? null : json["hidden"] as String,
        emergency:
            json["emergency"] == null ? null : json["emergency"] as String,
        staff_nurses: json["staff_nurses"] == null
            ? null
            : json["staff_nurses"] as String,
        wheelchair:
            json["wheelchair"] == null ? null : json["wheelchair"] as String,
        beds: json["beds"] == null ? null : json["beds"] as String,
        url: json["url"] == null ? null : json["url"] as String,
        dispensing:
            json["dispensing"] == null ? null : json["dispensing"] as String,
        operator_type: json["operator_type"] == null
            ? null
            : json["operator_type"] as String,
        changeset_id: json["changeset_id"] == null
            ? null
            : json["changeset_id"] as String,
        changeset_timestamp: json["changeset_timestamp"] == null
            ? null
            : json["changeset_timestamp"] as String,
        changeset_user: json["changeset_user"] == null
            ? null
            : json["changeset_user"] as String,
        changeset_version: json["changeset_version"] == null
            ? null
            : json["changeset_version"] as String,
        imagePath:
            json["imagePath"] == null ? null : json["imagePath"] as String,
        rank: json["rank"] == null ? null : json["rank"].toDouble() as double,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        "ID": ID == null ? null : ID,
        "uuid": uuid == null ? null : uuid,
        "osm_id": osm_id == null ? null : osm_id,
        'osm_type': osm_type == null ? null : osm_type,
        "completeness": completeness == null ? null : completeness,
        "is_in_health_zone":
            is_in_health_zone == null ? null : is_in_health_zone,
        "data_source": data_source == null ? null : data_source,
        "file_name": file_name == null ? null : file_name,
        "medical_facility_name_en":
            medical_facility_name_en == null ? null : medical_facility_name_en,
        "medical_facility_name_ar":
            medical_facility_name_ar == null ? null : medical_facility_name_ar,
        "doctor_name": doctor_name == null ? null : doctor_name,
        "registration_number":
            registration_number == null ? null : registration_number,
        "operator": operator == null ? null : operator,
        "sector_type": sector_type == null ? null : sector_type,
        "facility_type": facility_type == null ? null : facility_type,
        "healthcare": healthcare == null ? null : healthcare,
        "amenity": amenity == null ? null : amenity,
        "health_amenity_type":
            health_amenity_type == null ? null : health_amenity_type,
        "year_open": year_open == null ? null : year_open,
        "speciality": speciality == null
            ? null
            : List<dynamic>.from(
                speciality!.map((x) => x) as Iterable<dynamic>),
        "ownership_type": ownership_type == null ? null : ownership_type,
        "owner": owner == null ? null : owner,
        "owner_contact_number":
            owner_contact_number == null ? null : owner_contact_number,
        "medical_director_administrative":
            medical_director_administrative == null
                ? null
                : medical_director_administrative,
        "medical_director_administrative_contact_number":
            medical_director_administrative_contact_number == null
                ? null
                : medical_director_administrative_contact_number,
        "contact_number": contact_number == null ? null : contact_number,
        "optional_contact_number":
            optional_contact_number == null ? null : optional_contact_number,
        "address": address == null ? null : address,
        "addr_city": addr_city == null ? null : addr_city,
        "addr_locality": addr_locality == null ? null : addr_locality,
        "addr_administrativeUnit":
            addr_administrativeUnit == null ? null : addr_administrativeUnit,
        "addr_neighbourhood":
            addr_neighbourhood == null ? null : addr_neighbourhood,
        "addr_blockNumber": addr_blockNumber == null ? null : addr_blockNumber,
        "addr_houseNumber": addr_houseNumber == null ? null : addr_houseNumber,
        "addr_street": addr_street == null ? null : addr_street,
        "addr_postcode": addr_postcode == null ? null : addr_postcode,
        "lat": lat == null ? null : lat,
        "long": long == null ? null : long,
        "licencing_type": licencing_type == null ? null : licencing_type,
        "new_renew": new_renew == null ? null : new_renew,
        "licencing_years": licencing_years == null ? null : licencing_years,
        "licence_owner_name":
            licence_owner_name == null ? null : licence_owner_name,
        "insurance": insurance == null ? null : insurance,
        "insurance_provided":
            insurance_provided == null ? null : insurance_provided,
        "opening_hours": opening_hours == null
            ? null
            : List<dynamic>.from(
                opening_hours!.map((x) => x) as Iterable<dynamic>),
        "water_source": water_source == null ? null : water_source,
        "staff_doctors": staff_doctors == null ? null : staff_doctors,
        "electricity": electricity == null ? null : electricity,
        "operational_status":
            operational_status == null ? null : operational_status,
        "source": source == null
            ? null
            : List<dynamic>.from(source!.map((x) => x) as Iterable<dynamic>),
        "is_in_health_area":
            is_in_health_area == null ? null : is_in_health_area,
        "hidden": hidden == null ? null : hidden,
        "emergency": emergency == null ? null : emergency,
        "staff_nurses": staff_nurses == null ? null : staff_nurses,
        "wheelchair": wheelchair == null ? null : wheelchair,
        "beds": beds == null ? null : beds,
        "url": url == null ? null : url,
        "dispensing": dispensing == null ? null : dispensing,
        "operator_type": operator_type == null ? null : operator_type,
        "changeset_id": changeset_id == null ? null : changeset_id,
        "changeset_timestamp":
            changeset_timestamp == null ? null : changeset_timestamp,
        "changeset_user": changeset_user == null ? null : changeset_user,
        "changeset_version":
            changeset_version == null ? null : changeset_version,
        "imagePath": imagePath == null ? null : imagePath,
        "rank": rank == null ? null : rank,
      };
}
