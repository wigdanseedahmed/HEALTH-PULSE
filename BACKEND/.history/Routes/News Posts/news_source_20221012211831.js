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
///------ Get a list of Locations from the DB ------///
router.get('/', getNewsSources);

router.route("/title/:title").get(middleware.checkToken, getNewsSourceByTitle);

///------ Update Location information in the DB ------///
router.put("/update/id/:id", updateNewsSourceInformationByID);

router.put("/update/title/:title", updateNewsSourceInformationByNewsSourceName);


///------ Delete a Location from the DB ------///
router.delete("/delete/id/:id", deleteNewsSourceByID);

router.delete("/delete/title/:title", deleteNewsSourceByNewsSourceName);

///------------------------------------------ EXPORT ------------------------------------------///
module.exports = router;