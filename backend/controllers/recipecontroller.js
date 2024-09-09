const Fuse = require('fuse.js');
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

  // Get all recipes
exports.getallrecipe = async (req, res) => {
  try {
    const recipes = await RecipeDetail.find({}); 
    if (recipes.length > 0) {
      res.status(200).json(recipes); 
    } else {
      res.status(404).json({ message: 'No recipes found' });
    }
  } catch (error) {
    console.error('Error fetching recipes:', error);
    res.status(500).json({ message: 'Error fetching recipes' });
  }
};

// Edit Recipe
exports.editrecipe = async (req, res) => {
  const { orgname,image,recipename,category ,recipedetails,ingredients,instructions} = req.body;
  try {
    const existingRecipe = await RecipeDetail.findOne({recipename:orgname});
    if (!existingRecipe) return res.status(409).json({ message: 'Recipe doesnot exist' });

    existingRecipe.image=image;
    existingRecipe.recipename=recipename;
    existingRecipe.category=category;
    existingRecipe.recipedetails=recipedetails;
    existingRecipe.ingredients=ingredients;
    existingRecipe.instructions=instructions;
    await existingRecipe.save();
    res.status(200).json({ message: 'Recipe Edit successful' });
  } catch (error) {
    console.error('Error saving data:', error);
    res.status(500).json({ message: 'Error editing recipe' });
  }
};

// Delete Recipe
exports.deleterecipe = async (req, res) => {
  const { recipename } = req.body;

  try {
    // Find and delete the recipe based on the recipename
    const deletedRecipe = await RecipeDetail.findOneAndDelete({ recipename });

    if (deletedRecipe) {
      res.status(200).json({ message: 'Recipe deleted successfully' });
    } else {
      res.status(404).json({ message: 'Recipe not found' });
    }
  } catch (error) {
    console.error('Error deleting recipe:', error);
    res.status(500).json({ message: 'Error deleting recipe' });
  }
};

// Search Recipe
exports.searchrecipe = async (req, res) => {
  const { searchText } = req.body;

  try {
    // Fetch all recipes
    const allRecipes = await RecipeDetail.find({});

    // Fuse.js option for fuzzy search
    const fuse = new Fuse(allRecipes, {keys: ['recipename'], threshold: 0.3, });

    // Perform the search
    const fuzzyResults = fuse.search(searchText);

    // Extract matched items
    const recipes = fuzzyResults.map(result => result.item);

    if (recipes.length > 0) {
      res.status(200).json(recipes);
    } else {
      res.status(404).json({ message: 'No recipes found' });
    }
  } catch (error) {
    console.error('Error fetching recipes:', error);
    res.status(500).json({ message: 'Error fetching recipes' });
  }
};

  