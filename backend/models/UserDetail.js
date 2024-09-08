const mongoose = require('mongoose');

const userDetailsSchema = new mongoose.Schema({
  username: { type: String, required: true },
  email: { type: String, required: true },
  pfp: { type: String, default:"https://i.postimg.cc/k5VcfPG7/blankpfp.webp" },
  favourites: { type: [String], default:[] },
  bio: { type: String, default:"" },
}, {
  collection: 'UserDetails'
});

module.exports = mongoose.model('UserDetails', userDetailsSchema);
