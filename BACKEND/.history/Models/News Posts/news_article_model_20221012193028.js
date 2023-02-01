const mongoose = require('mongoose');
  const Schema = mongoose.Schema;
  
  
  var ArticlesSchema = new Schema({
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
  
  
  // This two schemas will save on the 'users' collection.
  var ArticlesModel = mongoose.model('news_articles_data', ArticlesSchema, 'news_articles_data');
  
  module.exports = {
    ArticlesSchema: ArticlesSchema,
      ArticlesModel: ArticlesModel
  };