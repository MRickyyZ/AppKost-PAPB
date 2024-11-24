import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');
    if (token == null || token.isEmpty) {
      print("Token not found or is empty");
    } else {
      print("Token found: $token");
    }
    return token ?? '';
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token'); // Hapus token dari SharedPreferences
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  Future<Map<String, dynamic>> fetchProfile() async {
    final token = await getToken(); // Ambil token dari shared_preferences
    if (token.isEmpty) {
      throw Exception('Token is empty or not found');
    }

    var headers = {
      'Authorization': 'Bearer $token', // Gunakan token yang sudah diambil
    };

    var request =
        http.Request('GET', Uri.parse('http://192.168.1.2:3000/auth/profile'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseData = await response.stream.bytesToString();
      return json.decode(responseData);
    } else {
      throw Exception('Failed to load profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A73E8),
        title: const Text('Profile'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future:
            fetchProfile(), // Memanggil fetchProfile untuk selalu mendapatkan data terbaru
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No Profile Data'));
          }

          final profile = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: profile['avatar'] != null
                        ? NetworkImage(profile['avatar'])
                        : const AssetImage('lib/assets/images/profil.png')
                            as ImageProvider,
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    profile['name'] ?? 'Name not available',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0D47A1),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    'Email: ${profile['email'] ?? 'Email not available'}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  profile['about'] ?? 'No about information available.',
                  style: const TextStyle(fontSize: 16, color: Colors.black54),
                ),
                const SizedBox(height: 40),
                const Divider(
                  color: Colors.black,
                  thickness: 1,
                ),
                ListTile(
                  leading: const Icon(Icons.edit, color: Color(0xFF1A73E8)),
                  title: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/editprofile');
                    },
                    child: const Text(
                      'Edit Profile',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A73E8),
                      ),
                    ),
                  ),
                ),
                const Divider(
                  color: Colors.black,
                  thickness: 1,
                ),
                ListTile(
                  leading: const Icon(Icons.lock,
                      color: Color(0xFF1A73E8)), // Lock Icon
                  title: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/changepassword');
                    },
                    child: const Text(
                      'Change Password',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A73E8),
                      ),
                    ),
                  ),
                ),
                const Divider(
                  color: Colors.black,
                  thickness: 1,
                ),
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.red),
                  title: InkWell(
                    onTap: () async {
                      await logout(); // Hapus token dan navigasi ulang
                    },
                    child: const Text(
                      'Logout',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
                const Divider(
                  color: Colors.black,
                  thickness: 1,
                ),
                const Spacer(),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: const Color(0xFF0D47A1), // Dark Blue
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/home');
          }
        },
      ),
    );
  }
}
