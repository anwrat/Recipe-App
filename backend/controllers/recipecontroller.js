const bcrypt = require('bcrypt');
const RecipeDetail = require('../models/RecipeDetail');

// Create recipe
exports.createrecipe = async (req, res) => {
  const { image,recipename,owner,category ,recipedetails,ingredients,instructions} = req.body;
  try {
    const existingRecipe = await RecipeDetail.findOne({recipename});
    if (existingRecipe) return res.status(409).json({ message: 'Recipe already exists' });
    const newRecipe = new RecipeDetail({image,recipename,owner,category ,recipedetails,ingredients,instructions});
    await newRecipe.save();
    res.status(200).json({ message: 'Recipe Creation successful' });
  } catch (error) {
    console.error('Error saving data:', error);
    res.status(500).json({ message: 'Error creating recipe' });
  }
};