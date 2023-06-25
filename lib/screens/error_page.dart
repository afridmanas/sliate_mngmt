import 'package:flutter/material.dart';

class ErrorHandling {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Error'),
          ),
          body: const Center(
            child: Text('An error occurred. Please try again.'),
          ),
        );
      },
    );
  }

  static void navigateToErrorScreen() {
    navigatorKey.currentState?.pushNamed('/error');
  }
}
