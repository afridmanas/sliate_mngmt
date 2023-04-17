import 'package:flutter/material.dart';
import 'package:sliate/reuse.dart';
import 'package:sliate/screens/home/homepage.dart';
import 'package:sliate/screens/log/forget_pass.dart';
import 'package:sliate/screens/log/signup_page.dart';

// ignore: camel_case_types
class sign_in extends StatefulWidget {
  const sign_in({super.key});

  @override
  State<sign_in> createState() => _sign_inState();
}

// ignore: camel_case_types
class _sign_inState extends State<sign_in> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(150.0),
                  bottomRight: Radius.circular(.0),
                ),
              ),
              height: height / 4,
              width: width,
            ),
            SizedBox(
              width: width,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    const textField_username(),
                    const SizedBox(
                      height: 20,
                    ),
                    const textField_password(),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: ((context) => const forget_pass()),
                              ),
                            );
                          },
                          child: const Text(
                            'forget passwword?',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => const home_page()),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(400, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(color: Colors.grey, width: 1),
                        ),
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.all(10),
                        textStyle: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      child: const Text(
                        'Log In',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Divider(
                      thickness: 2,
                    ),
                    const Divider(
                      thickness: 0,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => const signup_page()),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(400, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(color: Colors.blue, width: 1),
                        ),
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.all(10),
                        textStyle: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      child: const Text('Sign Up'),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
