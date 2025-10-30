import 'package:flutter/material.dart';
import 'auth/login_page.dart';

// The entry point of the application
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Department Application',
      theme: ThemeData(
        // Use blue as the primary theme color
        primarySwatch: Colors.blue,
        // Set AppBar theme to dark blue
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF1A478C),
          foregroundColor: Colors.white,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
