const express = require('express');
const bodyParser = require('body-parser');
const mongoose = require('mongoose');
const cors = require('cors');

const app = express();
app.use(bodyParser.json());
app.use(cors());

// Connect to MongoDB
mongoose.connect('mongodb://localhost:27017/mydb', {
    useNewUrlParser: true,
    useUnifiedTopology: true,
});

// Define User Schema
const UserSchema = new mongoose.Schema({
    username: String,
    password: String,
    email: String,
    name: String,
    dob: Date,
    phoneNumber: String // Add phone number field
});

const User = mongoose.model('User', UserSchema, 'details');

// Login endpoint
app.post('/login', async (req, res) => {
    const { email, password } = req.body;
    const user = await User.findOne({ email, password });
    if (user) {
        res.send({ message: 'Login successful' });
    } else {
        res.status(401).send({ message: 'Invalid email or password' });
    }
});

// Registration endpoint
app.post('/register', async (req, res) => {
    const { username, email, password, name, dob, phoneNumber } = req.body; // Add phoneNumber parameter
    try {
        // Check if the email is already registered
        const existingUser = await User.findOne({ email });
        if (existingUser) {
            return res.status(400).json({ message: 'Email already registered' });
        }
        // Save new user to the database
        const newUser = new User({ username, email, password, name, dob, phoneNumber }); // Include phoneNumber field
        await newUser.save();
        // Respond with success message
        res.status(200).json({ message: 'Registration successful' });
    } catch (error) {
        console.error('Error registering user:', error);
        // Respond with error message
        res.status(500).json({ message: 'An error occurred while registering user' });
    }
});

// Start the server
app.listen(3000, () => {
    console.log('Server is running on port 3000');
});
