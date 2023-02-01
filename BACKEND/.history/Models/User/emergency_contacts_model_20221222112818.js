
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

///------------------------------------------ EXPORT ------------------------------------------///
module.exports = {
    emergencyContactsSchema: emergencyContactsSchema
};