class AppUrl {
  static const String liveBaseURL = "https://remote-ur/api/v1";
  static const String localBaseURL = "http://192.168.1.37:3300";

  // "http://172.20.10.3:3300/api"; for iphone 14
  // "http://172.20.172.221:3300/api"; GUEST
  // "http://192.168.1.138:3300/api"; LAB TEMP

  static const String baseURL = localBaseURL;
  static const String healthFacilityBaseURL = "$baseURL/health_facility";
  static const String userBaseURL = "$baseURL/user"; //liveBaseURL;
  static const String physiciansBaseURL = "$baseURL/physician";
  static const String newsPostsBaseURL = "$baseURL/new_posts";

  ///------------------------------------------------------------- HEALTH FACILITY -------------------------------------------------------------///

  ///------ Get a list of Health Facilities from the DB ------///
  static const String getHealthFacilities = "$healthFacilityBaseURL/";

  // router.get('/', getHealthFacilities);

  static const String getHealthFacility = "$healthFacilityBaseURL/";

  // router.route("/:healthFacilityName").get(middleware.checkToken, getHealthFacility);

  ///------ Update Health Facility information in the DB ------///
  static const String updateHealthFacilityInformationByID =
      "$healthFacilityBaseURL/update/id/";

  // router.put("/update/id/:id", updateHealthFacilityInformationByID);

  static const String updateHealthFacilityInformationByHealthFacilityName =
      "$healthFacilityBaseURL/update/healthFacilityName/";

  // router.put("/update/healthFacilityName/:healthFacilityName", updateHealthFacilityInformationByHealthFacilityName);

  ///------ Delete a Health Facility from the DB ------///
  static const String deleteHealthFacilityByID =
      "$healthFacilityBaseURL/delete/id/";

  // router.delete("/delete/id/:id", deleteHealthFacilityByID);

  static const String deleteHealthFacilityByHealthFacilityName =
      "$healthFacilityBaseURL/delete/healthFacilityName/";

  // router.delete("/delete/healthFacilityName/:healthFacilityName", deleteHealthFacilityByHealthFacilityName);

  ///------------------------------------------------------------- NEWS POSTS -------------------------------------------------------------///

  ///------------------------------------ NEWS ARTICLES
  static const String newsArticlesBaseURL = "$newsPostsBaseURL/news_article";

  ///------ Get a list of Locations from the DB ------///
  static const String getNewsArticles = "$newsArticlesBaseURL/";

  // router.get('/', getNewsArticles);

  static const String getNewsArticleByTitle = "$newsArticlesBaseURL/title/";

  // router.route("/title/:title").get(middleware.checkToken, getNewsArticleByTitle);

  static const String getNewsArticleByAuthor = "$newsArticlesBaseURL/author/";

  // router.route("/author/:author").get(middleware.checkToken, getNewsArticleByAuthor);

  static const String getNewsArticleByPublisher =
      "$newsArticlesBaseURL/publisher/";

  // router.route("/publisher/:publisher").get(middleware.checkToken, getNewsArticleByPublisher);

  ///------ Update Location information in the DB ------///
  static const String updateNewsArticleInformationByID =
      "$newsArticlesBaseURL/update/id/";

  // router.put("/update/id/:id", updateNewsArticleInformationByID);

  static const String updateNewsArticleInformationByNewsArticleName =
      "$newsArticlesBaseURL/update/title/";

  // router.put("/update/title/:title", updateNewsArticleInformationByNewsArticleName);

  ///------ Delete a Location from the DB ------///
  static const String deleteNewsArticleByID = "$newsArticlesBaseURL/delete/id/";

  // router.delete("/delete/id/:id", deleteNewsArticleByID);

  static const String deleteNewsArticleByNewsArticleName =
      "$newsArticlesBaseURL/delete/title/";

  // router.delete("/delete/title/:title", deleteNewsArticleByNewsArticleName);

  ///------------------------------------ NEWS CATEGORY
  static const String newsCategoriesBaseURL = "$newsPostsBaseURL/news_category";

  ///------ Get a list of Locations from the DB ------///
  static const String getNewsCategories = "$newsCategoriesBaseURL/";

  // router.get('/', getNewsCategories);

  static const String getNewsCategoryByTitle = "$newsCategoriesBaseURL/title/";

  // router.route("/title/:title").get(middleware.checkToken, getNewsCategoryByTitle);

  ///------ Update Location information in the DB ------///
  static const String updateNewsCategoryInformationByID =
      "$newsCategoriesBaseURL/update/id/";

  // router.put("/update/id/:id", updateNewsCategoryInformationByID);

  static const String updateNewsCategoryInformationByNewsCategoryName =
      "$newsCategoriesBaseURL/update/title/";

  // router.put("/update/title/:title", updateNewsCategoryInformationByNewsCategoryName);

  ///------ Delete a Location from the DB ------///
  static const String deleteNewsCategoryByID =
      "$newsCategoriesBaseURL/delete/id/";

  // router.delete("/delete/id/:id", deleteNewsCategoryByID);

  static const String deleteNewsCategoryByNewsCategoryName =
      "$newsCategoriesBaseURL/delete/title/";

  // router.delete("/delete/title/:title", deleteNewsCategoryByNewsCategoryName);

  ///------------------------------------ NEWS SOURCE
  static const String newsSourcesBaseURL = "$newsPostsBaseURL/news_source";

  ///------ Get a list of Locations from the DB ------///
  static const String getNewsSources = "$newsSourcesBaseURL/";

  // router.get('/', getNewsSources);

  static const String getNewsSourceByTitle = "$newsSourcesBaseURL/title/";

  // router.route("/title/:title").get(middleware.checkToken, getNewsSourceByTitle);

  ///------ Update Location information in the DB ------///
  static const String updateNewsSourceInformationByID =
      "$newsSourcesBaseURL/update/id/";

  // router.put("/update/id/:id", updateNewsSourceInformationByID);

  static const String updateNewsSourceInformationByNewsSourceName =
      "$newsSourcesBaseURL/update/title/";

  // router.put("/update/title/:title", updateNewsSourceInformationByNewsSourceName);

  ///------ Delete a Location from the DB ------///
  static const String deleteNewsSourceByID = "$newsSourcesBaseURL/delete/id/";

  // router.delete("/delete/id/:id", deleteNewsSourceByID);

  static const String deleteNewsSourceByNewsSourceName =
      "$newsSourcesBaseURL/delete/title/";

  // router.delete("/delete/title/:title", deleteNewsSourceByNewsSourceName);

  ///------------------------------------ RESPONSE TOP HEADLINE NEWS
  static const String responseTopHeadlineNewsBaseURL =
      "$newsPostsBaseURL/response_top_headline_news";

  ///------ Get a list of Locations from the DB ------///
  static const String getResponseTopHeadlineNews =
      "$responseTopHeadlineNewsBaseURL/";

  // router.get('/', getResponseTopHeadlineNews);

  ///------------------------------------ RESPONSE TOP HEADLINE NEWS
  static const String socialMediaPostsBaseURL =
      "$newsPostsBaseURL/social_media_posts";

  // HealthPulseApp.use("/new_posts/social_media_posts", require("./Routes/News Posts/social_media_posts"))

  ///------ Get a list of Locations from the DB ------///
  static const String getSocialMediaPosts = "$socialMediaPostsBaseURL/";

  // router.get('/', getSocialMediaPosts);

  ///------------------------------------------------------------- PHYSICIAN -------------------------------------------------------------///

  ///------ Get a list of Physician from the DB ------///
  static const String getPhysicians = "$physiciansBaseURL/";

  // router.get('/', getPhysicians);

  static const String getPhysician = "$physiciansBaseURL/";

  // router.route("/:Username").get(middleware.checkToken, getPhysician);

  ///------ Check to see if Physician exists ------///
  // router.route("/checkUsername/:Username").get(checkPhysicianUsernameExists);

  // router.route("/checkemail/:email").get(checkPhysicianEmailExists);

  ///------ Login Physician ------///
// router.route("/login").post(logIn);

  ///------ Register Physician ------///
// router.route("/register").post(register);

  ///------ Update Physician information in the DB ------///
  // router.put("/update/id/:id", updatePhysicianInformationByID);

  // router.put("/update/Username/:Username", updatePhysicianInformationByUsername);

  // router.put("/update/email/:email", updatePhysicianInformationByEmail);

  ///------ Update Physician password in the DB ------///
  // router.put("/update/password/Username/:Username", updatePhysicianPasswordByUsername);

  // router.put("/update/password/email/:email", updatePhysicianPasswordByEmail);

  ///------ Delete a Physician from the DB ------///
  // router.delete("/delete/id/:id", deletePhysicianByID);

  // router.delete("/delete/Username/:Username", deletePhysicianByUsername);

  // router.delete("/delete/email/:email", deletePhysicianByEmail);

  ///------------------------------------------------------------- USER -------------------------------------------------------------///

  ///------ Adding and Uploading Image ------///
  static const String addAndUpdateProfileImage = "$userBaseURL/add/image/";

  // router.post("/add/image/:email", upload.single("myFile"), addAndUpdateProfileImage);

  ///------ Get a list of Locations from the DB ------///
  static const String getUsers = "$userBaseURL/";

  // router.get('/', getUsers);

  static const String getUserUsingUsername =
      "$userBaseURL/getUserUsingUsername/";

  // router.get("/getUserUsingUsername/:username", getUserUsingUsername);

  static const String getUserUsingEmail = "$userBaseURL/getUserUsingEmail/";

  // router.get("/getUserUsingEmail/:email", getUserUsingEmail);

  ///------ Check to see if user exists ------///
  static const String checkUsernameExists = "$userBaseURL/checkUsername/";

  // router.route("/checkusername/:username").get(checkUsernameExists);

  static const String checkEmailExists = "$userBaseURL/checkEmail/";

  // router.route("/checkemail/:email").get(checkEmailExists);

  ///------ Login User ------///
  static const String login = "$userBaseURL/login";

  // router.route("/login").post(logIn);

  ///------ Register User ------///
  static const String register = "$userBaseURL/register";

  // router.route("/register").post(register);

  ///------ Update user information in the DB ------///
  static const String updateUserInformationByID = "$userBaseURL/update/id/";

  // router.put("/update/id/:id", updateUserInformationByID);

  static const String updateUserInformationByUsername =
      "$userBaseURL/update/username/";

  // router.put("/update/username/:username", updateUserInformationByUsername);

  static const String updateUserInformationByEmail =
      "$userBaseURL/update/email/";

  // router.put("/update/email/:email", updateUserInformationByEmail);

  ///------ Update user password in the DB ------///
  static const String forgotPasswordUpdateWithUsername =
      "$userBaseURL/users/forgetPassword/username/";

  // router.put("/update/forgetPassword/username/:username", forgotPasswordUpdateWithUsername);

  static const String forgotPasswordUpdateWithEmail =
      "$userBaseURL/update/forgetPassword/email/";

  // router.put("/update/forgetPassword/email/:email", forgotPasswordUpdateWithEmail);

  ///------ Delete a user from the DB ------///
  static const String deleteUserByID = "$userBaseURL/delete/id/";

  // router.delete("/delete/id/:id", deleteUserByID);

  static const String deleteUserByUsername = "$userBaseURL/delete/username/";

  // router.delete("/delete/username/:username", deleteUserByUsername);

  static const String deleteUserByEmail = "$userBaseURL/delete/email/";
// router.delete("/delete/email/:email", deleteUserByEmail);

}
