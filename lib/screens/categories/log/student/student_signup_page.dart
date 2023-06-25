import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sliate/color.dart';

// ignore: camel_case_types
class student_signup extends StatefulWidget {
  const student_signup({super.key});

  @override
  State<student_signup> createState() => _student_signupState();
}

enum Department {
  HNDA,
  HNDIT,
  HNDE,
}

class _student_signupState extends State<student_signup> {
  Department? selectedDepartment;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _regnumberController = TextEditingController();
  final _fullNameController = TextEditingController();

  String? departmentToString(Department? department) {
    switch (department) {
      case Department.HNDA:
        return 'HNDA';
      case Department.HNDIT:
        return 'HNDIT';
      case Department.HNDE:
        return 'HNDE';
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double keyboardHeight = (MediaQuery.of(context).viewInsets.bottom) - 50;
    return Scaffold(
      backgroundColor:
          Colors.white, // Replace with your desired background color
      body: SizedBox(
        height: height - keyboardHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(
                top: 50,
                bottom: 30,
              ),
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
            // SizedBox(
            //   height: 30,
            // ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
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
                        DropdownButtonFormField<Department>(
                          value: selectedDepartment,
                          validator: (value) {
                            if (value == null) {
                              return 'Department is required';
                            }
                            return null;
                          },
                          onChanged: (Department? department) {
                            setState(() {
                              selectedDepartment = department;
                            });
                          },
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(15.0),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            labelText: 'Select Department',
                            labelStyle: TextStyle(
                                color: Colors
                                    .black, // Replace with your desired text color
                                fontWeight: FontWeight.w600,
                                fontSize: 14.0),
                          ),
                          items: Department.values.map((Department department) {
                            return DropdownMenuItem<Department>(
                              value: department,
                              child: Text(departmentToString(department)!),
                            );
                          }).toList(),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // Perform signup logic here
                              String fullName = _fullNameController.text;
                              String email = _emailController.text;
                              String password = _passwordController.text;
                              String regNumber = _regnumberController.text;
                              String department =
                                  departmentToString(selectedDepartment)!;

                              // Save user data to Firestore or perform desired operations

                              // Example: Saving to Firestore
                              FirebaseFirestore.instance
                                  .collection('users')
                                  .add({
                                'fullName': fullName,
                                'email': email,
                                'password': password,
                                'regNumber': regNumber,
                                'department': department,
                              });

                              // Show success message or navigate to the next screen
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Signup Successful')),
                              );

                              // Clear form fields
                              _fullNameController.clear();
                              _emailController.clear();
                              _passwordController.clear();
                              _regnumberController.clear();
                              setState(() {
                                selectedDepartment = null;
                              });
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
