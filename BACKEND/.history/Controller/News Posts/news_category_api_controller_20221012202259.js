///------------------------------------------ IMPORT ------------------------------------------///

///---------------------- FILES ----------------------///
const {NewsCategorySchema,
  NewsCategorysModel} = require("../../Models/News Posts/news_category_model");

///---------------------- LIBRARIES ----------------------///
const config = require("../config");

const jwt = require("jsonwebtoken");

///---------------------- CONTROLLERS ----------------------///
// Get a list of newsArticles from the DB
const getNewsCategories = ((req,res, next) => {
  // Get all data
  NewsCategorysModel.find({}).then(function(newsArticles){
       res.send(newsArticles);
  });
});

const getNewsCategoryByTitle = ( (req, res) => {
  NewsCategorysModel.findOne({ title: req.params.title }, (err, result) => {
    if (err) return res.status(500).json({ msg: err });
    return res.json({
      data: result,
      title: req.params.title,
    });
  });
});


// Update a newsArticle information in the DB
const updateNewsCategoryInformationByID= ((req,res, next) => {
    //to access :id ---> req.params.id
    NewsCategorysModel.findByIdAndUpdate({ _id: req.params.id }, {$set:req.body}).then(function () {
      NewsCategorysModel.findOne({ _id: req.params.id }).then(function (newsArticle) {
            res.send(newsArticle);
        });
    });
  });

  // Update a newsArticle info in the DB
const updateNewsCategoryInformationByNewsCategoryName= ((req,res, next) => {
    //to access :id ---> req.params.id
    NewsCategorysModel.findOneAndUpdate({ title: req.params.title }, {$set:req.body}).then(function () {
      NewsCategorysModel.findOne({ title: req.params.title }).then(function (newsArticle) {
            res.send(newsArticle);
        });
    });
  });

// Delete a newsArticle from the DB
const deleteNewsCategoryByID = ((req, res, next) => {
    //to access :id ---> req.params.id
    NewsCategorysModel.findByIdAndDelete({ _id: req.params.id }).then(function (newsArticle) {
        res.send(newsArticle);
    });
})

const deleteNewsCategoryByNewsCategoryName = ((req,res, next) => {
  //to access :title ---> req.params.title
  NewsCategorysModel.findByIdAndDelete({ title: req.params.title }).then(function (newsArticle) {
    res.send(newsArticle);
});
});

///---------------------- EXPORTS ----------------------///
module.exports = {
  getNewsCategories: getNewsCategories,
  getNewsCategoryByTitle: getNewsCategoryByTitle,
  updateNewsCategoryInformationByID: updateNewsCategoryInformationByID,
  updateNewsCategoryInformationByNewsCategoryName: updateNewsCategoryInformationByNewsCategoryName,
  deleteNewsCategoryByID: deleteNewsCategoryByID,
  deleteNewsCategoryByNewsCategoryName: deleteNewsCategoryByNewsCategoryName,
};