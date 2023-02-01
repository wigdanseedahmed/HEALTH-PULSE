const config = require("../config");

const jwt = require("jsonwebtoken");

const {physicianSchema,
  PhysicianModel} = require("../Models/physician_model");

// Get a list of users from the DB
const getPhysicians = ((req,res, next) => {
  // Get all data
  PhysicianModel.find({}).then(function(physicians){
       res.send(physicians);
  });
});

const getPhysician = ( (req, res) => {
  PhysicianModel.findOne({ username: req.params.username }, (err, result) => {
    if (err) return res.status(500).json({ msg: err });
    return res.json({
      data: result,
      username: req.params.username,
    });
  });
});

// Check to see if user exists
const checkPhysicianUsernameExists = ((req, res) => {
  PhysicianModel.findOne({ username: req.params.username }, (err, result) => {
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

const checkPhysicianEmailExists = ((req, res) => {
  PhysicianModel.findOne({ email: req.params.email }, (err, result) => {
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

// Update a user information in the DB
const updatePhysicianInformationByID= ((req,res, next) => {
    //to access :id ---> req.params.id
    PhysicianModel.findByIdAndUpdate({ _id: req.params.id }, {$set:req.body}).then(function () {
      PhysicianModel.findOne({ _id: req.params.id }).then(function (physician) {
            res.send(physician);
        });
    });
  });

const updatePhysicianInformationByUsername= ((req,res, next) => {
    //to access :id ---> req.params.id
    PhysicianModel.findOneAndUpdate({ username: req.params.username }, {$set:req.body}).then(function () {
      PhysicianModel.findOne({ username: req.params.username }).then(function (physician) {
            res.send(physician);
        });
    });
  });

  const updatePhysicianInformationByEmail= ((req,res, next) => {
    //to access :id ---> req.params.id
    PhysicianModel.findOneAndUpdate({ email: req.params.email }, {$set:req.body}).then(function () {
      PhysicianModel.findOne({ email: req.params.email }).then(function (physician) {
            res.send(physician);
        });
    });
  });

// Update a user password in the DB
const updatePhysicianPasswordByUsername = ((req,res, next) => {
  //to access :username ---> req.params.username
  console.log(req.params.username);
  PhysicianModel.findOneAndUpdate(
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

const updatePhysicianPasswordByEmail = ((req,res, next) => {
  //to access :id ---> req.params.id
  console.log(req.params.email);
  PhysicianModel.findOneAndUpdate(
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
const deletePhysicianByID = ((req, res, next) => {
    //to access :id ---> req.params.id
    PhysicianModel.findByIdAndRemove({ _id: req.params.id }).then(function (user) {
        res.send(user);
    });
})

const deletePhysicianByUsername = ((req,res, next) => {
  //to access :username ---> req.params.username
  PhysicianModel.findOneAndDelete({
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

const deletePhysicianByEmail = ((req,res, next) => {
  //to access :email ---> req.params.email
  PhysicianModel.findOneAndDelete({
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

module.exports = {
  getPhysicians: getPhysicians,
  getPhysician: getPhysician,
  checkPhysicianUsernameExists: checkPhysicianUsernameExists,
  checkPhysicianEmailExists: checkPhysicianEmailExists,
  updatePhysicianInformationByID: updatePhysicianInformationByID,
  updatePhysicianInformationByUsername: updatePhysicianInformationByUsername,
  updatePhysicianInformationByEmail: updatePhysicianInformationByEmail,
  updatePhysicianPasswordByUsername: updatePhysicianPasswordByUsername,
  updatePhysicianPasswordByEmail: updatePhysicianPasswordByEmail,
  deletePhysicianByID: deletePhysicianByID,
  deletePhysicianByUsername: deletePhysicianByUsername,
  deletePhysicianByEmail: deletePhysicianByEmail
};