import 'dart:convert'; // Untuk JSON decoding
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Library HTTP
import 'package:appkost/widgets/PlaceCard.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedGender = 'Semua';
  String _searchQuery = '';
  List<Map<String, dynamic>> placeData = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPlaces(); // Fetch data saat halaman dimuat
  }

  Future<void> fetchPlaces() async {
    final url = Uri.parse('http://192.168.1.2:3000/kost');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        setState(() {
          placeData = jsonData
              .map((item) => {
                    'id': item['id'], // Tambahkan ID di sini
                    'name': item['nama'],
                    'gender': item['gender'] == 'male' ? 'Cowok' : 'Cewek',
                    'image': item['image'],
                    'price': 'Rp ${item['harga']}',
                    'location': item['lokasi'],
                  })
              .toList();
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e);
    }
  }

  List<Map<String, dynamic>> getFilteredPlaces() {
    List<Map<String, dynamic>> filteredList = placeData;

    if (selectedGender != 'Semua') {
      filteredList = filteredList
          .where((place) => place['gender'] == selectedGender)
          .toList();
    }

    if (_searchQuery.isNotEmpty) {
      filteredList = filteredList
          .where((place) =>
              place['name']!.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    }

    return filteredList;
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: const Color(0xFF1A73E8),
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: const Text(
        'Home'
      ),
      titleTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
    ),
    body: isLoading
        ? const Center(child: CircularProgressIndicator()) // Loading spinner
        : SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // UI untuk lokasi, search, filter
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        hintText: "Cari Kost",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Filter Dropdown and Places Label
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Places",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0D47A1),
                          ),
                        ),
                        DropdownButton<String>(
                          value: selectedGender,
                          icon: const Icon(Icons.arrow_downward),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedGender = newValue!;
                            });
                          },
                          items: <String>['Semua', 'Cowok', 'Cewek']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio:
                            0.75, // Ubah nilai ini jika card terlalu tinggi atau lebar
                      ),
                      itemCount: getFilteredPlaces().length,
                      itemBuilder: (context, index) {
                        final place = getFilteredPlaces()[index];
                        return PlaceCard(
                          name: place['name'],
                          image: place['image'],
                          price: place['price'],
                          location: place['location'],
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/detail',
                              arguments: {
                                'kostId': place['id']
                              }, // Pastikan place['id'] adalah int
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
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
        selectedItemColor: const Color(0xFF0D47A1),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 1) {
            Navigator.pushNamed(context, '/profile');
          }
        },
      ),
    );
  }
}
