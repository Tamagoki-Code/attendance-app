const functions = require("firebase-functions");
const admin = require("firebase-admin");
const { DateTime } = require("luxon"); // <- install this!

admin.initializeApp();

// Custom Login Function
exports.customLogin = functions.https.onRequest(async (req, res) => {
  const { id, password } = req.body;

  if (!id || !password) {
    return res.status(400).json({ error: "ID and password are required." });
  }

  try {
    const userDoc = await admin.firestore().collection("users").doc(id).get();

    if (!userDoc.exists) {
      return res.status(404).json({ error: "User not found." });
    }

    const userData = userDoc.data();

    if (userData.password !== password) {
      return res.status(401).json({ error: "Invalid password." });
    }

    const customToken = await admin.auth().createCustomToken(id);

    return res.status(200).json({ token: customToken });
  } catch (error) {
    console.error("Login error:", error);
    return res.status(500).json({ error: "Internal server error." });
  }
});

// Scheduled Function to Move Old Events
exports.moveOldEvents = functions.pubsub.schedule("every 10 minutes").onRun(async (context) => {
  const db = admin.firestore();
  const eventsSnapshot = await db.collection("events").get();
  const now = DateTime.now();

  for (const doc of eventsSnapshot.docs) {
    const data = doc.data();

    if (!data.date || !data.time_out) continue;

    // Parse date + time_out string (e.g., "05/23/2025 2:00 PM")
    const combinedDateTime = DateTime.fromFormat(`${data.date} ${data.time_out}`, "MM/dd/yyyy h:mm a");

    if (!combinedDateTime.isValid) continue;

    const timeoutPlus5Hours = combinedDateTime.plus({ hours: 5 });

    if (now > timeoutPlus5Hours) {
      // Move document
      await db.collection("recent_events").doc(doc.id).set(data);
      await db.collection("events").doc(doc.id).delete();
      console.log(`Moved event ${doc.id} to recent_events.`);
    }
  }

  return null;
});
