import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sliate/color.dart';

class UserDetailsPage extends StatefulWidget {
  @override
  _UserDetailsPageState createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  int _currentStep = 0;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _submitForm(String name, String email, String phoneNumber) async {
    try {
      await FirebaseFirestore.instance.collection('users').add({
        'name': name,
        'email': email,
        'phone_number': phoneNumber,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User details saved successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to save user details')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Step> _steps = [
      Step(
        title: const Text('Full Name'),
        content: TextFormField(
          decoration: const InputDecoration(labelText: 'Enter your name'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your name';
            }
            return null;
          },
          onSaved: (value) {
            final name = value ?? '';
            _submitForm(name, '', '');
          },
        ),
        isActive: _currentStep >= 0,
        state: _currentStep > 0 ? StepState.complete : StepState.disabled,
      ),
      Step(
        title: const Text('Email'),
        content: TextFormField(
          decoration: const InputDecoration(labelText: 'Enter your email'),
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your email';
            }
            return null;
          },
          onSaved: (value) {
            final email = value ?? '';
            _submitForm('', email, '');
          },
        ),
        isActive: _currentStep >= 1,
        state: _currentStep > 1 ? StepState.complete : StepState.disabled,
      ),
      Step(
        title: const Text('Registration Number'),
        content: TextFormField(
          decoration: const InputDecoration(
              labelText: 'Enter your registration number'),
          keyboardType: TextInputType.phone,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your registration number';
            }
            return null;
          },
          onSaved: (value) {
            final phoneNumber = value ?? '';
            _submitForm('', '', phoneNumber);
          },
        ),
        isActive: _currentStep >= 2,
        state: _currentStep > 2 ? StepState.complete : StepState.disabled,
      ),
      Step(
        title: const Text('Department'),
        content: TextFormField(
          decoration: const InputDecoration(labelText: 'Enter your Department'),
          keyboardType: TextInputType.phone,
        ),
        isActive: _currentStep >= 3,
        state: _currentStep > 3 ? StepState.complete : StepState.disabled,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: bg_clr,
      ),
      body: Container(
        color: bg_clr,
        padding: const EdgeInsets.only(left: 16.0, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 15),
                            height: 75,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child:
                                  Image.asset('assets/images/logo/manas.jpg'),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Edit Photo',
                            style: GoogleFonts.mavenPro(
                              textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: .5),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      textAlign: TextAlign.left,
                      softWrap: true,
                      'This is Onboarding section, \nYou can onboard new leads and clients to \nyour account',
                    ),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: widg_clr,
                  ),
                  padding: const EdgeInsets.only(
                    left: 15.0,
                    right: 15,
                    top: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 25.0,
                          right: 15,
                          top: 5,
                        ),
                        child: Center(
                          child: Text(
                            'User Information',
                            style: GoogleFonts.mavenPro(
                              textStyle: TextStyle(
                                  color: text_clr,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: .5),
                            ),
                          ),
                        ),
                      ),
                      Stepper(
                        controlsBuilder: (context, details) {
                          return Container();
                        },
                        currentStep: _currentStep,
                        onStepTapped: (step) {
                          setState(
                            () {
                              _currentStep = step;
                            },
                          );
                        },
                        steps: _steps,
                      ),
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 15.0,
                          right: 15,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (_currentStep > 0)
                              TextButton(
                                onPressed: () {
                                  setState(
                                    () {
                                      if (_currentStep > 0) {
                                        _currentStep--;
                                      }
                                    },
                                  );
                                },
                                style: ButtonStyle(
                                  textStyle:
                                      MaterialStateProperty.all<TextStyle>(
                                    const TextStyle(fontSize: 16),
                                  ),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                    Colors.grey,
                                  ),
                                  // Customize other properties like background color, padding, etc. here
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.arrow_back_ios,
                                      size: 15,
                                      color: Colors.black,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Back',
                                      style: GoogleFonts.mavenPro(
                                        textStyle: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: .5),
                                      ),
                                    ), // Label text
                                    // Icon
                                  ],
                                ),
                              ),
                            TextButton(
                              onPressed: () {
                                setState(
                                  () {
                                    if (_currentStep < _steps.length - 1) {
                                      _currentStep++;
                                    } else {
                                      _formKey.currentState?.save();
                                    }
                                  },
                                );
                              },
                              style: ButtonStyle(
                                textStyle: MaterialStateProperty.all<TextStyle>(
                                  const TextStyle(fontSize: 16),
                                ),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                  Colors.grey,
                                ),
                                // Customize other properties like background color, padding, etc. here
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    _currentStep == _steps.length - 1
                                        ? 'Submit'
                                        : 'Next',
                                    style: GoogleFonts.mavenPro(
                                      textStyle: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: .5),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ), // Label text
                                  const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 15,
                                    color: Colors.black,
                                  ), // Icon
                                ],
                              ),
                            ),

                            // ElevatedButton(
                            //   onPressed: () {
                            //     setState(() {
                            //       if (_currentStep < _steps.length - 1) {
                            //         _currentStep++;
                            //       } else {
                            //         _formKey.currentState?.save();
                            //       }
                            //     });
                            //   },
                            //   child: Text(
                            //     _currentStep == _steps.length - 1
                            //         ? 'Submit'
                            //         : 'Next',
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
