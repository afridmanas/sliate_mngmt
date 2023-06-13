import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  final String errorMessage;

  ErrorPage({required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Error'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Text(
            errorMessage,
            style: TextStyle(fontSize: 18.0),
          ),
        ),
      ),
    );
  }
}
