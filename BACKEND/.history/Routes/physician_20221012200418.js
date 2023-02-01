///------------------------------------------ IMPORT ------------------------------------------///


///---------------------- FILES ----------------------///
const { getPhysicians,
  getPhysician,
  checkPhysicianUsernameExists,
  checkPhysicianEmailExists,
  updatePhysicianInformationByID,
  updatePhysicianInformationByUsername,
  updatePhysicianInformationByEmail,
  updatePhysicianPasswordByUsername,
  updatePhysicianPasswordByEmail,
  deletePhysicianByID,
  deletePhysicianByUsername,
  deletePhysicianByEmail } = require("../Controller/physician_api_controller");

///---------------------- LIBRARIES ----------------------///
const config = require("../config");
let middleware = require("../middleware");

const jwt = require("jsonwebtoken");

const express = require("express");
const router = express.Router();

///---------------------- ROUTES ----------------------///
// Get a list of Physicians from the DB
router.get('/physicians', getPhysicians);

router.route("/physician/:Username").get(middleware.checkToken, getPhysician);

// Check to see if Physician exists
router.route("/physician/checkUsername/:Username").get(checkPhysicianUsernameExists);

router.route("/physician/checkemail/:email").get(checkPhysicianEmailExists);

// Login Physician
////router.route("/login").post(logIn);

// Register Physician
////router.route("/register").post(register);

// Update Physician information in the DB
router.put("/physician/id/:id", updatePhysicianInformationByID);

router.put("/physician/Username/:Username", updatePhysicianInformationByUsername);

router.put("/physician/email/:email", updatePhysicianInformationByEmail);

// Update Physician password in the DB
router.put("/physician/password/Username/:Username", updatePhysicianPasswordByUsername);

router.put("/physician/password/email/:email", updatePhysicianPasswordByEmail);

// Delete a Physician from the DB
router.delete("/physician/id/:id", deletePhysicianByID);

router.delete("/physician/Username/:Username", deletePhysicianByUsername);

router.delete("/physician/email/:email", deletePhysicianByEmail);

///---------------------- EXPORTS ----------------------///
module.exports = router;