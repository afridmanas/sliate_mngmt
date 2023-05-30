import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sliate/screens/log/login_page.dart';

class OTPVerificationPage extends StatefulWidget {
  final String verificationId;

  const OTPVerificationPage({super.key, required this.verificationId});

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
        title: const Text('OTP Verification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _otpController,
                decoration: const InputDecoration(
                  labelText: 'Verification Code',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the verification code';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                child: const Text('Verify'),
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
                          builder: ((context) => const sign_in()),
                        ),
                      );
                    } on FirebaseAuthException {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Error'),
                          //content: Text(e.message),
                          actions: [
                            ElevatedButton(
                              child: const Text('OK'),
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
