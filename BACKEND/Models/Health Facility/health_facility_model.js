///------------------------------------------ IMPORT ------------------------------------------///

///---------------------- LIBRARIES ----------------------///
const mongoose = require('mongoose');
const Schema = mongoose.Schema;

///------------------------------------------ SCHEMA ------------------------------------------///
var HealthFacilitySchema = new Schema({

    ID: {
        type: Number,
    },
    uuid: {
        type: String,
    },
    osm_id: {
        type: String,
    },
    osm_type: {
        type: String,
    },
    completeness: {
        type: String,
    },
    is_in_health_zone: {
        type: String,
    },
    data_source: {
        type: String,
    },
    file_name: {
        type: String,
    },
    medical_facility_name_en: {
        type: String,
    },
    medical_facility_name_ar: {
        type: String,
    },
    doctor_name: {
        type: String,
    },
    registration_number: {
        type: String,
    },
    operator: {
        type: String,
    },
    sector_type: {
        type: String,
    },
    facility_type: {
        type: String,
    },
    healthcare: {
        type: String,
    },
    amenity: {
        type: String,
    },
    health_amenity_type: {
        type: String,
    },
    year_open: {
        type: String,
    },
    speciality: [String],
    ownership_type: {
        type: String,
    },
    owner: {
        type: String,
    },
    owner_contact_number: {
        type: String,
    },
    medical_director_administrative: {
        type: String,
    },
    medical_director_administrative_contact_number: {
        type: String,
    },
    contact_number: {
        type: String,
    },
    optional_contact_number: {
        type: String,
    },
    address: {
        type: String,
    },
    addr_city: {
        type: String,
    },
    addr_locality: {
        type: String,
    },
    addr_administrativeUnit: {
        type: String,
    },
    addr_neighbourhood: {
        type: String,
    },
    addr_blockNumber: {
        type: String,
    },
    addr_houseNumber: {
        type: String,
    },
    addr_street: {
        type: String,
    },
    addr_postcode: {
        type: String,
    },
    lat: {
        type: Number,
    },

    long: {
        type: Number,
    },
    licencing_type: {
        type: String,
    },
    new_renew: {
        type: String,
    },
    licencing_years: [String],
    licence_owner_name: {
        type: String,
    },
    insurance: {
        type: String,
    },
    insurance_sector_type: [String],    
    insurance_provided: {
        type: String,
    },
    opening_hours: [String],
    water_source: {
        type: String,
    },
    staff_doctors: {
        type: String,
    },
    electricity: {
        type: String,
    },
    operational_status: {
        type: String,
    },
    source: {
        type: String,
    },
    is_in_health_area: {
        type: String,
    },
    hidden: {
        type: String,
    },
    emergency: {
        type: String,
    },
    staff_nurses: {
        type: String,
    },
    wheelchair: {
        type: String,
    },
    beds: {
        type: String,
    },
    url: {
        type: String,
    },
    dispensing: {
        type: String,
    },
    operator_type: {
        type: String,
    },
    changeset_id: {
        type: String,
    },
    changeset_timestamp: {
        type: String,
    },
    changeset_user: {
        type: String,
    },
    changeset_version: {
        type: String,
    },


});


///------------------------------------------ MODEL ------------------------------------------///
// This two schemas will save on the 'users' collection.
var HealthFacilityModel = mongoose.model('health_facilities_data', HealthFacilitySchema, 'health_facilities_data');

///------------------------------------------ EXPORT ------------------------------------------///
module.exports = {
    HealthFacilitySchema: HealthFacilitySchema,
    HealthFacilityModel:
        HealthFacilityModel
};