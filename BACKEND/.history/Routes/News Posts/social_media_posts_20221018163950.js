///------------------------------------------ IMPORT ------------------------------------------///


///---------------------- FILES ----------------------///
const {
  getSocialMediaPosts
} = require("../../Controller/News Posts/social_media_posts_api_controller");


///---------------------- LIBRARIES ----------------------///

let middleware = require("../../middleware");

const jwt = require("jsonwebtoken");

const express = require("express");
const router = express.Router();

///------------------------------------------ ROUTES ------------------------------------------///
///------ Get a list of Locations from the DB ------///
router.get('/social_media_posts/', getSocialMediaPosts);

///------------------------------------------ EXPORT ------------------------------------------///
module.exports = router;