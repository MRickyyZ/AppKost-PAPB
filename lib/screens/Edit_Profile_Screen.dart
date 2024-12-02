import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();

  // Fungsi untuk mengambil token dari SharedPreferences
  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');
    if (token == null || token.isEmpty) {
      print("Token tidak ditemukan atau kosong");
    } else {
      print("Token ditemukan: $token");
    }
    return token ?? '';  // Mengembalikan token atau string kosong
  }

  @override
  void initState() {
    super.initState();
    _fetchProfile();
  }

  // Fungsi untuk mengambil data profile menggunakan GET request
  Future<void> _fetchProfile() async {
    var token = await getToken(); // Ambil token dari SharedPreferences
    if (token.isEmpty) {
      print('Token tidak ditemukan');
      return;
    }

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',  // Gunakan token untuk otentikasi
    };

    var response = await http.get(
      Uri.parse('http://192.168.1.2:3000/auth/profile'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      setState(() {
        nameController.text = data['name'] ?? '';
        aboutController.text = data['about'] ?? '';
      });
    } else {
      print('Gagal memuat profil: ${response.reasonPhrase}');
    }
  }

  // Fungsi untuk memperbarui profil menggunakan PUT request
  Future<void> _updateProfile() async {
    final token = await getToken(); // Ambil token dari SharedPreferences
    if (token.isEmpty) {
      print('Token kosong atau tidak ditemukan');
      return;
    }

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',  // Gunakan token untuk otentikasi
    };

    var body = json.encode({
      "name": nameController.text,
      "about": aboutController.text,
    });

    var response = await http.put(
      Uri.parse('http://192.168.1.2:3000/auth/profile'),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      print('Profil berhasil diperbarui');
      Navigator.pushReplacementNamed(context, '/profile'); // Kembali ke halaman profil
    } else {
      print('Gagal memperbarui profil: ${response.reasonPhrase}');
    }
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
                  labelText: 'Username',
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
                  onPressed: _updateProfile,
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
