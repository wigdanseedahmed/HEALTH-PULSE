const express = require('express');
const bodyParser = require("body-parser");
const mongoose = require('mongoose');

const port = process.env.port || 3300;


// Set up Express app
const HealthPulseApp = express();

// Connect to mongodb
mongoose.connect(
    'mongodb://localhost/health_pulse',
    {
        useNewUrlParser: true,
        useUnifiedTopology: true
    }
);
mongoose.Promise = global.Promise;

const connection = mongoose.connection;
connection.once("open", () => {
    console.log("MongoDb connected");
});

// Middleware to allow users to input output image
HealthPulseApp.use(express.static('public'))

// Body Parse Middleware 
HealthPulseApp.use(bodyParser.json());

// Initialize routes
data = {
    msg: "Welcome on DevStack Blog App development YouTube video series",
    info: "This is a root endpoint",
    Working: "Documentations of other endpoints will be release soon :)",
    request:
        "Hey if you did'nt subscribed my YouTube channle please subscribe it",
};

HealthPulseApp.route("/").get((req, res) => res.json(data));

// CORS
const cors = require('cors');
HealthPulseApp.use(cors({
    origin: '*',
    credentials: true,
    
}));

// Middleware
HealthPulseApp.use("/uploads", express.static("uploads"));
HealthPulseApp.use(express.json());

HealthPulseApp.use(bodyParser.json({
    limit: "50mb" //increased the limit to receive base64
}))
HealthPulseApp.use(bodyParser.urlencoded({
    limit: "50mb",
    extended: true,
    parameterLimit: 500000
}))


// Initialize routes

    // HEALTH FACILITY
HealthPulseApp.use("/health_facility", require("./Routes/Health Facility/health_facility"))

    // NEWS POSTS
    HealthPulseApp.use("/new_posts/news_article", require("./Routes/News Posts/news_article"))
    HealthPulseApp.use("/new_posts/news_category", require("./Routes/News Posts/news_category"))
    HealthPulseApp.use("/new_posts/news_source", require("./Routes/News Posts/news_source"))
    HealthPulseApp.use("/new_posts/response_top_headline_news", require("./Routes/News Posts/response_top_headline_news"))
    HealthPulseApp.use("/new_posts/social_media_posts", require("./Routes/News Posts/social_media_posts"))


    // USERS
HealthPulseApp.use("/user", require("./Routes/user"))
//sudanHorizonScannerApp.use("/api", require("./routes/profile"))

    // PHYSICIANS
HealthPulseApp.use("/physician", require("./Routes/physician"))

// Error handling Middleware
HealthPulseApp.use(function (err, req, res, next) {
    //console.log(err);
    res.status(422).send({ error: err.message });
});

// Listen for requests
HealthPulseApp.listen(port, function () {
    console.log('now listening for requests');
});