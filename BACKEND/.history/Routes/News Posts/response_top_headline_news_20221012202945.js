///------------------------------------------ IMPORT ------------------------------------------///

///---------------------- FILES ----------------------///
const {ResponseTopHeadlineNewsSchema,
  ResponseTopHeadlineNewsModel} = require("../../Models/News Posts/response_top_headline_news_model");

///---------------------- LIBRARIES ----------------------///
const config = require("../config");

const jwt = require("jsonwebtoken");

///---------------------- CONTROLLERS ----------------------///
// Get a list of newsSources from the DB
const getResponseTopHeadlineNews = ((req,res, next) => {
  // Get all data
  ResponseTopHeadlineNewsModel.find({}).then(function(newsSources){
       res.send(newsSources);
  });
});

///---------------------- EXPORTS ----------------------///
module.exports = {
  getResponseTopHeadlineNews: getResponseTopHeadlineNews,
};