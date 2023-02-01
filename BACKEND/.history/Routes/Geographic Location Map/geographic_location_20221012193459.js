
///------------------------------------------ IMPORT ------------------------------------------///


///---------------------- FILES ----------------------///
const {
  getLocations,
  getLocation,
  updateLocationInformationByID,
  updateLocationInformationByLocationName,
  deleteLocationByID,
  deleteLocationByLocationName,
} = require("../../Controller/Geographic Location Map/geographic_location_api_controller");


///---------------------- LIBRARIES ----------------------///

let middleware = require("../../middleware");

const jwt = require("jsonwebtoken");

const express = require("express");
const router = express.Router();

///------------------------------------------ ROUTES ------------------------------------------///
// Get a list of Locations from the DB
router.get('/locations', getLocations);

router.route("/location/:locationName").get(middleware.checkToken, getLocation);

// Update Location information in the DB
router.put("/location/id/:id", updateLocationInformationByID);

router.put("/location/locationName/:locationName", updateLocationInformationByLocationName);


// Delete a Location from the DB
router.delete("/location/id/:id", deleteLocationByID);

router.delete("/location/locationName/:locationName", deleteLocationByLocationName);

///------------------------------------------ EXPORT ------------------------------------------///
module.exports = router;