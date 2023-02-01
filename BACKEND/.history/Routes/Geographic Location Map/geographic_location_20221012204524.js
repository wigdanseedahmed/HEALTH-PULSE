
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
router.get('/', getLocations);

router.route("/:locationName").get(middleware.checkToken, getLocation);

// Update Location information in the DB
router.put("/update/id/:id", updateLocationInformationByID);

router.put("/update/locationName/:locationName", updateLocationInformationByLocationName);


// Delete a Location from the DB
router.delete("/delete/id/:id", deleteLocationByID);

router.delete("/delete/locationName/:locationName", deleteLocationByLocationName);

///------------------------------------------ EXPORT ------------------------------------------///
module.exports = router;