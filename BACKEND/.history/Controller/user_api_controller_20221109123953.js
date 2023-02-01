///------------------------------------------ IMPORT ------------------------------------------///

///---------------------- FILES ----------------------///
const {User,
  registerUser} = require("../Models/user_model");

///---------------------- LIBRARIES ----------------------///
const config = require("../config");

const jwt = require("jsonwebtoken");

const express = require("express");
const router = express.Router();

const multer = require("multer");
const path = require("path");

///---------------------- CONTROLLERS ----------------------///
// Adding and update profile image
const imageStorage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, "../Profile Picture Uploads");
  },
  filename: (req, file, cb) => {
    cb(null, req.decoded.username + ".jpg");
  },
});

const fileFilter = (req, file, cb) => {
  if (file.mimetype == "image/jpeg" || file.mimetype == "image/png") {
    cb(null, true);
  } else {
    cb(null, false);
  }
};

const uploadImage = multer({
  storage: imageStorage,
  limits: {
    fileSize: 1024 * 1024 * 6,
  },
  // fileFilter: fileFilter,
});


// Adding and update profile image
const addAndUpdateProfileImage = (async (req, res, next) => {
  /*const file = req.file
  if (!file) {
    const error = new Error('Please upload a file')
    error.httpStatusCode = 400
    return next("hey error")
  }*/

  var userPhotoName = req.body.userPhotoName;
  var userPhotoFile = req.body.userPhotoFile;

  var realFile = Buffer.from(userPhotoFile, "base64");
  fs.writeFile(userPhotoName, realFile, function (err) {
    if (err)
      console.log(err);
  });
  res.send("OK");


  User.findOneAndUpdate({
      email: req.params.email
    }, {
      $set: {
        userPhotoName: req.body.userPhotoName,
        userPhotoFile: req.body.userPhotoFile,
      },
    }, {
      new: true
    },
    (err, profile) => {
      if (err) return res.status(500).send(err);
      const response = {
        message: "image added successfully updated",
        data: profile,
      };
      return res.status(200).send(response);
    }
  );


});

// Get a list of users from the DB
const getUsers = ((req,res, next) => {
  // Get all data
  User.find({}).then(function(users){
       res.send(users);
  });
});

const getUserUsingUsername = ( (req, res) => {
  User.findOne({ username: req.params.username }, (err, result) => {
    if (err) return res.status(500).json({ msg: err });
    return res.json({
      data: result,
      username: req.params.username,
    });
  });
});

const getUserUsingEmail = ( (req, res) => {
  User.findOne({ email: req.params.email }, (err, result) => {
    if (err) return res.status(500).json({ msg: err });
    return res.json({
      data: result,
      email: req.params.email,
    });
  });
});

// Check to see if user exists
const checkUsernameExists = ((req, res) => {
  User.findOne({ username: req.params.username }, (err, result) => {
    if (err) return res.status(500).json({ msg: err });
    if (result !== null) {
      return res.json({
        Status: true,
      });
    } else
      return res.json({
        Status: false,
      });
  });
});

const checkEmailExists = ((req, res) => {
  User.findOne({ email: req.params.email }, (err, result) => {
    if (err) return res.status(500).json({ msg: err });
    if (result !== null) {
      return res.json({
        Status: true,
      });
    } else
      return res.json({
        Status: false,
      });
  });
});

// Login User
const logIn = ((req, res) => {
  User.findOne({
    $or: [{ "email": req.body.email },
    //{"phone": userEmailPhone},
    { "userName": req.body.username }]
  }, (err, result) => {
    if (err) {
      return res.status(500).json({ msg: err });
    }

    // validate username, email, or phone number
    if (result === null) {
      return res.status(404).json("Username or email incorrect");
    }

    //Validate password
    if (result.password === req.body.password) {
      // here we implement the JWT token functionality
      let token = jwt.sign({
        $or: [{ "email": req.body.email },
        //{"phone": userEmailPhone},
        { "userName": req.body.username }]
      }, config.key, {});

      res.json({
        token: token,
        msg: "success",
      });
    } else {
      res.status(403).json("password is incorrect");
    }
  });
});

// Register User
const register = ((req, res) => {
  console.log("inside the register");
  const user = new User({
    username: req.body.username,
    password: req.body.password,
    email: req.body.email,
  });
  user
    .save()
    .then(() => {
      console.log("user registered");
      res.status(200).json({ msg: "User Successfully Registered" });
    })
    .catch((err) => {
      res.status(403).json({ msg: err });
    });
});

// Update a user information in the DB
const updateUserInformationByID= ((req,res, next) => {
    //to access :id ---> req.params.id
    registerUser.findByIdAndUpdate({ _id: req.params.id }, {$set:req.body}).then(function () {
      registerUser.findOne({ _id: req.params.id }).then(function (user) {
            res.send(user);
        });
    });
  });

const updateUserInformationByUsername= ((req,res, next) => {
    //to access :id ---> req.params.id
    registerUser.findOneAndUpdate({ username: req.params.username }, {$set:req.body}).then(function () {
      registerUser.findOne({ username: req.params.username }).then(function (user) {
            res.send(user);
        });
    });
  });

  const updateUserInformationByEmail= ((req,res, next) => {
    //to access :id ---> req.params.id
    registerUser.findOneAndUpdate({ email: req.params.email }, {$set:req.body}).then(function () {
      registerUser.findOne({ email: req.params.email }).then(function (user) {
            res.send(user);
        });
    });
  });

// Update a user password in the DB
const updateUserPasswordByUsername = ((req,res, next) => {
  //to access :username ---> req.params.username
  console.log(req.params.username);
  registerUser.findOneAndUpdate(
    {
      $or: [{ "email": req.body.email },
      //{"phone": userEmailPhone},
      { "userName": req.body.username }]
    },
    { $set: { password: req.body.password } },
    (err, result) => {
      if (err) return res.status(500).json({ msg: err });
      const msg = {
        msg: "password successfully updated",
        username: req.params.username,
      };
      return res.json(msg);
    }
  );
});

const updateUserPasswordByEmail = ((req,res, next) => {
  //to access :id ---> req.params.id
  console.log(req.params.email);
  registerUser.findOneAndUpdate(
    {
      $or: [{ "email": req.body.email },
      //{"phone": userEmailPhone},
      { "userName": req.body.username }]
    },
    { $set: { password: req.body.password } },
    (err, result) => {
      if (err) return res.status(500).json({ msg: err });
      const msg = {
        msg: "password successfully updated",
        email: req.params.email,
      };
      return res.json(msg);
    }
  );
});

// Delete a user from the DB
const deleteUserByID = ((req, res, next) => {
    //to access :id ---> req.params.id
    registerUser.findByIdAndRemove({ _id: req.params.id }).then(function (user) {
        res.send(user);
    });
})

const deleteUserByUsername = ((req,res, next) => {
  //to access :username ---> req.params.username
  registerUser.findOneAndDelete({
    $or: [{ "email": req.body.email },
    //{"phone": userEmailPhone},
    { "userName": req.body.username }]
  }, 
    (err, result) => {
      if (err) return res.status(500).json({ msg: err });
      const msg = {
        msg: "user deleted",
        username: req.params.username,
      };
      return res.json(msg);
    });
});

const deleteUserByEmail = ((req,res, next) => {
  //to access :email ---> req.params.email
  registerUser.findOneAndDelete({
    $or: [{ "email": req.body.email },
    //{"phone": userEmailPhone},
    { "userName": req.body.username }]
  }, 
    (err, result) => {
      if (err) return res.status(500).json({ msg: err });
      const msg = {
        msg: "user deleted",
        email: req.params.email,
      };
      return res.json(msg);
    });
});

///---------------------- EXPORTS ----------------------///
module.exports = {
  addAndUpdateProfileImage: addAndUpdateProfileImage,
    getUsers: getUsers,
    getUserUsingUsername: getUserUsingUsername,
    getUserUsingEmail: getUserUsingEmail,
    checkUsernameExists: checkUsernameExists,
    checkEmailExists: checkEmailExists,
    logIn: logIn,
    register: register,
    updateUserInformationByID: updateUserInformationByID,
    updateUserInformationByUsername: updateUserInformationByUsername,
    updateUserInformationByEmail: updateUserInformationByEmail,
    updateUserPasswordByUsername: updateUserPasswordByUsername,
    updateUserPasswordByEmail: updateUserPasswordByEmail,
    deleteUserByID: deleteUserByID,
    deleteUserByUsername: deleteUserByUsername,
    deleteUserByEmail: deleteUserByEmail
};