const express = require('express');
const bodyParser = require('body-parser');

const cors = require('cors');

const app = express();
app.use(cors());
const port = 3000;

// Middleware to parse JSON bodies
app.use(bodyParser.json());

// POST endpoint to handle registration data
app.post('/api/register', (req, res) => {
  const { username, email, password } = req.body;

  // Log the received data
  console.log('Received data:', {
    username: username,
    email: email,
    password: password,
  });
  // Send a response back to the client
  res.status(200).json({ message: 'Registration successful' });
});

// Start the server
app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});
