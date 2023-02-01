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
router.get('/', getPhysicians);

router.route("/:Username").get(middleware.checkToken, getPhysician);

// Check to see if Physician exists
router.route("/checkUsername/:Username").get(checkPhysicianUsernameExists);

router.route("/checkemail/:email").get(checkPhysicianEmailExists);

// Login Physician
////router.route("/login").post(logIn);

// Register Physician
////router.route("/register").post(register);

// Update Physician information in the DB
router.put("/update/id/:id", updatePhysicianInformationByID);

router.put("/update/Username/:Username", updatePhysicianInformationByUsername);

router.put("/update/email/:email", updatePhysicianInformationByEmail);

// Update Physician password in the DB
router.put("/update/password/Username/:Username", updatePhysicianPasswordByUsername);

router.put("/update/password/email/:email", updatePhysicianPasswordByEmail);

// Delete a Physician from the DB
router.delete("/delete/id/:id", deletePhysicianByID);

router.delete("/delete/Username/:Username", deletePhysicianByUsername);

router.delete("/delete/email/:email", deletePhysicianByEmail);

///---------------------- EXPORTS ----------------------///
module.exports = router;