import 'package:flutter/material.dart';
import 'package:sliate/screens/home/home_design1.dart';

// ignore: camel_case_types
class sign_in extends StatefulWidget {

  @override
  State<sign_in> createState() => _sign_inState();
}


class _sign_inState extends State<sign_in> {
   final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
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
                   TextField(
                    controller: _usernameController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(20.0),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        labelText: 'Email Address',
        labelStyle: TextStyle(
            color: Colors.grey, fontWeight: FontWeight.w600, fontSize: 14.0),
      ),
    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: _passwordController,
      obscureText: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(20.0),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        labelText: 'Password',
        labelStyle: TextStyle(
            color: Colors.grey, fontWeight: FontWeight.w600, fontSize: 14.0),
      ),
    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            
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
                       
                  if (_usernameController.text.isEmpty ||
                    _passwordController.text.isEmpty) {
                  // Show an error message.
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please enter a username and password.'),
                    ),
                  );
                } else {
                  // Check if the username and password are valid.
                  if (_usernameController.text == 'manas' &&
                      _passwordController.text == '55537766') {
                    // Login the user.
                    Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const home_design1(),
                ),
              );
                  } else {
                    // Show an error message.
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Invalid username or password.'),
                      ),
                    );
                  }
                }
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
                   Divider(
                      
                    ),
                    ElevatedButton(
                      onPressed: () {
                        
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(200, 50),
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
