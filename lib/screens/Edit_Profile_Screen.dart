import 'package:flutter/material.dart';

class EditProfileScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();

  EditProfileScreen() {
    // Placeholder data pengguna yang bisa diisi sesuai kebutuhan
    nameController.text = 'Muhammad Ricky Zakaria';
    emailController.text = '11211062@gmail.com';
    aboutController.text = 'Ini adalah bagian tentang saya. Anda dapat menambahkan informasi singkat tentang pengguna di sini.';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A73E8), // Primary Blue
        automaticallyImplyLeading: false,
        title: const Text('Edit Profile'),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/profile');
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('lib/assets/images/profil.png'),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama',
                  labelStyle: TextStyle(color: Color(0xFF0D47A1)), // Dark Blue
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF1A73E8)), // Primary Blue
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Color(0xFF0D47A1)), // Dark Blue
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF1A73E8)), // Primary Blue
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: aboutController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Tentang Saya',
                  labelStyle: TextStyle(color: Color(0xFF0D47A1)), // Dark Blue
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF1A73E8)), // Primary Blue
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Tambahkan logika untuk menyimpan perubahan profil
                    Navigator.pop(context); // Kembali ke halaman profile
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A73E8), // Primary Blue
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                  child: const Text(
                    'Simpan Perubahan',
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
      ),
    );
  }
}
