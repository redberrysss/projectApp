import 'package:flutter/material.dart';
import 'booking_page.dart';

class FeaturedItem {
  final String title;
  final String subtitle;
  final String imageUrl;
  final double price;

  FeaturedItem({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.price,
  });
}

class TopHotelsPage extends StatelessWidget {
  final String state;

  const TopHotelsPage({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sample data for hotels
    final List<FeaturedItem> hotels = [
      FeaturedItem(
        title: 'Hotel in $state 1',
        subtitle: 'Best hotel in $state',
        imageUrl: 'https://picsum.photos/300/200?random=1',
        price: 120.0,
      ),
      FeaturedItem(
        title: 'Hotel in $state 2',
        subtitle: 'Luxury stay in $state',
        imageUrl: 'https://picsum.photos/300/200?random=2',
        price: 150.0,
      ),
      // Add more hotels as needed
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Top Hotels in $state'),
        backgroundColor: Colors.teal[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: hotels.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 4,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemBuilder: (context, index) {
            final hotel = hotels[index];
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => BookingPage(packageTitle: hotel.title, price: hotel.price),
                  ),
                );
              },
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                        child: Image.network(
                          hotel.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        hotel.title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        hotel.subtitle,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
