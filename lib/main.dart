import 'package:covid/View/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Covid 19 Tracker App',
      theme: ThemeData(

        primarySwatch: Colors.grey,
        useMaterial3: true,
        brightness: Brightness.dark,


      ),
      home: const SplahScreen(),
    );
  }
}

