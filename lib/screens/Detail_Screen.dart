import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailScreen extends StatefulWidget {
  final int kostId;
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
    return token ?? '';
  }

  Future<void> fetchKostDetail() async {
    const String baseUrl = 'http://192.168.1.2:3000/kost/';
    final url = Uri.parse('$baseUrl${widget.kostId}');

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
            Navigator.pushReplacementNamed(context, '/home');
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Utama
            Center(
              child: Image.network(
                kostDetail!['image'] ?? '',
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
            ),
            const SizedBox(height: 16),

            // Nama Kost dan Lokasi (Dijadikan 1 baris dalam Row)
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    // Kolom Kiri: Nama Kost
    Expanded(
      flex: 2, // Proporsi ukuran kolom
      child: Text(
        kostDetail!['nama'] ?? 'Nama tidak tersedia',
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    ),
    const SizedBox(width: 16), // Spasi antar kolom

    // Kolom Kanan: Lokasi
    Expanded(
      flex: 1, // Proporsi ukuran kolom
      child: Row(
        children: [
          const Icon(Icons.location_on, color: Color.fromARGB(255, 102, 184, 251)),
          Expanded(
            child: Text(
              kostDetail!['lokasi'] ?? 'Lokasi tidak tersedia',
              style: const TextStyle(fontSize: 16, color: Colors.blueGrey),
              maxLines: 2, // Batasi menjadi 2 baris jika teks panjang
              overflow: TextOverflow.ellipsis, // Tambahkan "..." jika teks panjang
            ),
          ),
        ],
      ),
    ),
  ],
),
const SizedBox(height: 18),
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

            // Gambar Pratinjau Kamar
            const Text(
              'Preview Kamar',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Image.network(
                kostDetail!['image_preview'] ?? '',
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
      bottomNavigationBar: Container(
  decoration: const BoxDecoration(
    border: Border(
      top: BorderSide(
        color: Colors.grey, // Warna border atas
        width: 1.0,        // Ketebalan border
      ),
    ),
  ),
  child: BottomAppBar(
    color: Colors.white,
    elevation: 8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Harga per Bulan',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'IDR ${kostDetail!['harga']}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                    height: 1.2, // Menambah spasi antar teks
                    textBaseline:
                        TextBaseline.alphabetic, // Memastikan baseline teks
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () => _openWhatsApp(kostDetail!['no_telp_pemilik']),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
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
      ),
      ),
    );
  }
}
