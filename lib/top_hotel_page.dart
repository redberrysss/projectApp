import 'package:flutter/material.dart';
import 'booking_page.dart';
// Assuming FeaturedItem is defined in the same file or imported
class FeaturedItem {
  final String title;
  final String subtitle;
  final String imageUrl;

  FeaturedItem({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
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
      ),
      FeaturedItem(
        title: 'Hotel in $state 2',
        subtitle: 'Luxury stay in $state',
        imageUrl: 'https://picsum.photos/300/200?random=2',
      ),
      // Add more hotels as needed
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Top Hotels in $state'),
        backgroundColor: Colors.teal[700],
      ),
      body: ListView.builder(
        itemCount: hotels.length,
        itemBuilder: (context, index) {
          final hotel = hotels[index];
          return ListTile(
            title: Text(hotel.title),
            subtitle: Text(hotel.subtitle),
            leading: Image.network(hotel.imageUrl),
            onTap: () {
              // Navigate to booking page with hotel title
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => BookingPage(packageTitle: hotel.title),
                ),
              );
            },
          );
        },
      ),
    );
  }
}