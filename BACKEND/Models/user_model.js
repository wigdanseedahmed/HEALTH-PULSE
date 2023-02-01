///------------------------------------------ IMPORT ------------------------------------------///

///---------------------- FILES ----------------------///
const {
    vaccineDigitizationSchema,
    VaccineDigitizationModel,
} = require('../Models/Vaccine Digitization/vaccine_digitization_model');
const {
    emergencyContactsSchema
} = require('../Models/User/emergency_contacts_model');


///---------------------- LIBRARIES ----------------------///
const mongoose = require('mongoose');
const Schema = mongoose.Schema;

///------------------------------------------ SCHEMA ------------------------------------------///
var loginUserSchema = new Schema({
    sn: {
        type: Number,
        unique: true
    },
    username: {
        type: String,
        unique: true,
    },
    password: {
        type: String,
        required: true,
    },
    email: {
        type: String,
        required: true,
    },
});

var registerUserSchema = new Schema({
    sn: {
        type: Number,
        unique: true
    },
     prefix: {
        type: String,
    },
     username: {
        type: String,
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
     userPhotoURL: {
        type: String,
    },
     userPhotoName: {
        type: String,
    },
     userPhotoFile: {
        type: String,
    },
     nationality: {
        type: String,
    },
     occupation: {
        type: String,
    },
     email: {
        type: String,
        unique: true
    },
     password: {
        type: String,
    },
     confirmedPassword: {
        type: String,
    },
    userHealthScore: {
        type: Number
    },
    userWeight: {
        type: Number
    },
    userHeight: {
        type: Number
    },
     userAge: {
        type: String,
    },
     userAddress: {
        type: String,
    },
    userBmi: {
        type: Number
    },
     userLanguage: {
        type: String,
    },
     userPhoneNumber: {
        type: String,
    },
     optionalPhoneNumber: {
        type: String,
    },
     userGender: {
        type: String,
    },
     userDateOfBirth: {
        type: String,
    },
     phoneNumber: {
        type: String,
    },
    emergencyContacts: [emergencyContactsSchema],
     chronicDiseaseList: [String],
     bookmarkedHealthPersonnelList: [String],
     bookmarkedHealthFacilitiesList: [String],
     vaccineCertificatesList: [vaccineDigitizationSchema],
     dateUpdated:  {
        type: Date
    },
     dateCreate:  {
        type: Date
    },
     selectedTheme: {
        type: String,
    },
});



///------------------------------------------ MODEL ------------------------------------------///
// This two schemas will save on the 'users' collection.
var User = mongoose.model('User', loginUserSchema, 'user_data');
var registerUser = mongoose.model('Registered', registerUserSchema, 'user_data');

///------------------------------------------ EXPORT ------------------------------------------///
module.exports = {
    User: User,
    registerUser: registerUser
};