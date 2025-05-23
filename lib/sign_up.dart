import 'package:attendance_app/login.dart';
import 'package:flutter/material.dart';
import 'package:attendance_app/sceb_login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _idController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background content
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/bckgr.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 68.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Image.asset(
                      "images/SMCTI LOGO.png",
                      width: 99,
                      height: 99,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, top: 16.0),
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 32,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            color: Color(0xff1f1f39),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          width: double.infinity,
                          height: 550, // Set a fixed height for the rectangle
                          decoration: BoxDecoration(
                            color: const Color(0xff0b1af2),
                            borderRadius: BorderRadius.circular(20),
                          ),

                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // G Suite Email Address
                                TextField(
                                  controller: _emailController,
                                  decoration: InputDecoration(
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12.0),
                                      child: Image.asset(
                                        'images/gsuite_icon.png',
                                        width: 20,
                                        height: 20,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    prefixIconConstraints: const BoxConstraints(
                                      minWidth: 40,
                                      minHeight: 20,
                                    ),
                                    hintText: 'G Suite Email Address',
                                    hintStyle: const TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14,
                                    ),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 30),
                                // ID Number
                                TextField(
                                  controller: _idController,
                                  decoration: InputDecoration(
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12.0),
                                      child: Image.asset(
                                        'images/idnumber_icon.png',
                                        width: 20,
                                        height: 20,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    prefixIconConstraints: const BoxConstraints(
                                      minWidth: 40,
                                      minHeight: 20,
                                    ),
                                    hintText: 'ID Number',
                                    hintStyle: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 30),
                                // Username
                                TextField(
                                  obscureText: true,
                                  controller: _usernameController,
                                  decoration: InputDecoration(
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12.0),
                                      child: Image.asset(
                                        'images/username_icon.png',
                                        width: 20,
                                        height: 20,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    prefixIconConstraints: const BoxConstraints(
                                      minWidth: 40,
                                      minHeight: 20,
                                    ),
                                    hintText: 'Username',
                                    hintStyle: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 30),
                                // Password
                                TextField(
                                  obscureText: true,
                                  controller: _passwordController,
                                  decoration: InputDecoration(
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12.0),
                                      child: Image.asset(
                                        'images/password_icon.png',
                                        width: 20,
                                        height: 20,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    prefixIconConstraints: const BoxConstraints(
                                      minWidth: 40,
                                      minHeight: 20,
                                    ),
                                    hintText: 'Password',
                                    hintStyle: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 30),
                                                                //Student Button
                                Center(
                                  child: SizedBox(
                                    width: 239,
                                    height: 45,
                                    child: ElevatedButton(
                                      onPressed: () async {
  try {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final idNumber = _idController.text.trim();
    final username = _usernameController.text.trim();

    // Validate if email ends with @smctagum.edu.ph
    if (!email.endsWith('@smctagum.edu.ph')) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Email must be from @smctagum.edu.ph domain')),
      );
      return; // Exit the function if email is invalid
    }

    // Create user with the validated email and password
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    // Store additional user information in Firestore
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userCredential.user!.uid)
        .set({
      'email': email,
      'id': idNumber,
      'username': username,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Sign up successful!')),
    );

    // Navigate to the login page after successful sign-up
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Login()),
    );
  } on FirebaseAuthException catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: ${e.message}')),
    );
  }
},

                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors
                                            .white, // Button background color
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                      ),
                                      child: const Text(
                                        "SignUp",
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color(0xff0b1af2), // Text color
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
              decoration: const BoxDecoration(
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
              decoration: const BoxDecoration(
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
