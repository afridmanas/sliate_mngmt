import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sliate/screens/start/splash_screen.dart';
import 'color.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );

  runApp(
    const MyApp(),
  );

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: backround,
      systemNavigationBarColor: title_color,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SLIATE',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const Scaffold(body: splash_screen()),
    );
  }
}
