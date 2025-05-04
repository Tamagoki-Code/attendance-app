const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

exports.customLogin = functions.https.onRequest(async (req, res) => {
  const { id, password } = req.body;

  if (!id || !password) {
    return res.status(400).json({ error: "ID and password are required." });
  }

  try {
    // Assuming users are stored under 'users' collection with document IDs equal to their ID
    const userDoc = await admin.firestore().collection("users").doc(id).get();

    if (!userDoc.exists) {
      return res.status(404).json({ error: "User not found." });
    }

    const userData = userDoc.data();

    // Compare password (for security, use hashed passwords in production)
    if (userData.password !== password) {
      return res.status(401).json({ error: "Invalid password." });
    }

    // Create a custom token using a UID (you can use the ID as UID if that's your design)
    const customToken = await admin.auth().createCustomToken(id);

    return res.status(200).json({ token: customToken });
  } catch (error) {
    console.error("Login error:", error);
    return res.status(500).json({ error: "Internal server error." });
  }
});
