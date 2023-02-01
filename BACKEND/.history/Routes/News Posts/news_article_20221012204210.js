///------------------------------------------ IMPORT ------------------------------------------///


///---------------------- FILES ----------------------///
const {
  getNewsArticles,
  getNewsArticleByTitle,
  getNewsArticleByAuthor,
  getNewsArticleByPublisher,
  updateNewsArticleInformationByID,
  updateNewsArticleInformationByNewsArticleName,
  deleteNewsArticleByID,
  deleteNewsArticleByNewsArticleName,
} = require("../../Controller/News Posts/news_article_api_controller");


///---------------------- LIBRARIES ----------------------///

let middleware = require("../../middleware");

const jwt = require("jsonwebtoken");

const express = require("express");
const router = express.Router();

///------------------------------------------ ROUTES ------------------------------------------///
// Get a list of Locations from the DB
router.get('/', getNewsArticles);

router.route("/:title").get(middleware.checkToken, getNewsArticleByTitle);

router.route("/:author").get(middleware.checkToken, getNewsArticleByAuthor);

router.route("/:publisher").get(middleware.checkToken, getNewsArticleByPublisher);

// Update Location information in the DB
router.put("/id/:id", updateNewsArticleInformationByID);

router.put("/title/:title", updateNewsArticleInformationByNewsArticleName);


// Delete a Location from the DB
router.delete("/id/:id", deleteNewsArticleByID);

router.delete("/title/:title", deleteNewsArticleByNewsArticleName);

///------------------------------------------ EXPORT ------------------------------------------///
module.exports = router;