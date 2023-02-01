///------------------------------------------ IMPORT ------------------------------------------///

///---------------------- FILES ----------------------///
const {HealthFacilitySchema,
   HealthFacilityModel} = require("../../Models/Health Facility/health_facility_model");

///---------------------- LIBRARIES ----------------------///
const config = require("../../config");

const jwt = require("jsonwebtoken");

///---------------------- CONTROLLERS ----------------------///
// Get a list of users from the DB
const getHealthFacilities = ((req,res, next) => {
  // Get all data
  HealthFacilityModel.find({}).then(function(locations){
       res.send(locations);
  });
});

const getHealthFacility = ( (req, res) => {
  HealthFacilityModel.findOne({ locationName: req.params.locationName }, (err, result) => {
    if (err) return res.status(500).json({ msg: err });
    return res.json({
      data: result,
      locationName: req.params.locationName,
    });
  });
});


// Update a user information in the DB
const updateHealthFacilityInformationByID= ((req,res, next) => {
    //to access :id ---> req.params.id
    HealthFacilityModel.findByIdAndUpdate({ _id: req.params.id }, {$set:req.body}).then(function () {
      HealthFacilityModel.findOne({ _id: req.params.id }).then(function (location) {
            res.send(location);
        });
    });
  });

  // Update a location info in the DB
const updateHealthFacilityInformationByHealthFacilityName= ((req,res, next) => {
    //to access :id ---> req.params.id
    HealthFacilityModel.findOneAndUpdate({ locationName: req.params.locationName }, {$set:req.body}).then(function () {
      HealthFacilityModel.findOne({ locationName: req.params.locationName }).then(function (location) {
            res.send(location);
        });
    });
  });

// Delete a user from the DB
const deleteHealthFacilityByID = ((req, res, next) => {
    //to access :id ---> req.params.id
    HealthFacilityModel.findByIdAndDelete({ _id: req.params.id }).then(function (user) {
        res.send(user);
    });
})

const deleteHealthFacilityByHealthFacilityName = ((req,res, next) => {
  //to access :locationName ---> req.params.locationName
  HealthFacilityModel.findByIdAndDelete({ locationName: req.params.locationName }).then(function (user) {
    res.send(user);
});
});

///---------------------- EXPORTS ----------------------///
module.exports = {
  getHealthFacilities: getHealthFacilities,
  getHealthFacility: getHealthFacility,
  updateHealthFacilityInformationByID: updateHealthFacilityInformationByID,
  updateHealthFacilityInformationByHealthFacilityName: updateHealthFacilityInformationByHealthFacilityName,
  deleteHealthFacilityByID: deleteHealthFacilityByID,
  deleteHealthFacilityByHealthFacilityName: deleteHealthFacilityByHealthFacilityName,
};