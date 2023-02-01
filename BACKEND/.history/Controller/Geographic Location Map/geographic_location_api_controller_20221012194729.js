///------------------------------------------ IMPORT ------------------------------------------///

///---------------------- FILES ----------------------///
const {LocationSchema,
  LocationModel} = require("../../Models/Geographic Location Map/geographic_location_model");

///---------------------- LIBRARIES ----------------------///
const config = require("../config");

const jwt = require("jsonwebtoken");

///---------------------- CONTROLLERS ----------------------///
// Get a list of users from the DB
const getLocations = ((req,res, next) => {
  // Get all data
  LocationModel.find({}).then(function(locations){
       res.send(locations);
  });
});

const getLocation = ( (req, res) => {
  LocationModel.findOne({ locationName: req.params.locationName }, (err, result) => {
    if (err) return res.status(500).json({ msg: err });
    return res.json({
      data: result,
      locationName: req.params.locationName,
    });
  });
});


// Update a user information in the DB
const updateLocationInformationByID= ((req,res, next) => {
    //to access :id ---> req.params.id
    LocationModel.findByIdAndUpdate({ _id: req.params.id }, {$set:req.body}).then(function () {
      LocationModel.findOne({ _id: req.params.id }).then(function (location) {
            res.send(location);
        });
    });
  });

  // Update a location info in the DB
const updateLocationInformationByLocationName= ((req,res, next) => {
    //to access :id ---> req.params.id
    LocationModel.findOneAndUpdate({ locationName: req.params.locationName }, {$set:req.body}).then(function () {
      LocationModel.findOne({ locationName: req.params.locationName }).then(function (location) {
            res.send(location);
        });
    });
  });

// Delete a user from the DB
const deleteLocationByID = ((req, res, next) => {
    //to access :id ---> req.params.id
    LocationModel.findByIdAndDelete({ _id: req.params.id }).then(function (user) {
        res.send(user);
    });
})

const deleteLocationByLocationName = ((req,res, next) => {
  //to access :locationName ---> req.params.locationName
  LocationModel.findByIdAndDelete({ locationName: req.params.locationName }).then(function (user) {
    res.send(user);
});
});

///---------------------- EXPORTS ----------------------///
module.exports = {
  getLocations: getLocations,
  getLocation: getLocation,
  updateLocationInformationByID: updateLocationInformationByID,
  updateLocationInformationByLocationName: updateLocationInformationByLocationName,
  deleteLocationByID: deleteLocationByID,
  deleteLocationByLocationName: deleteLocationByLocationName,
};