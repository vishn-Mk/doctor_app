import 'package:doctor_app/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../services/google_auth.dart';
import '../wigets/custom_textfield.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  String selectedCountryCode = '+91'; // Default country code

  void signUpUser() {
    if (_formKey.currentState!.validate()) {
      // Implement signup logic here
      print('Signing up with: $selectedCountryCode ${phoneController.text}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
        children: [
          SizedBox(height: 60),
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            child: SvgPicture.asset(
              'asset/icons/signup.svg',
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: SafeArea(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Your Doctor',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 10),

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
                        SizedBox(height: 10),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Code           Mobile Phone",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87),
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: DropdownButton<String>(
                                value: selectedCountryCode,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedCountryCode = newValue!;
                                  });
                                },
                                items: ['+1', '+91', '+44', '+61', '+971']
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                underline: SizedBox(),
                              ),
                            ),
                            SizedBox(width: 10),

                            Expanded(
                              child: TextFormField(
                                controller: phoneController,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  // labelText: "Enter phone number",  // Label is empty
                                  hintText: "Enter phone number",  // Placeholder text
                                  hintStyle: TextStyle(color: Colors.grey), // Style for placeholder text
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your phone number';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 10),

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
                          controller: emailController,
                          labeltext: 'Password',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                          inputDecoration: InputDecoration(
                            hintText:
                            'Write your Password here', // Placeholder text
                            hintStyle: TextStyle(
                                color: Colors
                                    .grey), // Style the placeholder text
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),

                        ElevatedButton(
                          onPressed: signUpUser,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            minimumSize: Size(double.infinity, 50),
                            padding: EdgeInsets.symmetric(vertical: 15),
                          ),
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                                fontSize: 16, color: Colors.white),
                          ),
                        ),
                        SizedBox(height: 10),

                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                  height: 1, color: Colors.black26),
                            ),
                            const Text("  Or Continue with ",style: TextStyle(fontWeight: FontWeight.bold),),
                            Expanded(
                              child: Container(
                                height: 1, color: Colors.black26,),
                            )
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () async {
                                  await FirebaseServices().signInWithGoogle();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 15),
                                  minimumSize: const Size(double.infinity, 50),
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
                            const SizedBox(width: 10), // Space between buttons
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  // Add functionality for another sign-in method
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 15),
                                  minimumSize: const Size(double.infinity, 50),
                                ),
                                icon: Icon(Icons.facebook, color: Colors.blue), // Example icon
                                label: const Text(
                                  'Facebook',
                                  style: TextStyle(color: Colors.blue),
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
                              style:
                              TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        Login(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Sign In',
                                style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),
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