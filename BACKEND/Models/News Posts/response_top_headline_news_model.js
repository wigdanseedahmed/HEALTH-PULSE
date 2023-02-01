///------------------------------------------ IMPORT ------------------------------------------///

///---------------------- FILES ----------------------///
const { NewsArticlesSchema,
  NewsArticlesModel } = require("../../Models/News Posts/news_article_model");

///---------------------- LIBRARIES ----------------------///
const mongoose = require('mongoose');
const Schema = mongoose.Schema;

///------------------------------------------ SCHEMA ------------------------------------------///
var ResponseTopHeadlineNewsSchema = new Schema({
  status: {
    type: String,
  },
  totalResults: {
    type: Number,
  },
  articles: [NewsArticlesSchema],
});


///------------------------------------------ MODEL ------------------------------------------///
// This two schemas will save on the 'users' collection.
var ResponseTopHeadlineNewsModel = mongoose.model('response_top_headline_news_data', ResponseTopHeadlineNewsSchema, 'response_top_headline_news_data');


///------------------------------------------ EXPORT ------------------------------------------///
module.exports = {
  ResponseTopHeadlineNewsSchema: ResponseTopHeadlineNewsSchema,
  ResponseTopHeadlineNewsModel: ResponseTopHeadlineNewsModel
};