
///------------------------------------------ IMPORT ------------------------------------------///


///---------------------- FILES ----------------------///

///---------------------- LIBRARIES ----------------------///
const mongoose = require('mongoose');
const Schema = mongoose.Schema;

///------------------------------------------ SCHEMA ------------------------------------------///
var NewsArticlesSchema = new Schema({
  source: SourceModel,
  author: {
    type: String,
  },
  title: {
    type: String,
  },
  description: {
    type: String
  },
  url: {
    type: String
  },
  urlToImage: {
    type: String,
  },
  publishedAt: {
    type: String,
  },
  content: {
    type: String
  },
});


///------------------------------------------ MODEL ------------------------------------------///
// This two schemas will save on the 'users' collection.
var NewsArticlesModel = mongoose.model('news_articles_data', NewsArticlesSchema, 'news_articles_data');


///------------------------------------------ EXPORT ------------------------------------------///
module.exports = {
  NewsArticlesSchema: NewsArticlesSchema,
  NewsArticlesModel: NewsArticlesModel
};