import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class VerifyOtpPage extends StatefulWidget {
  final String phoneNumber;

  const VerifyOtpPage({required this.phoneNumber});

  @override
  _VerifyOtpPageState createState() => _VerifyOtpPageState();
}

class _VerifyOtpPageState extends State<VerifyOtpPage> {
  final _formKey = GlobalKey<FormState>();
  final _otpController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;
  bool _codeTimeout = false;

  Future<void> _verifyPhoneNumber() async {
    await _auth.verifyPhoneNumber(
      phoneNumber: widget.phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
        Fluttertoast.showToast(msg: 'Phone number automatically verified');
        // Redirect to the home page or any other desired page
      },
      verificationFailed: (FirebaseAuthException e) {
        Fluttertoast.showToast(msg: 'Verification failed. Please try again.');
      },
      codeSent: (String verificationId, int? resendToken) {
        // Save the verification ID for later use
        String smsCode = _otpController.text.trim();

        // Create a PhoneAuthCredential with the verification ID and SMS code
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId,
          smsCode: smsCode,
        );

        // Sign in the user with the credential
        _signInWithCredential(credential);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        setState(() {
          _codeTimeout = true;
        });
        Fluttertoast.showToast(msg: 'Verification code timeout');
        // Handle the timeout situation, e.g. display a message to the user
      },
    );
  }

  Future<void> _signInWithCredential(PhoneAuthCredential credential) async {
    try {
      await _auth.signInWithCredential(credential);
      Fluttertoast.showToast(msg: 'Phone number verified');
      // Redirect to the home page or any other desired page
    } catch (e) {
      Fluttertoast.showToast(msg: 'Invalid OTP. Please try again.');
    }
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify OTP'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _otpController,
                  decoration: const InputDecoration(
                    labelText: 'Enter OTP',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter OTP';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _codeTimeout
                      ? null
                      : () {
                          if (_formKey.currentState!.validate()) {
                            _verifyPhoneNumber();
                          }
                        },
                  child: const Text('Verify'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
