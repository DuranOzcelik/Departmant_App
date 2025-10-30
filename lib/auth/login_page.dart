// lib/auth/login_page.dart

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'signup_page.dart';
import '../pages/main_page.dart';
import 'new_password_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;
  bool _isPasswordVisible = false;

  // Calculates dynamic margin for top-aligned SnackBar
  EdgeInsets get _topSnackBarMargin => EdgeInsets.only(
    bottom: MediaQuery.of(context).size.height - 150,
    left: 10,
    right: 10,
  );

  // Handles the Forgot Password flow and checks the username
  void _showForgotPasswordDialog() {
    final TextEditingController usernameResetController =
        TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Password Reset'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Please enter your Username to proceed to the password reset screen.',
              ),
              SizedBox(height: 10),
              TextField(
                controller: usernameResetController,
                decoration: InputDecoration(labelText: 'Username'),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            TextButton(
              child: Text('Reset'),
              onPressed: () async {
                final enteredUsername = usernameResetController.text;
                final prefs = await SharedPreferences.getInstance();
                final savedUsername = prefs.getString('username');
                final savedPassword = prefs.getString('password') ?? '';

                Navigator.of(dialogContext).pop();

                if (enteredUsername.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please enter a username.'),
                      behavior: SnackBarBehavior.floating,
                      margin: _topSnackBarMargin,
                    ),
                  );
                } else if (savedUsername == enteredUsername) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Username verified. Redirecting to password reset screen.',
                      ),
                      behavior: SnackBarBehavior.floating,
                      margin: _topSnackBarMargin,
                    ),
                  );
                  // Directs user to the New Password page, passing the old password for validation
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          NewPasswordPage(oldPassword: savedPassword),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error: Username not found.'),
                      behavior: SnackBarBehavior.floating,
                      margin: _topSnackBarMargin,
                    ),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  // Handles the main login process, including validation and navigation
  void _login() async {
    // 1. Empty field validation
    if (_usernameController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: Username and Password fields cannot be empty.'),
          behavior: SnackBarBehavior.floating,
          margin: _topSnackBarMargin,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    await Future.delayed(Duration(milliseconds: 500));

    final prefs = await SharedPreferences.getInstance();
    final savedUsername = prefs.getString('username');
    final savedPassword = prefs.getString('password');
    final enteredUsername = _usernameController.text;
    final enteredPassword = _passwordController.text;

    if (savedUsername == enteredUsername && savedPassword == enteredPassword) {
      // Successful login dialog
      showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: Text('Log In Successful!'),
            content: Text('You will be redirected to the Main Page!'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MainPage()),
                  );
                },
              ),
            ],
          );
        },
      );
    } else {
      // Failed login dialog
      showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: Text('Log In Failed!'),
            content: Text('Please try again!'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                },
              ),
            ],
          );
        },
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Department Application')),
      body: Container(
        color: Color(0xFFEFEFEF),
        alignment: Alignment.center,
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. Login Title
            Text(
              'Login',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),

            // 2. Username Field
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20),

            // 3. Password Field
            TextField(
              obscureText: !_isPasswordVisible,
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
            ),

            // Forgot Password Button
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: _showForgotPasswordDialog,
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(color: Colors.blue.shade700),
                ),
              ),
            ),
            SizedBox(height: 10),

            // 4. Log In Button
            ElevatedButton(
              onPressed: _isLoading ? null : _login,
              child: _isLoading
                  ? SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 3,
                      ),
                    )
                  : Text('Log In'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade800,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16),
                textStyle: TextStyle(fontSize: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 20),

            // 5. 'or' Divider
            Text(
              'or',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[700]),
            ),
            SizedBox(height: 20),

            // 6. Sign Up Button
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpPage()),
                );
              },
              child: Text('Sign Up', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
