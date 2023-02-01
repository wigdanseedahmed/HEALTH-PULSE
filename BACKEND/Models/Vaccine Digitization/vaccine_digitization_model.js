///------------------------------------------ IMPORT ------------------------------------------///

///---------------------- LIBRARIES ----------------------///
const mongoose = require('mongoose');
const Schema = mongoose.Schema;

///------------------------------------------ SCHEMA ------------------------------------------///
var vaccineDigitizationSchema = new Schema({
    name: {
        type: String,
        unique: true
    },
    type: {
        type: String,
    },
    addedOn: {
        type: String,
    },
    barCodeResultString: {
        type: String,
    },
    barCodeResult: {
        type: String,
    },
});



///------------------------------------------ MODEL ------------------------------------------///
// This two schemas will save on the 'users' collection.
var VaccineDigitizationModel = mongoose.model('vaccine_digization_data', vaccineDigitizationSchema, 'vaccine_digization_data');

///------------------------------------------ EXPORT ------------------------------------------///
module.exports = {
    vaccineDigitizationSchema: vaccineDigitizationSchema,
    VaccineDigitizationModel: VaccineDigitizationModel,
};