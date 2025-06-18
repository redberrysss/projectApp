
import 'package:flutter/material.dart';
import 'booking_page.dart';

class LocationHotelsPage extends StatelessWidget {
  final String location;

  LocationHotelsPage({Key? key, required this.location}) : super(key: key);

  final Map<String, List<Map<String, dynamic>>> hotelsByLocation = {
    "Seksyen 19, Shah Alam": [
      {
        "name": "Sunway Pyramid Hotel",
        "price": 183.62,
        "image": "https://picsum.photos/300/200?random=201",
        "rating": 8.4,
        "location": "Bandar Sunway, Kuala Lumpur",
        "distance": "12.1 km to center",
        "tags": ["ONLY 1 LEFT", "MEGA SALE", "FREE CANCELLATION"],
        "tagColors": [Colors.red.shade300, Colors.red.shade600, Colors.green.shade300],
      },
      {
        "name": "Sleeping Lion Suites",
        "price": 148.75,
        "image": "https://picsum.photos/300/200?random=202",
        "rating": 9.0,
        "location": "Bukit Bintang, Kuala Lumpur",
        "distance": "City center",
        "tags": ["FREE CANCELLATION"],
        "tagColors": [Colors.green.shade300],
      },
      {
        "name": "Cititel Mid Valley Hotel",
        "price": 147.06,
        "image": "https://picsum.photos/300/200?random=203",
        "rating": 8.2,
        "location": "Mid Valley / Bangsar, Kuala Lumpur",
        "distance": "3.1 km to center",
        "tags": ["Domestic Deal", "ONLY 1 LEFT"],
        "tagColors": [Colors.pink.shade200, Colors.red.shade300],
      },
      {
        "name": "The Majestic Hotel",
        "price": 202.02,
        "image": "https://picsum.photos/300/200?random=204",
        "rating": 8.6,
        "location": "Jalan Sultan Hishamuddin, Kuala Lumpur",
        "distance": "City center",
        "tags": ["FREE CANCELLATION"],
        "tagColors": [Colors.green.shade300],
      },
      {
        "name": "Traders Hotel Kuala Lumpur",
        "price": 310.87,
        "image": "https://picsum.photos/300/200?random=205",
        "rating": 8.3,
        "location": "Kuala Lumpur City Centre",
        "distance": "City center",
        "tags": ["Domestic Deal"],
        "tagColors": [Colors.pink.shade200],
      },
      {
        "name": "Grand Palace Hotel",
        "price": 220.50,
        "image": "https://picsum.photos/300/200?random=206",
        "rating": 8.7,
        "location": "Bukit Bintang, Kuala Lumpur",
        "distance": "2.5 km to center",
        "tags": ["MEGA SALE", "FREE CANCELLATION"],
        "tagColors": [Colors.red.shade600, Colors.green.shade300],
      },
      {
        "name": "City Central Hotel",
        "price": 175.00,
        "image": "https://picsum.photos/300/200?random=207",
        "rating": 8.1,
        "location": "Kuala Lumpur City Centre",
        "distance": "1.8 km to center",
        "tags": ["ONLY 2 LEFT"],
        "tagColors": [Colors.red.shade300],
      },
      {
        "name": "Royal Garden Suites",
        "price": 195.75,
        "image": "https://picsum.photos/300/200?random=208",
        "rating": 8.9,
        "location": "Chow Kit, Kuala Lumpur",
        "distance": "3.0 km to center",
        "tags": ["FREE CANCELLATION"],
        "tagColors": [Colors.green.shade300],
      },
      {
        "name": "Sunset Boulevard Hotel",
        "price": 160.40,
        "image": "https://picsum.photos/300/200?random=209",
        "rating": 8.0,
        "location": "Ampang, Kuala Lumpur",
        "distance": "4.2 km to center",
        "tags": ["Domestic Deal"],
        "tagColors": [Colors.pink.shade200],
      },
      {
        "name": "Lakeview Resort",
        "price": 210.00,
        "image": "https://picsum.photos/300/200?random=210",
        "rating": 8.5,
        "location": "Titiwangsa, Kuala Lumpur",
        "distance": "5.0 km to center",
        "tags": ["MEGA SALE", "FREE CANCELLATION"],
        "tagColors": [Colors.red.shade600, Colors.green.shade300],
      },
      {
        "name": "The Orchid Hotel",
        "price": 190.00,
        "image": "https://picsum.photos/300/200?random=211",
        "rating": 8.3,
        "location": "Chow Kit, Kuala Lumpur",
        "distance": "3.5 km to center",
        "tags": ["ONLY 3 LEFT", "FREE CANCELLATION"],
        "tagColors": [Colors.red.shade300, Colors.green.shade300],
      },
      {
        "name": "Harbor View Inn",
        "price": 175.50,
        "image": "https://picsum.photos/300/200?random=212",
        "rating": 8.0,
        "location": "Kuala Lumpur City Centre",
        "distance": "2.0 km to center",
        "tags": ["Domestic Deal"],
        "tagColors": [Colors.pink.shade200],
      },
      {
        "name": "City Lights Hotel",
        "price": 165.75,
        "image": "https://picsum.photos/300/200?random=213",
        "rating": 8.1,
        "location": "Bukit Bintang, Kuala Lumpur",
        "distance": "1.5 km to center",
        "tags": ["MEGA SALE"],
        "tagColors": [Colors.red.shade600],
      },
      {
        "name": "Garden Plaza Suites",
        "price": 185.00,
        "image": "https://picsum.photos/300/200?random=214",
        "rating": 8.7,
        "location": "Ampang, Kuala Lumpur",
        "distance": "4.0 km to center",
        "tags": ["FREE CANCELLATION"],
        "tagColors": [Colors.green.shade300],
      },
      {
        "name": "Sunrise Hotel",
        "price": 172.25,
        "image": "https://picsum.photos/300/200?random=215",
        "rating": 8.4,
        "location": "Titiwangsa, Kuala Lumpur",
        "distance": "5.5 km to center",
        "tags": ["ONLY 1 LEFT"],
        "tagColors": [Colors.red.shade300],
      },
    ],

    // Add more locations and hotels as needed
  };

  @override
  Widget build(BuildContext context) {
    final hotels = hotelsByLocation[location] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text('Hotels in $location'),
        backgroundColor: Colors.teal[700],
      ),
      body: hotels.isEmpty
          ? Center(child: Text('No hotels found for $location'))
          : ListView.builder(
              itemCount: hotels.length,
              itemBuilder: (context, index) {
                final hotel = hotels[index];
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          hotel['image'],
                          width: 100,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              hotel['name'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(Icons.star, color: Colors.orange, size: 16),
                                const SizedBox(width: 4),
                                Text(
                                  hotel['rating'].toString(),
                                  style: const TextStyle(fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    '${hotel['location']} - ${hotel['distance']}',
                                    style: TextStyle(
                                      color: Colors.blue.shade700,
                                      fontSize: 12,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: List.generate(hotel['tags'].length, (tagIndex) {
                                return Container(
                                  margin: const EdgeInsets.only(right: 6),
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: hotel['tagColors'][tagIndex],
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    hotel['tags'][tagIndex],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'RM ${hotel['price'].toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Per night before taxes and fees',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
