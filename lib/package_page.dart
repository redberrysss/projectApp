import 'package:flutter/material.dart';
import 'home_page.dart';

class Hotel {
  final String name;
  final double price;
  final double rating;
  final int reviews;
  final String location;
  final int discount;
  final int originalPrice;
  final List<String> offers;
  final List<String> tags;
  final String imageUrl;
  final List<String> thumbnails;
  final int stars;
  final bool bestRated;
  final bool award;

  Hotel({
    required this.name,
    required this.price,
    required this.rating,
    required this.reviews,
    required this.location,
    required this.discount,
    required this.originalPrice,
    required this.offers,
    required this.tags,
    required this.imageUrl,
    required this.thumbnails,
    required this.stars,
    this.bestRated = false,
    this.award = false,
  });
}

class PackagePage extends StatelessWidget {
  final String packageTitle;

  PackagePage({Key? key, required this.packageTitle}) : super(key: key);

  final List<Hotel> availableHotels = [
    Hotel(
      name: 'Sunway Pyramid Hotel',
      price: 390,
      rating: 8.4,
      reviews: 29277,
      location: 'Bandar Sunway, Kuala Lumpur - 12.1 km to center',
      discount: 61,
      originalPrice: 1000,
      offers: [],
      tags: [],
      imageUrl: 'https://example.com/sunway_pyramid.jpg',
      thumbnails: [
        'https://example.com/sunway_pyramid_1.jpg',
        'https://example.com/sunway_pyramid_2.jpg',
        'https://example.com/sunway_pyramid_3.jpg',
        'https://example.com/sunway_pyramid_4.jpg',
      ],
      stars: 4,
      bestRated: false,
      award: false,
    ),
    Hotel(
      name: 'Sleeping Lion Suites',
      price: 207,
      rating: 9.0,
      reviews: 32935,
      location: 'Bukit Bintang, Kuala Lumpur - City center',
      discount: 25,
      originalPrice: 275,
      offers: [],
      tags: [],
      imageUrl: 'https://example.com/sleeping_lion.jpg',
      thumbnails: [
        'https://example.com/sleeping_lion_1.jpg',
        'https://example.com/sleeping_lion_2.jpg',
        'https://example.com/sleeping_lion_3.jpg',
        'https://example.com/sleeping_lion_4.jpg',
      ],
      stars: 3,
      bestRated: true,
      award: false,
    ),
    Hotel(
      name: 'Cititel Mid Valley Hotel',
      price: 219,
      rating: 8.2,
      reviews: 47471,
      location: 'Mid Valley / Bangsar, Kuala Lumpur - 3.1 km to center',
      discount: 36,
      originalPrice: 342,
      offers: [],
      tags: [],
      imageUrl: 'https://example.com/cititel_mid_valley.jpg',
      thumbnails: [
        'https://example.com/cititel_mid_valley_1.jpg',
        'https://example.com/cititel_mid_valley_2.jpg',
        'https://example.com/cititel_mid_valley_3.jpg',
        'https://example.com/cititel_mid_valley_4.jpg',
      ],
      stars: 3,
      bestRated: false,
      award: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(packageTitle),
        backgroundColor: Colors.teal[700],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: availableHotels.length,
        itemBuilder: (context, index) {
          final hotel = availableHotels[index];
          return _buildHotelCard(hotel, context);
        },
      ),
    );
  }

  Widget _buildHotelCard(Hotel hotel, BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Main image and thumbnails
            Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    hotel.imageUrl,
                    width: 150,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: 150,
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: hotel.thumbnails.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                hotel.thumbnails[index],
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                            if (index == hotel.thumbnails.length - 1)
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Center(
                                  child: Text(
                                    "See all",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(width: 12),
            // Hotel details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          hotel.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.favorite_border),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Row(
                        children: List.generate(
                          hotel.stars,
                          (index) => const Icon(
                            Icons.star,
                            color: Colors.orange,
                            size: 16,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        hotel.location,
                        style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "This property offers:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Wrap(
                    spacing: 6,
                    children: hotel.offers.map((offer) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          offer,
                          style: const TextStyle(fontSize: 12),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            // Ratings and price
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "${hotel.rating} Excellent",
                  style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  "${hotel.reviews} reviews",
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 8),
                if (hotel.tags.contains("ONLY 1 LEFT"))
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.red[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      "ONLY 1 LEFT",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.red,
                      ),
                    ),
                  ),
                if (hotel.tags.contains("MEGA SALE"))
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      "MEGA SALE",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                if (hotel.tags.contains("FREE CANCELLATION"))
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      "FREE CANCELLATION",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.green,
                      ),
                    ),
                  ),
                const SizedBox(height: 8),
                Text(
                  "RM ${hotel.price}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  "Per night before taxes and fees",
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal[700],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text("Book Now"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
