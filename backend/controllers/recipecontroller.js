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

//Get Recipe
exports.getrecipe =async (req, res) => {
    const {recipename} = req.body;
  
    try {
      // Find recipes based on the recipename
      const recipes = await RecipeDetail.find({recipename});
      if (recipes.length > 0) {
        res.status(200).json(recipes); // Send back the found recipes
      } else {
        res.status(404).json({ message: 'No recipes found' });
      }
    } catch (error) {
      console.error('Error fetching recipes:', error);
      res.status(500).json({ message: 'Error fetching recipes' });
    }
  };
  