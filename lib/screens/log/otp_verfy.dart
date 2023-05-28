import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sliate/screens/log/login_page.dart';

class OTPVerificationPage extends StatefulWidget {
  final String verificationId;

  OTPVerificationPage({required this.verificationId});

  @override
  _OTPVerificationPageState createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> {
  final _formKey = GlobalKey<FormState>();
  final _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OTP Verification'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _otpController,
                decoration: InputDecoration(
                  labelText: 'Verification Code',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the verification code';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                child: Text('Verify'),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    PhoneAuthCredential credential =
                        PhoneAuthProvider.credential(
                      verificationId: widget.verificationId,
                      smsCode: _otpController.text,
                    );
                    try {
                      await FirebaseAuth.instance
                          .signInWithCredential(credential);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => sign_in()),
                        ),
                      );
                    } on FirebaseAuthException catch (e) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Error'),
                          //content: Text(e.message),
                          actions: [
                            ElevatedButton(
                              child: Text('OK'),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
