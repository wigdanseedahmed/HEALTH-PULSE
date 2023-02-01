///------------------------------------------ IMPORT ------------------------------------------///
  
  ///---------------------- LIBRARIES ----------------------///
  const mongoose = require('mongoose');
  const Schema = mongoose.Schema;
  
  ///------------------------------------------ SCHEMA ------------------------------------------///
  var SocialMediaPostsSchema = new Schema({
    status: {
      type: String,
    },
    sn: {
      type: Number,
    },
     dateCreated: {
        type: String,
      },
  socialMedia: {
    type: String,
  },
  postText: {
    type: String,
  },
  postImageUrl: {
    type: String,
  },
  userUid: {
    type: String,
  },
  timeStamp: {
    type: String,
  },
  username: {
    type: String,
  },
  userFirstName: {
    type: String,
  },
  userLastName: {
    type: String,
  },
  userProfilePicture: {
    type: String,
  },
  });
  
  
  ///------------------------------------------ MODEL ------------------------------------------///
  // This two schemas will save on the 'users' collection.
  var SocialMediaPostsModel = mongoose.model('social_media_posts_data', SocialMediaPostsSchema, 'social_media_posts_data');
  
  
  ///------------------------------------------ EXPORT ------------------------------------------///
  module.exports = {
    SocialMediaPostsSchema: SocialMediaPostsSchema,
    SocialMediaPostsModel: SocialMediaPostsModel
  };