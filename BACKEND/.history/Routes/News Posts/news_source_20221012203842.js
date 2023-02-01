///------------------------------------------ IMPORT ------------------------------------------///


///---------------------- FILES ----------------------///
const {
  getNewsSources,
  getNewsSourceByTitle,
  updateNewsSourceInformationByID,
  updateNewsSourceInformationByNewsSourceName,
  deleteNewsSourceByID,
  deleteNewsSourceByNewsSourceName,
} = require("../../Controller/News Posts/news_source_api_controller");


///---------------------- LIBRARIES ----------------------///

let middleware = require("../../middleware");

const jwt = require("jsonwebtoken");

const express = require("express");
const router = express.Router();

///------------------------------------------ ROUTES ------------------------------------------///
// Get a list of Locations from the DB
router.get('/news_sources', getNewsSources);

router.route("/news_sources/:title").get(middleware.checkToken, getNewsSourceByTitle);

// Update Location information in the DB
router.put("/news_sources/id/:id", updateNewsSourceInformationByID);

router.put("/news_sources/title/:title", updateNewsSourceInformationByNewsSourceName);


// Delete a Location from the DB
router.delete("/news_sources/id/:id", deleteNewsSourceByID);

router.delete("/news_sources/title/:title", deleteNewsSourceByNewsSourceName);

///------------------------------------------ EXPORT ------------------------------------------///
module.exports = router;