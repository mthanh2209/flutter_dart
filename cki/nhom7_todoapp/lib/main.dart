import 'package:flutter/material.dart';
import 'package:nhom7_todoapp/pages/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
       useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: const SplashPage(),
    );
  }
}

