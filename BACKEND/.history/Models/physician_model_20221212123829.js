///------------------------------------------ IMPORT ------------------------------------------///

///---------------------- LIBRARIES ----------------------///
const mongoose = require('mongoose');
const Schema = mongoose.Schema;

///------------------------------------------ SCHEMA ------------------------------------------///
var physicianSchema = new Schema({
    sn: {
        type: Number,
        unique: true
    },

    fullName: {
        type: String,
    },
    firstName: {
        type: String,
    },
    lastName: {
        type: String,
    },
    username: {
        type: String,
        required: true,
        unique: true,
    },
    email: {
        type: String,
        required: true,
    },
    password: {
        type: String,
        required: true,
    },
    confirmedPassword: {
        type: String,
    },
    imagePath: {
        type: String,
    },
    biography: {
        type: String,
    },
    physicianHistory: {
        type: String,
    },
    medicalEducation: {
        type: String,
    },
    residency: {
        type: String,
    },
    internship: {
        type: String,
    },
    fellowship: {
        type: String,
    },
    prefix: {
        type: String,
    },
    medicalFieldSpeciality: {
        type: String,
    },
    specialty: {
        type: String,
    },
    rank: {
        type: Number,
    },
    phoneNumber: {
        type: String,
    },
    appointments: {
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
    working_hours: {
        type: String,
    },

});


///------------------------------------------ MODEL ------------------------------------------///
// This two schemas will save on the 'users' collection.
var PhysicianModel = mongoose.model('doctor_data', physicianSchema, 'doctor_data');

///------------------------------------------ EXPORT ------------------------------------------///
module.exports = {
    physicianSchema: physicianSchema,
    PhysicianModel: PhysicianModel
};