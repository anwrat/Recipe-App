const express = require('express');
const router = express.Router();
const recController = require('../controllers/recipecontroller');

// Create Recipe route
router.post('/createrecipe', recController.createrecipe);

module.exports = router;
