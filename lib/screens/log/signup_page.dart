import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sliate/color.dart';
import 'package:sliate/screens/log/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sliate/screens/navigation_bar/Home/dashboard.dart';

// ignore: camel_case_types
class sign_up extends StatefulWidget {
  const sign_up({super.key});

  @override
  State<sign_up> createState() => _sign_upState();
}

class _sign_upState extends State<sign_up> {
  // final TextEditingController _usernameController = TextEditingController();
  // final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  //final _confirmPasswordController = TextEditingController();
  final _regnumberController = TextEditingController();
  final _fullNameController = TextEditingController();

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final password = _passwordController.text;
      final reg_no = _regnumberController.text;

      try {
        final userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'email': email,
          'reg_no': reg_no,
        });

        // Navigate to the home screen
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

    return Scaffold(
      backgroundColor: bg_clr,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.92),
                BlendMode.srcOver,
              ),
              child: Container(
                height: height,
                width: width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/sliate/sliate1.jpeg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: height / 2.7,
                  width: width,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 120, left: 30, right: 30),
                    child: Center(
                      child: Text(
                        'SLIATE',
                        style: GoogleFonts.mavenPro(
                          textStyle: TextStyle(
                            color: text_clr,
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 100, left: 40, right: 40),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _fullNameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Full name is required';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(20.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            labelText: 'Your Name',
                            labelStyle: TextStyle(
                                color: widg_clr,
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
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(15.0),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            labelText: 'Email Address',
                            labelStyle: TextStyle(
                                color: widg_clr,
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
                          obscureText: true,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(20.0),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            labelText: 'Password',
                            labelStyle: TextStyle(
                                color: widg_clr,
                                fontWeight: FontWeight.w600,
                                fontSize: 14.0),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          controller: _regnumberController,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Student Registration Number is required!';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(15.0),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            labelText: 'Registration Number',
                            labelStyle: TextStyle(
                                color: widg_clr,
                                fontWeight: FontWeight.w600,
                                fontSize: 14.0),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              try {
                                UserCredential userCredential =
                                    await FirebaseAuth.instance
                                        .createUserWithEmailAndPassword(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                );
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(userCredential.user!.uid)
                                    .set(
                                  {
                                    'name': _fullNameController.text,
                                    'email': _emailController.text,
                                    'password': _passwordController.text,
                                    'reg_no': _regnumberController.text,
                                  },
                                );
                                SnackBar(
                                  content: Text('Account Created Successfully'),
                                );

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: ((context) => const dashboard()),
                                  ),
                                );
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'weak-password') {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text('Error'),
                                      content: const Text(
                                          'The password is too weak'),
                                      actions: [
                                        ElevatedButton(
                                          child: const Text('OK'),
                                          onPressed: () =>
                                              Navigator.pop(context),
                                        ),
                                      ],
                                    ),
                                  );
                                } else if (e.code == 'email-already-in-use') {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text('Error'),
                                      content: const Text(
                                          'The email is already in use'),
                                      actions: [
                                        ElevatedButton(
                                          child: const Text('OK'),
                                          onPressed: () =>
                                              Navigator.pop(context),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              } catch (e) {
                                SnackBar(
                                  content: Text(e.toString()),
                                );
                              }
                            }
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
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => sign_in(),
                                  ),
                                );
                              },
                              child: const Text(
                                'already have an account?',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
