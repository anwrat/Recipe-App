const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const mongoose = require('mongoose');
const bcrypt = require('bcrypt'); // Import bcrypt for hashing password 

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

  const hashedPassword = await bcrypt.hash(password, 10);//10 is the level of hashing
  // Create a new document using the LoginDetail model
  const newUser = new LoginDetail({
    username,
    email,
    password:hashedPassword,
  });

  try {
    // Save the document to the database
    await newUser.save();
    console.log('Data saved to LoginDetails:', {
      username: username,
      email: email,
      password: hashedPassword,
    });

    // Send a success response back to the client
    res.status(200).json({ message: 'Registration successful' });
  } catch (error) {
    console.error('Error saving data:', error);
    res.status(500).json({ message: 'Error registering user' });
  }
});


// POST endpoint to check same username
app.post('/api/checkusername', async (req, res) => {
  const { username } = req.body;

  try {
    // Check if username already exists
    const existingUser = await LoginDetail.findOne({ username });

    if (existingUser) {
      // If username exists, send a 409 Conflict status code
      return res.status(409).json({ message: 'Username already exists' });
    }

    // If username does not exist, send a 200 OK status code
    res.status(200).json({ message: 'Username is available' });
  } catch (error) {
    console.error('Error checking username:', error);
    res.status(500).json({ message: 'Error checking username' });
  }
});

// POST endpoint to check same email
app.post('/api/checkemail', async (req, res) => {
  const {email} = req.body;

  try {
    const existingUser = await LoginDetail.findOne({email});

    if (existingUser) {
      return res.status(409).json({ message: 'Email already exists' });
    }

    res.status(200).json({ message: 'Email is available' });
  } catch (error) {
    console.error('Error checking email:', error);
    res.status(500).json({ message: 'Error checking email' });
  }
});

// POST endpoint to verify login
app.post('/api/login', async (req, res) => {
  const {username,password} = req.body;

  try {
    const user = await LoginDetail.findOne({username});

    if (!user) {
      return res.status(409).json({ message: 'User doesnot exist' });
    }
    else{
      const isPasswordValid = await bcrypt.compare(password, user.password);
      if(!isPasswordValid){
        return res.status(409).json({ message: 'Email already exists' });
      }
      else{
        res.status(200).json({ message: 'Email is available' });
      }
    }
  } catch (error) {
    console.error('Error checking email:', error);
    res.status(500).json({ message: 'Error checking email' });
  }
});

// POST endpoint to change password
app.post('/api/changepass', async (req, res) => {
  const { username, oldpassword, newpassword } = req.body;

  try {
    // Find the user by username
    const user = await LoginDetail.findOne({ username });

    if (!user) {
      return res.status(404).json({ message: 'User does not exist' });
    }

    // Check if the old password is valid
    const isPasswordValid = await bcrypt.compare(oldpassword, user.password);

    if (!isPasswordValid) {
      return res.status(401).json({ message: 'Old password is incorrect' });
    }

    // Hash the new password
    const hashedNewPassword = await bcrypt.hash(newpassword, 10);

    // Update the user's password in the database
    user.password = hashedNewPassword;
    await user.save();

    // Send a success response
    res.status(200).json({ message: 'Password changed successfully' });

  } catch (error) {
    console.error('Error changing password:', error);
    res.status(500).json({ message: 'Error changing password' });
  }
});


// Start the server
app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});
