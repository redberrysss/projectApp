import 'package:flutter/material.dart';

class DealsPage extends StatelessWidget {
  final String country;
  final double maxDiscount;
  const DealsPage({super.key, required this.country, required this.maxDiscount});

  @override
  Widget build(BuildContext context) {
    final hotels = [
      {
        "name": "One World Hotel",
        "location": "One Utama / Damansara",
        "discount": 41,
        "image": "https://picsum.photos/300/200?random=11",
        "rating": 4.5,
      },
      {
        "name": "Deface Platinum Suites",
        "location": "Kuala Lumpur",
        "discount": 64,
        "image": "https://picsum.photos/300/200?random=12",
        "rating": 4.7,
      },
      {
        "name": "Sunway Resort",
        "location": "Petaling Jaya",
        "discount": 38,
        "image": "https://picsum.photos/300/200?random=13",
        "rating": 4.6,
      },
    ];

    String selectedDestination = "Kuala Lumpur";

    return Scaffold(
      appBar: AppBar(
        title: Text('Travel to $country'),
        backgroundColor: Colors.teal[700],
        leading: const BackButton(),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF00E0C6), Color(0xFFB2FEFA)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 18),
            child: Column(
              children: [
                Text(
                  'Travel to $country 🇲🇾',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Congratulations, grab up to ${maxDiscount.toInt()}% off on our participating hotels!',
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  'T&Cs apply',
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
                const SizedBox(height: 16),
                Image.network(
                  'https://i.ibb.co/Gt3JptH/malaysia-banner.png',
                  height: 70,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => const SizedBox(),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                const Text(
                  'Destination',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButton<String>(
                    value: selectedDestination,
                    isExpanded: true,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    underline: Container(height: 1, color: Colors.teal),
                    items: ["Kuala Lumpur", "Petaling Jaya", "Penang"]
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (_) {},
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: hotels.length,
              separatorBuilder: (_, __) => const SizedBox(height: 14),
              itemBuilder: (context, idx) {
                final hotel = hotels[idx];
                return Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {},
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                              child: Image.network(
                                hotel['image'] as String,
                                height: 120,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => Container(
                                  height: 120,
                                  color: Colors.grey[300],
                                  child: const Icon(Icons.broken_image, size: 40),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 10,
                              left: 10,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                child: Text(
                                  "${hotel['discount']}% Discount",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.verified, color: Colors.amber, size: 18),
                                        const SizedBox(width: 4),
                                        Text(
                                          hotel["name"] as String,
                                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        const Icon(Icons.place, color: Colors.teal, size: 16),
                                        const SizedBox(width: 2),
                                        Flexible(
                                          child: Text(
                                            hotel["location"] as String,
                                            style: const TextStyle(fontSize: 13, color: Colors.black54),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.star, color: Colors.orange, size: 16),
                                      const SizedBox(width: 2),
                                      Text(
                                        "${hotel['rating']}",
                                        style: const TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 46),
                backgroundColor: Colors.teal[700],
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              ),
              onPressed: () {},
              child: const Text('Search for more hotels in Kuala Lumpur'),
            ),
          ),
        ],
      ),
    );
  }
}