///------------------------------------------ IMPORT ------------------------------------------///

///---------------------- FILES ----------------------///
const {NewsSourceSchema,
  NewsSourcesModel} = require("../../Models/News Posts/news_source_model");

///---------------------- LIBRARIES ----------------------///
const config = require("../config");

const jwt = require("jsonwebtoken");

///---------------------- CONTROLLERS ----------------------///
// Get a list of newsSources from the DB
const getNewsSources = ((req,res, next) => {
  // Get all data
  NewsSourcesModel.find({}).then(function(newsSources){
       res.send(newsSources);
  });
});

const getNewsSourceByTitle = ( (req, res) => {
  NewsSourcesModel.findOne({ name: req.params.name }, (err, result) => {
    if (err) return res.status(500).json({ msg: err });
    return res.json({
      data: result,
      name: req.params.name,
    });
  });
});


// Update a newsSource information in the DB
const updateNewsSourceInformationByID= ((req,res, next) => {
    //to access :id ---> req.params.id
    NewsSourcesModel.findByIdAndUpdate({ _id: req.params.id }, {$set:req.body}).then(function () {
      NewsSourcesModel.findOne({ _id: req.params.id }).then(function (newsSource) {
            res.send(newsSource);
        });
    });
  });

  // Update a newsSource info in the DB
const updateNewsSourceInformationByNewsSourceName= ((req,res, next) => {
    //to access :id ---> req.params.id
    NewsSourcesModel.findOneAndUpdate({ name: req.params.name }, {$set:req.body}).then(function () {
      NewsSourcesModel.findOne({ name: req.params.name }).then(function (newsSource) {
            res.send(newsSource);
        });
    });
  });

// Delete a newsSource from the DB
const deleteNewsSourceByID = ((req, res, next) => {
    //to access :id ---> req.params.id
    NewsSourcesModel.findByIdAndDelete({ _id: req.params.id }).then(function (newsSource) {
        res.send(newsSource);
    });
})

const deleteNewsSourceByNewsSourceName = ((req,res, next) => {
  //to access :name ---> req.params.name
  NewsSourcesModel.findByIdAndDelete({ name: req.params.name }).then(function (newsSource) {
    res.send(newsSource);
});
});

///---------------------- EXPORTS ----------------------///
module.exports = {
  getNewsSources: getNewsSources,
  getNewsSourceByTitle: getNewsSourceByTitle,
  updateNewsSourceInformationByID: updateNewsSourceInformationByID,
  updateNewsSourceInformationByNewsSourceName: updateNewsSourceInformationByNewsSourceName,
  deleteNewsSourceByID: deleteNewsSourceByID,
  deleteNewsSourceByNewsSourceName: deleteNewsSourceByNewsSourceName,
};