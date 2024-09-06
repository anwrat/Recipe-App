const mongoose = require('mongoose');

const recipeSchema = new mongoose.Schema({
  image: { type: String, required: true },
  recipename: { type: String, required: true },
  owner: { type: String, required: true },
  category: { type: String, required: true },
  recipedetails: { type: String, required: true },
  ingredients: { type: String, required: true },
  instructions: { type: String, required: true },
}, {
  collection: 'RecipeDetails'
});

module.exports = mongoose.model('RecipeDetails', recipeSchema);
