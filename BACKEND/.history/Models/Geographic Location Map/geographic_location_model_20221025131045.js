///------------------------------------------ IMPORT ------------------------------------------///

///---------------------- LIBRARIES ----------------------///
const mongoose = require('mongoose');
const Schema = mongoose.Schema;

///------------------------------------------ SCHEMA ------------------------------------------///
var HealthFacilitySchema = new Schema({
    name: {
        type: String,
    },
    type: {
        type: String,
    },
    locality: {
        type: String,
    },
    lat: {
        type: Number
    },

    long: {
        type: Number
    },
    address: {
        type: String,
    },
    imagePath: {
        type: String,
    },
    rank: {
        type: Number
    },


});


///------------------------------------------ MODEL ------------------------------------------///
// This two schemas will save on the 'users' collection.
var HealthFacilityModel = mongoose.model('health_facilities_data', HealthFacilitySchema, 'health_facilities_data');

///------------------------------------------ EXPORT ------------------------------------------///
module.exports = {
    HealthFacilitySchema: HealthFacilitySchema,
    HealthFacilityModel: HealthFacilityModel
};