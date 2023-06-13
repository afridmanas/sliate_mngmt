import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sliate/screens/error_page.dart';
import 'package:sliate/screens/start/splash_screen.dart';
import 'color.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
    return ErrorPage(
      errorMessage: errorDetails.exceptionAsString(),
    );
  };

  runApp(
    const MyApp(),
  );

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: bg_clr,
      systemNavigationBarColor: widg_clr,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = GoogleFonts.mavenProTextTheme(
      Theme.of(context).textTheme,
    );

    final ThemeData theme = ThemeData(
      textTheme: textTheme,
      primarySwatch: Colors.grey,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SLIATE',
      theme: theme,
      home: const Scaffold(body: splash_screen()),
    );
  }
}
