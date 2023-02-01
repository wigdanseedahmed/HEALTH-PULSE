///------------------------------------------ IMPORT ------------------------------------------///


///---------------------- FILES ----------------------///
const { getUsers,
  getUserUsingUsername,
  getUserUsingEmail,
  checkUsernameExists,
  checkEmailExists,
  logIn,
  register,
  updateUserInformationByID,
  updateUserInformationByUsername,
  updateUserInformationByEmail,
  updateUserPasswordByUsername,
  updateUserPasswordByEmail,
  deleteUserByID,
  deleteUserByUsername,
  deleteUserByEmail } = require("../Controller/user_api_controller");

///---------------------- LIBRARIES ----------------------///
const config = require("../config");
let middleware = require("../middleware");

const jwt = require("jsonwebtoken");

const express = require("express");
const router = express.Router();

///---------------------- ROUTES ----------------------///
// Get a list of users from the DB
router.get('/', getUsers);

router.get("/getUserUsingUsername/:username", getUserUsingUsername);

router.get("/getUserUsingEmail/:email", getUserUsingEmail);

// Check to see if user exists
router.route("/checkusername/:username").get(checkUsernameExists);

router.route("/checkemail/:email").get(checkEmailExists);

// Login User
router.route("/login").post(logIn);

// Register User
router.route("/register").post(register);

// Update user information in the DB
router.put("/update/id/:id", updateUserInformationByID);

router.put("/update/username/:username", updateUserInformationByUsername);

router.put("/update/email/:email", updateUserInformationByEmail);

// Update user password in the DB
router.put("/update/password/username/:username", updateUserPasswordByUsername);

router.put("/update/password/email/:email", updateUserPasswordByEmail);

// Delete a user from the DB
router.delete("/delete/id/:id", deleteUserByID);

router.delete("/delete/username/:username", deleteUserByUsername);

router.delete("/delete/email/:email", deleteUserByEmail);

///---------------------- EXPORTS ----------------------///
module.exports = router;