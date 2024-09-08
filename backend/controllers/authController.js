const bcrypt = require('bcrypt');
const LoginDetail = require('../models/LoginDetail');
const UserDetail = require('../models/UserDetail');

// Register user
exports.register = async (req, res) => {
  const { username, email, password } = req.body;
  const hashedPassword = await bcrypt.hash(password, 10);

  try {
    const newUser = new LoginDetail({ username, email, password: hashedPassword });
    await newUser.save();
    res.status(200).json({ message: 'Registration successful' });
  } catch (error) {
    console.error('Error saving data:', error);
    res.status(500).json({ message: 'Error registering user' });
  }
};

// Check username
exports.checkUsername = async (req, res) => {
  const { username } = req.body;

  try {
    const existingUser = await LoginDetail.findOne({ username });
    if (existingUser) return res.status(409).json({ message: 'Username already exists' });
    res.status(200).json({ message: 'Username is available' });
  } catch (error) {
    console.error('Error checking username:', error);
    res.status(500).json({ message: 'Error checking username' });
  }
};

// Check email
exports.checkEmail = async (req, res) => {
  const { email } = req.body;

  try {
    const existingUser = await LoginDetail.findOne({ email });
    if (existingUser) return res.status(409).json({ message: 'Email already exists' });
    res.status(200).json({ message: 'Email is available' });
  } catch (error) {
    console.error('Error checking email:', error);
    res.status(500).json({ message: 'Error checking email' });
  }
};

// Login user
exports.login = async (req, res) => {
  const { username, password } = req.body;

  try {
    const user = await LoginDetail.findOne({ username });
    if (!user) return res.status(409).json({ message: 'User does not exist' });

    const isPasswordValid = await bcrypt.compare(password, user.password);
    if (!isPasswordValid) return res.status(401).json({ message: 'Password is incorrect' });

    res.status(200).json({ message: 'Login successful' });
  } catch (error) {
    console.error('Error logging in:', error);
    res.status(500).json({ message: 'Error logging in' });
  }
};

// Change password
exports.changePassword = async (req, res) => {
  const { username, oldpassword, newpassword } = req.body;

  try {
    const user = await LoginDetail.findOne({ username });
    if (!user) return res.status(404).json({ message: 'User does not exist' });

    const isPasswordValid = await bcrypt.compare(oldpassword, user.password);
    if (!isPasswordValid) return res.status(401).json({ message: 'Old password is incorrect' });

    const hashedNewPassword = await bcrypt.hash(newpassword, 10);
    user.password = hashedNewPassword;
    await user.save();

    res.status(200).json({ message: 'Password changed successfully' });
  } catch (error) {
    console.error('Error changing password:', error);
    res.status(500).json({ message: 'Error changing password' });
  }
};

// Save to user details while registering
exports.savetouserdetails = async (req, res) => {
  const { username, email } = req.body;

  try {
    const newUser = new UserDetail({ username, email});
    await newUser.save();
    res.status(200).json({ message: 'User details saved' });
  } catch (error) {
    console.error('Error saving data:', error);
    res.status(500).json({ message: 'Error saving to userdetails' });
  }
};

//Get from userdetails
exports.getuserdetails =async (req, res) => {
  const {username} = req.body;

  try {
    const users = await UserDetail.find({username});
    if (users.length > 0) {
      res.status(200).json(users); 
    } else {
      res.status(404).json({ message: 'No users found' });
    }
  } catch (error) {
    console.error('Error fetching user:', error);
    res.status(500).json({ message: 'Error fetching user' });
  }
};

// Edit profile
exports.editprofile = async (req, res) => {
  const { username, pfp, bio} = req.body;

  try {
    const user = await UserDetail.findOne({ username });
    if (!user) return res.status(404).json({ message: 'User does not exist' });

    user.pfp = pfp;
    user.bio=bio;
    await user.save();

    res.status(200).json({ message: 'Profile edited succesfully' });
  } catch (error) {
    console.error('Error editing profile:', error);
    res.status(500).json({ message: 'Error editing profile' });
  }
};