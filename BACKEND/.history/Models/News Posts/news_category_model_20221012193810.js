///------------------------------------------ IMPORT ------------------------------------------///

///---------------------- LIBRARIES ----------------------///
const mongoose = require('mongoose');
const Schema = mongoose.Schema;

///------------------------------------------ SCHEMA ------------------------------------------///
var NewsCategorySchema = new Schema({
  image: {
    type: String,
  },
  title: {
    type: String,
  },
});


///------------------------------------------ MODEL ------------------------------------------///
// This two schemas will save on the 'users' collection.
var NewsCategorysModel = mongoose.model('news_category_data', NewsCategorySchema, 'news_category_data');


///------------------------------------------ EXPORT ------------------------------------------///
module.exports = {
  NewsCategorySchema: NewsCategorySchema,
  NewsCategorysModel: NewsCategorysModel
};