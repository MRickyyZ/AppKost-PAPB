import 'package:flutter/material.dart';
import 'package:appkost/widgets/PlaceCard.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedGender = 'Semua';
  String _searchQuery = '';

  final List<Map<String, String>> placeData = [
    {
      'name': 'Kost Melati',
      'gender': 'Cewek',
      'image': 'lib/assets/images/kost.png',
      'price': 'Rp 900.000 / bulan',
      'location': 'Jl. Mawar, Balikpapan'
    },
    {
      'name': 'Kost Bunga',
      'gender': 'Cowok',
      'image': 'lib/assets/images/kost.png',
      'price': 'Rp 1.200.000 / bulan',
      'location': 'Jl. Kenanga, Balikpapan'
    },
    {
      'name': 'Kost Mawar',
      'gender': 'Cewek',
      'image': 'lib/assets/images/kost.png',
      'price': 'Rp 1.000.000 / bulan',
      'location': 'Jl. Melati, Balikpapan'
    },
    {
      'name': 'Kost Anggrek',
      'gender': 'Cowok',
      'image': 'lib/assets/images/kost.png',
      'price': 'Rp 950.000 / bulan',
      'location': 'Jl. Anggrek, Balikpapan'
    },
  ];

  List<Map<String, String>> getFilteredPlaces() {
    List<Map<String, String>> filteredList = placeData;

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
        title: const Text('Home'),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Location
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Location",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0D47A1),
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.location_on, color: Color(0xFF90CAF9)),
                          Text(
                            "Balikpapan, Indonesia",
                            style: TextStyle(color: Colors.black54),
                          ),
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Image.asset(
                      'lib/assets/images/profil.png',
                      width: 40,
                      height: 40,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/profile');
                    },
                  ),
                ],
              ),

              const SizedBox(height: 20),
              // Search Bar
              TextField(
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search,
                      color: Color(0xFF0D47A1)), // Dark Blue
                  hintText: "Search House",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(
                        color: Color(0xFF1A73E8)), // Primary Blue
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
              // Display places in a grid
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.8,
                ),
                itemCount: getFilteredPlaces().length,
                itemBuilder: (context, index) {
                  final place = getFilteredPlaces()[index];
                  return PlaceCard(
                    name: place['name']!,
                    image: place['image']!,
                    price: place['price']!, // Menambahkan harga
                    location: place['location']!, // Menambahkan lokasi
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
