
///------------------------------------------ IMPORT ------------------------------------------///

///---------------------- LIBRARIES ----------------------///
const mongoose = require('mongoose');
const Schema = mongoose.Schema;

///------------------------------------------ SCHEMA ------------------------------------------///
var emergencyContactsSchema = new Schema({
    emergencyNumber: {
        type: Number
    },
    emergencyContactName: {
        type: String,
    },
    emergencyContactCellPhoneNumber: {
        type: String,
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