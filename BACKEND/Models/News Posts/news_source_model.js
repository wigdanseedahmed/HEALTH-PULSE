///------------------------------------------ IMPORT ------------------------------------------///

///---------------------- LIBRARIES ----------------------///
const mongoose = require('mongoose');
const Schema = mongoose.Schema;

///------------------------------------------ SCHEMA ------------------------------------------///
var NewsSourceSchema = new Schema({
  name: {
    type: String,
  },
});


///------------------------------------------ MODEL ------------------------------------------///
// This two schemas will save on the 'users' collection.
var NewsSourcesModel = mongoose.model('news_source_data', NewsSourceSchema, 'news_source_data');


///------------------------------------------ EXPORT ------------------------------------------///
module.exports = {
  NewsSourceSchema: NewsSourceSchema,
  NewsSourcesModel: NewsSourcesModel
};