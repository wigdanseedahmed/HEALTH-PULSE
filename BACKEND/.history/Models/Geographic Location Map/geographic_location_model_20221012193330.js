///------------------------------------------ IMPORT ------------------------------------------///

///---------------------- LIBRARIES ----------------------///
const mongoose = require('mongoose');
const Schema = mongoose.Schema;

///------------------------------------------ SCHEMA ------------------------------------------///
var LocationSchema = new Schema({
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
var LocationModel = mongoose.model('hospital_location_data', LocationSchema, 'hospital_location_data');

///------------------------------------------ EXPORT ------------------------------------------///
module.exports = {
    LocationSchema: LocationSchema,
    LocationModel: LocationModel
};