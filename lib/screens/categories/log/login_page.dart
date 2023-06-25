import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sliate/color.dart';
import 'package:sliate/screens/categories/log/student/check_department.dart';
import 'package:sliate/screens/error_page.dart';
import 'package:sliate/screens/categories/navigation_bar/Home/dashboard.dart';
import 'package:sliate/screens/categories/log/forget_pass.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';

class sign_in extends StatefulWidget {
  @override
  State<sign_in> createState() => _sign_inState();
}

class _sign_inState extends State<sign_in> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  void checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    setState(() {
      _isLoggedIn = isLoggedIn;
    });

    if (_isLoggedIn) {
      // User is already logged in, navigate to the home screen
      navigateToHome();
    }
  }

  void saveLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', true);
  }

  void removeLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('isLoggedIn');
  }

  void navigateToHome() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (BuildContext context) =>  Dashboard()),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        bool exitConfirmation = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              title: Text(
                'Exit App',
                style: GoogleFonts.mavenPro(
                  textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: .5),
                ),
              ),
              content: Text(
                'Are you sure you want to exit the app?',
                style: GoogleFonts.mavenPro(
                  textStyle: const TextStyle(fontSize: 16, letterSpacing: .5),
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text(
                    'Cancel',
                    style: GoogleFonts.mavenPro(
                      textStyle: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          letterSpacing: .5),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                TextButton(
                  child: Text(
                    'Exit',
                    style: GoogleFonts.mavenPro(
                      textStyle: const TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          letterSpacing: .5),
                    ),
                  ),
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                ),
              ],
            );
          },
        );

        return exitConfirmation;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
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
                          image:
                              AssetImage('assets/images/sliate/sliate1.jpeg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: height / 2.7,
                          width: width,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 120, left: 30, right: 30),
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
                          padding: const EdgeInsets.only(
                              top: 130, left: 20, right: 20),
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _emailController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Email Address is required';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.email_rounded),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.all(20.0),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                  ),
                                  labelText: 'Email Address',
                                  labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.0,
                                  ),
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
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.lock),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  contentPadding: EdgeInsets.all(15.0),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))),
                                  labelText: 'Password',
                                  labelStyle: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.0),
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  await login_button(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  fixedSize: const Size(400, 50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(color: widg_clr, width: 1),
                                  ),
                                  backgroundColor: text_clr,
                                  padding: const EdgeInsets.all(10),
                                  textStyle: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                child: Text(
                                  'Log In',
                                  style: TextStyle(color: bg_clr),
                                ),
                              ),
                              const SizedBox(height: 20),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ForgetPassword(),
                                    ),
                                  );
                                },
                                child: Text(
                                  'forget password?',
                                  style: TextStyle(
                                    color: text_clr,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const check_department(),
                                    ),
                                  );
                                },
                                child: Text(
                                  'don\'t have an account?',
                                  style: TextStyle(
                                    color: text_clr,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> login_button(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        if (user != null) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("USERID", user.uid);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((context) => Dashboard()),
            ),
          );
          _emailController.clear();
          _passwordController.clear();
        }
      } on FirebaseAuthException catch (e) {
        const SnackBar(content: Text('Must fill the Empty Fields'));
      }
    }
  }
}
