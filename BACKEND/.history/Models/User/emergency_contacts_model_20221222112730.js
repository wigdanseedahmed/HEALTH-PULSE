
///------------------------------------------ IMPORT ------------------------------------------///

///---------------------- LIBRARIES ----------------------///
const mongoose = require('mongoose');
const Schema = mongoose.Schema;

///------------------------------------------ SCHEMA ------------------------------------------///
var emergencyContactsSchema = new Schema({
    emergencyNumber: {
        type: Number,
        unique: true
    },
    emergencyContactName: {
        type: String,
        required: true,
        unique: true,
    },
    emergencyContactCellPhoneNumber: {
        type: String,
        required: true,
    },
    emergencyContactHomePhoneNumber: {
        type: String,
    },
    emergencyContactWorkPhoneNumber: {
        type: String,
    },
    emergencyContactRelationshipToYou: {
        type: String,
    },
    emergencyContactAddress: {
        type: String,
    },
});

///------------------------------------------ MODEL ------------------------------------------///
// This two schemas will save on the 'users' collection.
var EmergencyContactsModel = mongoose.model('User', emergencyContactsSchema, 'user_data');

///------------------------------------------ EXPORT ------------------------------------------///
module.exports = {
    emergencyContactsSchema: emergencyContactsSchema,
    EmergencyContactsModel: EmergencyContactsModel
};