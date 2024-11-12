import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

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
              'Create Account',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1A73E8),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Create an account so you can explore all the existing jobs',
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
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: confirmPasswordController,
              obscureText: !_isConfirmPasswordVisible,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                prefixIcon:
                    const Icon(Icons.lock), // Icon untuk konfirmasi password
                suffixIcon: IconButton(
                  icon: Icon(
                    _isConfirmPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                    });
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Handle sign-up logic
                print('Email: ${emailController.text}');
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: const Color(0xFF1A73E8), // Warna tombol diubah
              ),
              child: const Text(
                'Sign up',
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
                Navigator.pushNamed(
                    context, '/login'); // Navigate to Login Screen
              },
              child: const Text(
                'Already have an account',
                style: TextStyle(
                  color: Color(0xFF1A73E8),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
