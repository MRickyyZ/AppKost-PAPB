import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A73E8), // Primary Blue
        automaticallyImplyLeading: false,
        title: const Text('Profile'),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
            const Center(
              child: Text(
                'Muhammad Ricky Zakaria',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D47A1), // Dark Blue
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Center(
              child: Text(
                'Email: 11211062@gmail.com', // Ganti dengan data pengguna
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Ini adalah bagian tentang saya. Anda dapat menambahkan informasi singkat tentang pengguna di sini.',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 40),

            // Divider di atas setiap item
            const Divider(
              color: Colors.black,
              thickness: 1,
            ),
            ListTile(
              leading: const Icon(Icons.edit, color: Color(0xFF1A73E8)), // Ikon Edit Profile
              title: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/editprofile');
                },
                child: const Text(
                  'Edit Profile',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A73E8), // Primary Blue
                  ),
                ),
              ),
            ),
            const Divider(
              color: Colors.black,
              thickness: 1,
            ),
            ListTile(
              leading: const Icon(Icons.lock, color: Color(0xFF1A73E8)), // Ikon Change Password
              title: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/changepassword');
                },
                child: const Text(
                  'Change Password',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A73E8), // Primary Blue
                  ),
                ),
              ),
            ),
            const Divider(
              color: Colors.black,
              thickness: 1,
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red), // Ikon Logout
              title: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/login');
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
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1, // Menandakan ikon Profile sebagai yang aktif (index 1)
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
            Navigator.pushNamed(context, '/home'); // Navigasi ke halaman Home
          }
        },
      ),
    );
  }
}
