import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Login here',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A73E8),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Welcome back you’ve been missed!',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 40),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: const Icon(Icons.email), // Icon untuk email
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: passwordController,
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: const Icon(Icons.lock), // Icon untuk password
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 10),
            // TextButton(
            //   onPressed: () {
            //     // Handle forgot password
            //   },
            //   // child: const Text(
            //   //   'Forgot your password?',
            //   //   style: TextStyle(
            //   //     color: Color(0xFF1A73E8),
            //   //     fontWeight: FontWeight.bold,
            //   //   ),
            //   ),
            // ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // Handle login logic
                Navigator.pushNamed(context, '/home');
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: const Color(0xFF1A73E8), // Warna tombol diubah
              ),
              child: const Text(
                'Sign in',
                style: TextStyle(
                  color: Colors.white, // Teks tombol menjadi putih
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                // Navigate to Sign-Up Screen
                Navigator.pushNamed(context, '/signup'); // Menambahkan navigasi ke /signup
              },
              child: const Text(
                'Create new account',
                style: TextStyle(color: Color(0xFF1A73E8)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
