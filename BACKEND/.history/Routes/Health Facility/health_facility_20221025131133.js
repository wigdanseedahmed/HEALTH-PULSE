
///------------------------------------------ IMPORT ------------------------------------------///


///---------------------- FILES ----------------------///
const {
  getHealthFacilities,
  getHealthFacility,
  updateHealthFacilityInformationByID,
  updateHealthFacilityInformationByHealthFacilityName,
  deleteHealthFacilityByID,
  deleteHealthFacilityByHealthFacilityName,
} = require("../../Controller/Geographic HealthFacility Map/geographic_healthFacility_api_controller");


///---------------------- LIBRARIES ----------------------///

let middleware = require("../../middleware");

const jwt = require("jsonwebtoken");

const express = require("express");
const router = express.Router();

///------------------------------------------ ROUTES ------------------------------------------///
///------ Get a list of HealthFacilities from the DB ------///
router.get('/', getHealthFacilities);

router.route("/:healthFacilityName").get(middleware.checkToken, getHealthFacility);

///------ Update HealthFacility information in the DB ------///
router.put("/update/id/:id", updateHealthFacilityInformationByID);

router.put("/update/healthFacilityName/:healthFacilityName", updateHealthFacilityInformationByHealthFacilityName);


///------ Delete a HealthFacility from the DB ------///
router.delete("/delete/id/:id", deleteHealthFacilityByID);

router.delete("/delete/healthFacilityName/:healthFacilityName", deleteHealthFacilityByHealthFacilityName);

///------------------------------------------ EXPORT ------------------------------------------///
module.exports = router;