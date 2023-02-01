///------------------------------------------ IMPORT ------------------------------------------///

///---------------------- FILES ----------------------///
const {NewsArticlesSchema,
  NewsArticlesModel} = require("../../Models/News Posts/news_article_model");

///---------------------- LIBRARIES ----------------------///
const config = require("../config");

const jwt = require("jsonwebtoken");

///---------------------- CONTROLLERS ----------------------///
// Get a list of users from the DB
const getNewsArticles = ((req,res, next) => {
  // Get all data
  NewsArticlesModel.find({}).then(function(newsArticles){
       res.send(newsArticles);
  });
});

const getNewsArticle = ( (req, res) => {
  NewsArticlesModel.findOne({ newsArticleName: req.params.newsArticleName }, (err, result) => {
    if (err) return res.status(500).json({ msg: err });
    return res.json({
      data: result,
      newsArticleName: req.params.newsArticleName,
    });
  });
});


// Update a user information in the DB
const updateNewsArticleInformationByID= ((req,res, next) => {
    //to access :id ---> req.params.id
    NewsArticlesModel.findByIdAndUpdate({ _id: req.params.id }, {$set:req.body}).then(function () {
      NewsArticlesModel.findOne({ _id: req.params.id }).then(function (newsArticle) {
            res.send(newsArticle);
        });
    });
  });

  // Update a newsArticle info in the DB
const updateNewsArticleInformationByNewsArticleName= ((req,res, next) => {
    //to access :id ---> req.params.id
    NewsArticlesModel.findOneAndUpdate({ newsArticleName: req.params.newsArticleName }, {$set:req.body}).then(function () {
      NewsArticlesModel.findOne({ newsArticleName: req.params.newsArticleName }).then(function (newsArticle) {
            res.send(newsArticle);
        });
    });
  });

// Delete a user from the DB
const deleteNewsArticleByID = ((req, res, next) => {
    //to access :id ---> req.params.id
    NewsArticlesModel.findByIdAndDelete({ _id: req.params.id }).then(function (user) {
        res.send(user);
    });
})

const deleteNewsArticleByNewsArticleName = ((req,res, next) => {
  //to access :newsArticleName ---> req.params.newsArticleName
  NewsArticlesModel.findByIdAndDelete({ newsArticleName: req.params.newsArticleName }).then(function (user) {
    res.send(user);
});
});

///---------------------- EXPORTS ----------------------///
module.exports = {
  getNewsArticles: getNewsArticles,
  getNewsArticle: getNewsArticle,
  updateNewsArticleInformationByID: updateNewsArticleInformationByID,
  updateNewsArticleInformationByNewsArticleName: updateNewsArticleInformationByNewsArticleName,
  deleteNewsArticleByID: deleteNewsArticleByID,
  deleteNewsArticleByNewsArticleName: deleteNewsArticleByNewsArticleName,
};