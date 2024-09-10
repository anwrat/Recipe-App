const express = require('express');
const router = express.Router();
const authController = require('../controllers/authController');

// Register route
router.post('/register', authController.register);

// Check username route
router.post('/checkusername', authController.checkUsername);

// Check email route
router.post('/checkemail', authController.checkEmail);

// Login route
router.post('/login', authController.login);

// Change password route
router.post('/changepass', authController.changePassword);

//Save to Userdetails
router.post('/savetouserdetails',authController.savetouserdetails);

//Get from Userdetails
router.post('/getuserdetails',authController.getuserdetails);

//Edit profile of userdetails
router.post('/editprofile',authController.editprofile);

//Check if recipe is favourite
router.post('/checkfav',authController.checkfav);

//Add/remove from favourites
router.post('/editfav',authController.editfav);

module.exports = router;
