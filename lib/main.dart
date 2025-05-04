import 'package:firebase_core/firebase_core.dart'; // ✅ Import Firebase core
import 'package:flutter/material.dart';
import 'package:attendance_app/first_page.dart';
import 'package:firebase_core_web/firebase_core_web.dart'; // Add this import for web

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // ✅ Ensures binding before Firebase
  
  // Initialize Firebase with FirebaseOptions
await Firebase.initializeApp(
  options: FirebaseOptions(
    apiKey: "AIzaSyBXTia0KCxXY5mwWJFRjA6riXgBkPl1YcA",
    authDomain: "scebcollab.firebaseapp.com",
    databaseURL: "https://scebcollab-default-rtdb.asia-southeast1.firebasedatabase.app",
    projectId: "scebcollab",
    storageBucket: "scebcollab.appspot.com", // ✅ Fixed here
    messagingSenderId: "660780216342",
    appId: "1:660780216342:web:0e94c042d6c86c3d0e0537",
  ),
);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xff0b1af2),
          elevation: 0.0,
        ),
      ),
      home: const FirstPage(),
    );
  }
}
