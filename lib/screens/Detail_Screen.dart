import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailScreen extends StatefulWidget {
  final int kostId; // Perbaiki nama parameter
  const DetailScreen({Key? key, required this.kostId}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}


class _DetailScreenState extends State<DetailScreen> {
  Map<String, dynamic>? kostDetail;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchKostDetail(); 
  }

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

  // Fungsi untuk fetch data kost detail
Future<void> fetchKostDetail() async {
  const String baseUrl = 'http://192.168.1.2:3000/kost/';
  final url = Uri.parse('$baseUrl${widget.kostId}'); // Gunakan kostId

  try {
    String token = await getToken();
    final headers = {
      'Authorization': 'Bearer $token',
    };

    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      setState(() {
        kostDetail = json.decode(response.body);
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load kost details');
    }
  } catch (e) {
    setState(() {
      isLoading = false;
    });
    print('Error fetching data: $e');
  }
}

  // Fungsi untuk membuka WhatsApp
  void _openWhatsApp(String phoneNumber) async {
    final Uri whatsappUrl = Uri.parse("https://wa.me/$phoneNumber");
    if (await canLaunchUrl(whatsappUrl)) {
      await launchUrl(whatsappUrl);
    } else {
      throw 'Tidak dapat membuka $whatsappUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Detail Kost'),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (kostDetail == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Detail Kost'),
        ),
        body: const Center(child: Text('Gagal memuat data')),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Detail'),
        backgroundColor: const Color(0xFF1A73E8),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Preview
            Center(
              child: Image.network(
                kostDetail!['image'] ?? '',
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
            ),
            const SizedBox(height: 16),

            // Nama Kost dan Fasilitas
            Text(
              kostDetail!['nama'] ?? 'Nama tidak tersedia',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.location_on, color: Color(0xFF90CAF9)),
                Text(
                  kostDetail!['lokasi'] ?? 'Lokasi tidak tersedia',
                  style: const TextStyle(fontSize: 18, color: Colors.blueGrey),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Deskripsi
            const Text(
              'Deskripsi',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              kostDetail!['deskripsi'] ?? 'Deskripsi tidak tersedia',
              style: const TextStyle(fontSize: 14, color: Colors.blueGrey),
            ),
            const SizedBox(height: 16),

            // Harga dan Pesan Sekarang
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Harga per Bulan',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'IDR ${kostDetail!['harga']}',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () =>
                      _openWhatsApp(kostDetail!['no_telp_pemilik']),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Pesan Sekarang',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
