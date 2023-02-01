///------------------------------------------ IMPORT ------------------------------------------///


///---------------------- FILES ----------------------///
const {
  getNewsCategories,
  getNewsCategoryByTitle,
  updateNewsCategoryInformationByID,
  updateNewsCategoryInformationByNewsCategoryName,
   deleteNewsCategoryByID,
   deleteNewsCategoryByNewsCategoryName,
} = require("../../Controller/News Posts/news_category_api_controller");


///---------------------- LIBRARIES ----------------------///

let middleware = require("../../middleware");

const jwt = require("jsonwebtoken");

const express = require("express");
const router = express.Router();

///------------------------------------------ ROUTES ------------------------------------------///
// Get a list of Locations from the DB
router.get('/news_categories', getNewsCategories);

router.route("/news_categories/:title").get(middleware.checkToken, getNewsCategoryByTitle);

// Update Location information in the DB
router.put("/news_categories/id/:id", updateNewsCategoryInformationByID);

router.put("/news_categories/title/:title", updateNewsCategoryInformationByNewsCategoryName);


// Delete a Location from the DB
router.delete("/news_categories/id/:id", deleteNewsCategoryByID);

router.delete("/news_categories/title/:title", deleteNewsCategoryByNewsCategoryName);

///------------------------------------------ EXPORT ------------------------------------------///
module.exports = router;