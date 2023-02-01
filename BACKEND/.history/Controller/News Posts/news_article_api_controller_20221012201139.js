///------------------------------------------ IMPORT ------------------------------------------///

///---------------------- FILES ----------------------///
const {NewsArticlesSchema,
  NewsArticlesModel} = require("../../Models/News Posts/news_article_model");

///---------------------- LIBRARIES ----------------------///
const config = require("../config");

const jwt = require("jsonwebtoken");

///---------------------- CONTROLLERS ----------------------///
// Get a list of newsArticles from the DB
const getNewsArticles = ((req,res, next) => {
  // Get all data
  NewsArticlesModel.find({}).then(function(newsArticles){
       res.send(newsArticles);
  });
});

const getNewsArticleByTitle = ( (req, res) => {
  NewsArticlesModel.findOne({ title: req.params.title }, (err, result) => {
    if (err) return res.status(500).json({ msg: err });
    return res.json({
      data: result,
      title: req.params.title,
    });
  });
});

const getNewsArticleByAuthor = ( (req, res) => {
  NewsArticlesModel.findOne({ author: req.params.author }, (err, result) => {
    if (err) return res.status(500).json({ msg: err });
    return res.json({
      data: result,
      author: req.params.author,
    });
  });
});


// Update a newsArticle information in the DB
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
    NewsArticlesModel.findOneAndUpdate({ title: req.params.title }, {$set:req.body}).then(function () {
      NewsArticlesModel.findOne({ title: req.params.title }).then(function (newsArticle) {
            res.send(newsArticle);
        });
    });
  });

// Delete a newsArticle from the DB
const deleteNewsArticleByID = ((req, res, next) => {
    //to access :id ---> req.params.id
    NewsArticlesModel.findByIdAndDelete({ _id: req.params.id }).then(function (newsArticle) {
        res.send(newsArticle);
    });
})

const deleteNewsArticleByNewsArticleName = ((req,res, next) => {
  //to access :title ---> req.params.title
  NewsArticlesModel.findByIdAndDelete({ title: req.params.title }).then(function (newsArticle) {
    res.send(newsArticle);
});
});

///---------------------- EXPORTS ----------------------///
module.exports = {
  getNewsArticles: getNewsArticles,
  getNewsArticleByTitle: getNewsArticleByTitle,
  getNewsArticleByAuthor: getNewsArticleByAuthor,
  updateNewsArticleInformationByID: updateNewsArticleInformationByID,
  updateNewsArticleInformationByNewsArticleName: updateNewsArticleInformationByNewsArticleName,
  deleteNewsArticleByID: deleteNewsArticleByID,
  deleteNewsArticleByNewsArticleName: deleteNewsArticleByNewsArticleName,
};