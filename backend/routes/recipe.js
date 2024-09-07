const express = require('express');
const router = express.Router();
const recController = require('../controllers/recipecontroller');

// Create Recipe route
router.post('/createrecipe', recController.createrecipe);

//Get Recipe route
router.post('/getrecipe',recController.getrecipe);

module.exports = router;
