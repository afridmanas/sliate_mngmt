import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sliate/color.dart';
import 'package:sliate/screens/categories/log/login_page.dart';
import 'package:sliate/screens/categories/navigation_bar/Home/home_page.dart';

// ignore: camel_case_types
class hndit_signup extends StatefulWidget {
  @override
  State<hndit_signup> createState() => _hndit_signupState();
}

class _hndit_signupState extends State<hndit_signup> {
  String department = 'hndit';
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _regnumberController = TextEditingController();
  final _fullNameController = TextEditingController();

  Future<void> signUp(BuildContext context) async {
    String fullName = _fullNameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;
    String regNumber = _regnumberController.text;

    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        await FirebaseFirestore.instance
            .collection('/users/login_form/students')
            .doc(userCredential.user!.uid)
            .set(
          {
            'fullName': fullName,
            'email': email,
            'password': password,
            'regNumber': regNumber,
            'department': department,
          },
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Signup Successful')),
        );

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => sign_in()),
          ),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Error'),
              content: const Text('The password is too weak'),
              actions: [
                ElevatedButton(
                  child: const Text('OK'),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          );
        } else if (e.code == 'email-already-in-use') {
          const SnackBar(
            content: Text('Entered Email Address already in use'),
          );
        }
      } catch (e) {
        SnackBar(
          content: Text(e.toString()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double keyboardHeight = (MediaQuery.of(context).viewInsets.bottom) - 50;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: text_clr),
        elevation: 0,
        backgroundColor: bg_clr,
      ),
      body: SizedBox(
        height: height - keyboardHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Center(
                child: Text(
                  'SLIATE',
                  style: GoogleFonts.mavenPro(
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 10,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.name,
                          controller: _fullNameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Full name is required';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(20.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            labelText: 'Your Name',
                            labelStyle: TextStyle(
                                color: Colors
                                    .black, // Replace with your desired text color
                                fontWeight: FontWeight.w600,
                                fontSize: 14.0),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          controller: _emailController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Email Address is required';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(15.0),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            labelText: 'Email Address',
                            labelStyle: TextStyle(
                                color: Colors
                                    .black, // Replace with your desired text color
                                fontWeight: FontWeight.w600,
                                fontSize: 14.0),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          controller: _passwordController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password is required';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(15.0),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            labelText: 'Password',
                            labelStyle: TextStyle(
                                color: Colors
                                    .black, // Replace with your desired text color
                                fontWeight: FontWeight.w600,
                                fontSize: 14.0),
                          ),
                          obscureText: true,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          controller: _regnumberController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Registration Number is required';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(15.0),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            labelText: 'Registration Number',
                            labelStyle: TextStyle(
                                color: Colors
                                    .black, // Replace with your desired text color
                                fontWeight: FontWeight.w600,
                                fontSize: 14.0),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            await signUp(context);
                          },
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(400, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(
                                  color: Colors.grey, width: 1),
                            ),
                            backgroundColor: Colors.black,
                            padding: const EdgeInsets.all(10),
                            textStyle: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              color: bg_clr,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
