import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sliate/color.dart';
import 'package:sliate/screens/navigation_bar/Home/dashboard.dart';
import 'package:sliate/screens/log/forget_pass.dart';
import 'package:sliate/screens/log/signup_page.dart';
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
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

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
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (BuildContext context) => const dashboard()),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleSignInAccount!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    try {
      final UserCredential userCredential =
          await auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      // Check if the user's email matches an already signed up user's email
      // and show the details if it matches
      if (user != null) {
        final currentUser = auth.currentUser;
        if (currentUser != null && currentUser.email == user.email) {
          const SnackBar(content: Text('User Signed in Successfully'));
          print('Signed in as : ${user?.displayName}');

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const dashboard()),
          );
        }
      }
    } catch (e) {
        SnackBar(content: Text('Failed to sign in with Google: $e'));
      print('Failed to sign in with Google: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      // backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
                        image: AssetImage('assets/images/sliate/sliate1.jpeg'),
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
                            top: 130, left: 40, right: 40),
                        child: Column(
                          children: [
                            TextField(
                              controller: _emailController,
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
                            TextField(
                              controller: _passwordController,
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
                                final user = FirebaseAuth.instance.currentUser;
                                if (_formKey.currentState!.validate()) {
                                  try {
                                    await FirebaseAuth.instance
                                        .signInWithEmailAndPassword(
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                    );
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    prefs.setString("USERID", user!.uid);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: ((context) =>
                                            const dashboard()),
                                      ),
                                    );
                                    _emailController.clear();
                                    _passwordController.clear();
                                  } on FirebaseAuthException catch (e) {
                                    const SnackBar(
                                        content:
                                            Text('Must fill the Empty Fields'));
                                  }
                                }
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
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              child: Text(
                                'Log In',
                                style: TextStyle(color: bg_clr),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                 const ForgetPassword()));
                                  },
                                  child: Text(
                                    'forget password?',
                                    style: TextStyle(
                                      color: text_clr,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
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
                                        builder: (context) => const sign_up(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'don\'t have an account?',
                                    style: TextStyle(
                                      color: text_clr,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            SignInButton(
                              Buttons.Google,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              onPressed: () async {
                                _signInWithGoogle;

                                // try {
                                //   final GoogleSignInAccount? googleUser =
                                //       await _googleSignIn.signIn();
                                //   if (googleUser != null) {
                                //     final GoogleSignInAuthentication
                                //         googleAuth =
                                //         await googleUser.authentication;

                                //     final AuthCredential credential =
                                //         GoogleAuthProvider.credential(
                                //       accessToken: googleAuth.accessToken,
                                //       idToken: googleAuth.idToken,
                                //     );
                                //     final UserCredential userCredential =
                                //         await _auth.signInWithCredential(
                                //             credential);
                                //     final User? user = userCredential.user;

                                //     print(
                                //         'Signed in as : ${user?.displayName}');

                                //     Navigator.pushReplacement(
                                //       context,
                                //       MaterialPageRoute(
                                //           builder: (context) =>
                                //               const dashboard()),
                                //     );
                                //   }
                                // } catch (error) {
                                //   // Handle sign-in errors
                                //   print('Sign-In Error: $error');
                                // }
                              },
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
    );
  }
}
