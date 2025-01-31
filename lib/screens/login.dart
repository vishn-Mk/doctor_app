import 'package:doctor_app/screens/signup.dart';
import 'package:doctor_app/services/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:ui';

import '../services/google_auth.dart';
import '../wigets/custom_textfield.dart';
import '../wigets/snackbar.dart';
import 'HomeScreen.dart';
import 'forgotpassword.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void setFirebaseLanguage() {
    final FirebaseAuth auth = FirebaseAuth.instance;

    // Set the language code dynamically based on the device's locale
    final String systemLocale = window.locale.languageCode;
    auth.setLanguageCode(systemLocale);
  }

  // Function to save user data in shared preferences
  void saveUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', true); // Save login status
    prefs.setString('email', emailController.text.trim()); // Save email
  }

  // Login function
  void loginUsers() async {
    final FirebaseAuth auth = FirebaseAuth.instance;

    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      try {
        // Set the Firebase Auth locale
        auth.setLanguageCode(
            'en'); // Replace 'en' with your desired language code

        // Perform login
        String res = await AuthServices().loginUser(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        setState(() {
          isLoading = false;
        });

        if (res == "Success") {
          // Save user data after login
          saveUserData();

          // Navigate to the HomePage
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        } else {
          showSnackBar(context, res);
        }
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        showSnackBar(context, "An unexpected error occurred: $e");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    checkLoginStatus(); // Check login status when the screen is loaded
  }

  // Check if user is already logged in
  void checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      // Navigate to HomeScreen if already logged in
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
  }

  // Function to log out and clear shared preferences
  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('isLoggedIn');
    prefs.remove('email');
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Background SVG
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.34,
                  child: SvgPicture.asset(
                    'asset/icons/login.svg', // Update to your asset path
                    fit: BoxFit.cover,
                  ),
                ),
                // Login Form
                Expanded(
                  child: SingleChildScrollView(
                    child: SafeArea(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Your Doctor',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                  "Email",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87),
                                ),
                              ),
                              custom_textfeild(
                                controller: emailController,
                                labeltext: 'Email',
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email';
                                  }
                                  return null;
                                },
                                inputDecoration: InputDecoration(
                                  hintText:
                                      'Write your email ', // Placeholder text
                                  hintStyle: TextStyle(
                                      color: Colors
                                          .grey), // Style the placeholder text
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                  "Password",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87),
                                ),
                              ),
                              custom_textfeild(
                                controller: passwordController,
                                labeltext: 'Password',
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  return null;
                                },
                                inputDecoration: InputDecoration(
                                  hintText:
                                  'Write your Password ', // Placeholder text
                                  hintStyle: TextStyle(
                                      color: Colors
                                          .grey), // Style the placeholder text
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ForgotPasswordScreen(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  '                            Forgot Your Password?',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(height: 0),
                              ElevatedButton(
                                onPressed: loginUsers,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue[400],
                                  minimumSize: const Size(double.infinity, 50),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                ),
                                child: const Text(
                                  'Sign In',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                        height: 1, color: Colors.black26),
                                  ),
                                  const Text(
                                    "  Or Continue with ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Expanded(
                                    child: Container(
                                        height: 1, color: Colors.black26),
                                  )
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: ElevatedButton.icon(
                                      onPressed: () async {
                                        await FirebaseServices()
                                            .signInWithGoogle();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 15),
                                        minimumSize:
                                            const Size(double.infinity, 50),
                                      ),
                                      icon: Image.asset(
                                        'asset/images/google-logo-9808.png',
                                        height: 24,
                                      ),
                                      label: const Text(
                                        'Google',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: ElevatedButton.icon(
                                      onPressed: () {
                                        // Add functionality for another sign-in method
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 15),
                                        minimumSize:
                                            const Size(double.infinity, 50),
                                      ),
                                      icon: Icon(Icons.facebook,
                                          color: Colors.blue),
                                      label: const Text(
                                        'Facebook',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Don't Have An Account?",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SignUp(),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      'Sign Up',
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
