///------------------------------------------ IMPORT ------------------------------------------///

///---------------------- FILES ----------------------///
const {SocialMediaPostsSchema,
  SocialMediaPostsModel} = require("../../Models/News Posts/social_media_posts_model");

///---------------------- LIBRARIES ----------------------///
const config = require("../../config");

const jwt = require("jsonwebtoken");

///---------------------- CONTROLLERS ----------------------///
// Get a list of newsSources from the DB
const getSocialMediaPosts = ((req,res, next) => {
  // Get all data
  SocialMediaPostsModel.find({}).then(function(newsSources){
       res.send(newsSources);
  });
});

///---------------------- EXPORTS ----------------------///
module.exports = {
  getSocialMediaPosts: getSocialMediaPosts,
};