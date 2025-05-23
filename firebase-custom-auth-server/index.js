process.on('uncaughtException', console.error);
process.on('unhandledRejection', console.error);

const express = require("express");
const admin = require("firebase-admin");
const cors = require("cors");
const app = express();
const PORT = 3000;

const serviceAccount = require("./serviceAccountKey.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

app.use(cors());
app.use(express.json());

// Endpoint: Create custom token using student ID
app.post("/login", async (req, res) => {
  const { idNumber } = req.body;

  if (!idNumber) {
    return res.status(400).send("ID number is required.");
  }

  try {
    // Try to find user by UID (assume ID number = UID)
    const user = await admin.auth().getUser(idNumber);

    // Create custom token
    const token = await admin.auth().createCustomToken(user.uid);
    return res.status(200).json({ token });
  } catch (error) {
    return res.status(404).json({ error: "User not found with this ID number." });
  }
});

// Start the server
app.listen(PORT, () => {
  console.log(`Custom auth server running on http://localhost:${PORT}`);
});
