import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailScreen extends StatefulWidget {
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  // URL WhatsApp untuk pemesanan
  final Uri whatsappUrl = Uri.parse("https://wa.me/6282210147838");

  // Metode untuk membuka WhatsApp
  void _openWhatsApp() async {
    if (await canLaunchUrl(whatsappUrl)) {
      await launchUrl(whatsappUrl);
    } else {
      throw 'Tidak dapat membuka $whatsappUrl';
    }
  }

  // Daftar gambar preview kamar dan fasilitas
  final List<String> imageUrls = [
    'lib/assets/images/kamar.jpg',
    'lib/assets/images/kamarMandi.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Detail'),
        backgroundColor: const Color(0xFF1A73E8),
        foregroundColor: Colors.white,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
        elevation: 0,
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
            Center(
              child: Image.asset(
                'lib/assets/images/kost.png',
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Kost Melati',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.wifi, color: Colors.blue),
                    SizedBox(width: 8),
                    SizedBox(width: 16), // Jarak antara fasilitas
                    Icon(Icons.local_parking, color: Colors.blue),
                    SizedBox(width: 8),
                    SizedBox(width: 16), // Jarak antara fasilitas
                    Icon(Icons.kitchen, color: Colors.blue),
                    SizedBox(width: 8),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.location_on, color: Color(0xFF90CAF9)),
                Text(
                  'Km.15 Sei Wain',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.blueGrey,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),
            const Text(
              'Deskripsi',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Kost Melati terletak di Km.15 Sei Wain dan menawarkan kamar yang terjangkau, bersih, dengan fasilitas modern. '
              'Ideal untuk mahasiswa atau pekerja yang mencari tempat tinggal nyaman.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.blueGrey,
              ),
            ),
            const SizedBox(height: 1),
            TextButton(
              onPressed: () {
                // Aksi untuk "Baca Selengkapnya"
              },
              child: const Text(
                'Baca Selengkapnya',
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Section preview gambar
            const Text(
              'Preview',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            GridView.builder(
              shrinkWrap: true, // Agar grid tidak memenuhi seluruh layar
              physics: const NeverScrollableScrollPhysics(),
              itemCount: imageUrls.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 kolom
                crossAxisSpacing: 8, // Jarak antar kolom
                mainAxisSpacing: 8, // Jarak antar baris
              ),
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(12), // Rounded corners
                  child: Image.asset(
                    imageUrls[index],
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            const Divider(
              color: Colors.black,
              thickness: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Harga per Bulan',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'IDR 900.000',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: _openWhatsApp, // Mengarahkan ke WhatsApp
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
