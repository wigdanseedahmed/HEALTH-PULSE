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
} = require("../../Controller/News Posts/response_top_headline_news_api_controller");


///---------------------- LIBRARIES ----------------------///

let middleware = require("../../middleware");

const jwt = require("jsonwebtoken");

const express = require("express");
const router = express.Router();

///------------------------------------------ ROUTES ------------------------------------------///
// Get a list of Locations from the DB
router.get('/news_articles', getNewsArticles);

router.route("/news_articles/:title").get(middleware.checkToken, getNewsArticleByTitle);

router.route("/news_articles/:author").get(middleware.checkToken, getNewsArticleByAuthor);

router.route("/news_articles/:publisher").get(middleware.checkToken, getNewsArticleByPublisher);

// Update Location information in the DB
router.put("/news_articles/id/:id", updateNewsArticleInformationByID);

router.put("/news_articles/title/:title", updateNewsArticleInformationByNewsArticleName);


// Delete a Location from the DB
router.delete("/news_articles/id/:id", deleteNewsArticleByID);

router.delete("/news_articles/title/:title", deleteNewsArticleByNewsArticleName);

///------------------------------------------ EXPORT ------------------------------------------///
module.exports = router;