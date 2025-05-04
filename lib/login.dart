import 'package:attendance_app/home_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:attendance_app/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // Define controllers for the text fields
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Define Firebase Auth instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background content
          Container(
            decoration:  BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/bckgr.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding:  EdgeInsets.only(top: 68.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Logo
                  Padding(
                    padding:  EdgeInsets.only(bottom: 8.0),
                    child: Image.asset(
                      "images/SMCTI LOGO.png",
                      width: 99,
                      height: 99,
                    ),
                  ),

                  // Log In Title and Subtitle
                   Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Log In",
                            style: TextStyle(
                              fontSize: 32,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              color: Color(0xff1f1f39),
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Enter your details below.",
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.normal,
                              color: Color(0xffB8B8D2),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Form Container
                  Padding(
                    padding:  EdgeInsets.all(16.0),
                    child: Container(
                      width: double.infinity,
                      height: 500,
                      decoration: BoxDecoration(
                        color:  Color(0xff0b1af2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding:  EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             SizedBox(height: 40),
                            // ID Number Field
                            TextField(
                              controller: _idController,
                              decoration: InputDecoration(
                                prefixIcon: Padding(
                                  padding:  EdgeInsets.symmetric(
                                      horizontal: 12.0),
                                  child: Image.asset(
                                    'images/idnumber_icon.png',
                                    width: 20,
                                    height: 20,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                hintText: 'ID Number',
                                hintStyle:  TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                             SizedBox(height: 20),

                            // Password Field
                            TextField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                prefixIcon: Padding(
                                  padding:  EdgeInsets.symmetric(
                                      horizontal: 12.0),
                                  child: Image.asset(
                                    'images/password_icon.png',
                                    width: 20,
                                    height: 20,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                hintText: 'Password',
                                hintStyle:  TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                             SizedBox(height: 40),

// Log In Button
Center(
  child: SizedBox(
    width: 239,
    height: 45,
    child: ElevatedButton(
      onPressed: () async {
  String id = _idController.text.trim();
  String password = _passwordController.text.trim();

  if (id.isEmpty || password.isEmpty) {
    // You can show a snackbar or dialog to notify the user
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Please enter your ID and password.')),
    );
    return;
  }

  try {
    // Step 1: Lookup email from Firestore using ID number
    QuerySnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('id', isEqualTo: id)
        .limit(1)
        .get();

    if (userSnapshot.docs.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No user found with this ID number.')),
      );
      return;
    }

    // Step 2: Retrieve email from the document
    String email = userSnapshot.docs.first.get('email');

    // Step 3: Log in using the retrieved email
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Step 4: Navigate to home
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeContent()),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Login failed')),
      );
    }

  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Unexpected error: $e')),
    );
  }
},

      style: ElevatedButton.styleFrom(
        backgroundColor:  Color(0xff0788FF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      child:  Text(
        "Log In",
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ),
  ),
),
 SizedBox(height: 10),

                            // Forgot Password
                             Center(
                              child: Text(
                                "Forgot your password?",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 10,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                             SizedBox(height: 20),

                            // OR Text
                             Center(
                              child: Text(
                                "OR",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                             SizedBox(height: 25),

                            // Sign Up Button
                            Center(
                              child: SizedBox(
                                width: 239,
                                height: 45,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                             SignUpPage(),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  ),
                                  child:  Text(
                                    "Sign Up",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff0b1af2),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Image App Bar (upper part)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 113,
              decoration:  BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/purple_gradient_up.png"),
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              ),
            ),
          ),

          // Image App Bar (bottom part)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 90,
              decoration:  BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/purple_gradient_down.png"),
                  fit: BoxFit.cover,
                  alignment: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


