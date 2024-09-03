const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const mongoose = require('mongoose');

const app = express();
app.use(cors());
app.use(bodyParser.json());

const port = 3000;

// MongoDB connection details
const mongodbServer = 'mongodb+srv://';
const username = 'dbUser';
const password = 'dbPassword123';
const clustername = 'cluster0.noxusbn.mongodb.net';
const databasename = 'RecipeApp';

// Connect to MongoDB
mongoose
  .connect(
    `${mongodbServer}${username}:${password}@${clustername}/${databasename}?retryWrites=true&w=majority&appName=Cluster0`
  )
  .then(() => console.log('Connected to database'))
  .catch((error) => console.log(error));

const loginDetailsSchema = new mongoose.Schema({
  username: { type: String, required: true },
  email: { type: String, required: true },
  password: { type: String, required: true },
},
{ collection: 'LoginDetails' }//By default MongoDB lowercases collection name, so We explicitly need to name the collection
);

//Model based on the schema
const LoginDetail = mongoose.model('LoginDetails', loginDetailsSchema);

// POST endpoint to handle registration data
app.post('/api/register', async (req, res) => {
  const { username, email, password } = req.body;

  // Create a new document using the LoginDetail model
  const newUser = new LoginDetail({
    username,
    email,
    password,
  });

  try {
    // Save the document to the database
    await newUser.save();
    console.log('Data saved to logindetails:', {
      username: username,
      email: email,
      password: password,
    });

    // Send a success response back to the client
    res.status(200).json({ message: 'Registration successful' });
  } catch (error) {
    console.error('Error saving data:', error);
    res.status(500).json({ message: 'Error registering user' });
  }
});

// Start the server
app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});
