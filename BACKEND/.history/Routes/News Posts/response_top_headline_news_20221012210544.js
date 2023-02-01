///------------------------------------------ IMPORT ------------------------------------------///


///---------------------- FILES ----------------------///
const {
  getResponseTopHeadlineNews
} = require("../../Controller/News Posts/response_top_headline_news_api_controller");


///---------------------- LIBRARIES ----------------------///

let middleware = require("../../middleware");

const jwt = require("jsonwebtoken");

const express = require("express");
const router = express.Router();

///------------------------------------------ ROUTES ------------------------------------------///
///------ Get a list of Locations from the DB
router.get('/', getResponseTopHeadlineNews);

///------------------------------------------ EXPORT ------------------------------------------///
module.exports = router;