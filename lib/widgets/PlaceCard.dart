import 'package:flutter/material.dart';

class PlaceCard extends StatelessWidget {
  final String name;
  final String image;
  final String price;
  final String location;

  const PlaceCard({
    Key? key,
    required this.name,
    required this.image,
    required this.price,
    required this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/detail');
      },
      child: Container(
        padding: const EdgeInsets.all(8.0), // Padding around the card
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300, width: 1), // Border with light grey color
          borderRadius: BorderRadius.circular(10), // Rounded border
          color: Colors.white, // Background color to make the card stand out
        ),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: Image.asset(
                    image,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF0D47A1), // Dark Blue
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  price,
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    const Icon(Icons.location_on, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        location,
                        style: const TextStyle(color: Colors.black54),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
