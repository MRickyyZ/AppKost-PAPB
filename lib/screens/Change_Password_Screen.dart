import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _isOldPasswordVisible = false;
  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A73E8),
        title: const Text('Change Password'),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 20,
          
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/profile'); 
          },
        ),
      ),
      // Memungkinkan tampilan menyesuaikan saat keyboard muncul
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            const SizedBox(height: 40),
            
            // Old Password Field
            TextField(
              controller: _oldPasswordController,
              obscureText: !_isOldPasswordVisible,
              decoration: InputDecoration(
                labelText: 'Old Password',
                prefixIcon: const Icon(Icons.lock), // Icon lock
                suffixIcon: IconButton(
                  icon: Icon(
                    _isOldPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isOldPasswordVisible = !_isOldPasswordVisible;
                    });
                  },
                ),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // New Password Field
            TextField(
              controller: _newPasswordController,
              obscureText: !_isNewPasswordVisible,
              decoration: InputDecoration(
                labelText: 'New Password',
                prefixIcon: const Icon(Icons.lock), // Icon lock
                suffixIcon: IconButton(
                  icon: Icon(
                    _isNewPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isNewPasswordVisible = !_isNewPasswordVisible;
                    });
                  },
                ),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Confirm New Password Field
            TextField(
              controller: _confirmPasswordController,
              obscureText: !_isConfirmPasswordVisible,
              decoration: InputDecoration(
                labelText: 'Confirm New Password',
                prefixIcon: const Icon(Icons.lock), // Icon lock
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
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 100),

            Center(
              child: ElevatedButton(
                onPressed: () {
                    Navigator.pop(context); // Kembali ke halaman profile
                  },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1A73E8),
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: const Text(
                  'Update Password',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
