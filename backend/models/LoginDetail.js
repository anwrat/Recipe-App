const mongoose = require('mongoose');

const loginDetailsSchema = new mongoose.Schema({
  username: { type: String, required: true },
  email: { type: String, required: true },
  password: { type: String, required: true },
}, {
  collection: 'LoginDetails'
});

module.exports = mongoose.model('LoginDetails', loginDetailsSchema);
