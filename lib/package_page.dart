  import 'package:flutter/material.dart';
  import 'home_page.dart';

  // Hotel model class
  class Hotel {
    final String name;
    final double price;
    final double rating;
    final String imageUrl;

    Hotel({
      required this.name,
      required this.price,
      required this.rating,
      required this.imageUrl,
    });
  }

  class PackagePage extends StatelessWidget {
    final String packageTitle;

    const PackagePage({Key? key, required this.packageTitle}) : super(key: key);

    @override
    Widget build(BuildContext context) {
      // Sample list of available hotels for the package
      final List<Hotel> availableHotels = [
        Hotel(
          name: 'Ocean View Hotel',
          price: 150,
          rating: 4.5,
          imageUrl: 'https://picsum.photos/300/200?random=1',
        ),
        Hotel(
          name: 'Beachside Resort',
          price: 200,
          rating: 4.7,
          imageUrl: 'https://picsum.photos/300/200?random=2',
        ),
        Hotel(
          name: 'Beachside Resort',
          price: 200,
          rating: 4.7,
          imageUrl: 'https://picsum.photos/300/200?random=2',
        ),
        Hotel(
          name: 'Beachside Resort',
          price: 200,
          rating: 4.7,
          imageUrl: 'https://picsum.photos/300/200?random=2',
        ),
        Hotel(
          name: 'Beachside Resort',
          price: 200,
          rating: 4.7,
          imageUrl: 'https://picsum.photos/300/200?random=2',
        ),
        Hotel(
          name: 'Beachside Resort',
          price: 200,
          rating: 4.7,
          imageUrl: 'https://picsum.photos/300/200?random=2',
        ),
        Hotel(
          name: 'Beachside Resort',
          price: 200,
          rating: 4.7,
          imageUrl: 'https://picsum.photos/300/200?random=2',
        ),
        Hotel(
          name: 'Luxury Suites',
          price: 250,
          rating: 4.9,
          imageUrl: 'https://picsum.photos/300/200?random=3',
        ),
        // Add more hotels as needed
      ];

      return Scaffold(
        appBar: AppBar(
          title: Text(packageTitle),
          backgroundColor: Colors.teal[700],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Two columns
              childAspectRatio: 0.75, // Aspect ratio for the cards
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: availableHotels.length,
            itemBuilder: (context, index) {
              final hotel = availableHotels[index];
              return _buildHotelCard(hotel, context);
            },
          ),
        ),
      );
    }

    Widget _buildHotelCard(Hotel hotel, BuildContext context) {
      return Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                hotel.imageUrl,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: const Center(
                      child: Icon(Icons.broken_image, size: 48, color: Colors.grey),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hotel.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        hotel.rating.toString(),
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${hotel.price} per night',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.teal,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      // Handle booking action
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Booking ${hotel.name}')),
                      );
                    },
                    child: const Text('Book Now'),
                    style: ElevatedButton.styleFrom(
                      
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }