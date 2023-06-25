import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sliate/color.dart';
import 'package:email_otp/email_otp.dart';
import 'package:sliate/screens/categories/log/otp_verify.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _emailController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  EmailOTP myAuth = EmailOTP();

  void sendOTP(BuildContext context) async {
    myAuth.setConfig(
        appEmail: "afridmanas@gmail.com",
        appName: "SLIATE",
        userEmail: _emailController.text,
        otpLength: 6,
        otpType: OTPType.digitsOnly);
    if (await myAuth.sendOTP() == true) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OTPVerify(
            otpController: otpController,
            verifyOTP: (BuildContext) {
              myAuth.sendOTP();
            },
          ),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("OTP has been sent"),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Oops, OTP send failed"),
        ),
      );
    }
  }

  void verifyOTP(BuildContext context) async {
    if (await myAuth.verifyOTP(otp: otpController.text) == true) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              OTPVerify(otpController: otpController, verifyOTP: verifyOTP),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("OTP is verified"),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Invalid OTP"),
        ),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black, // Change the color of the back arrow here
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 16.0, right: 16),
            child: Text(
              'Forgot password?',
              style: GoogleFonts.mavenPro(
                textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    letterSpacing: .5),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Enter your Email Address below to receive your OTP Code.',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(15.0),
                      border: const OutlineInputBorder(
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
                    height: 20,
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        sendOTP(context);
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(400, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(color: Colors.grey, width: 1),
                        ),
                        backgroundColor: text_clr,
                        padding: const EdgeInsets.all(10),
                        textStyle: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      child: Text(
                        'Send OTP',
                        style: TextStyle(color: bg_clr),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
