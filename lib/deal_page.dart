import 'package:flutter/material.dart';
import 'booking_page.dart';

class DealsPage extends StatefulWidget {
  final String country;
  final double maxDiscount;
  final String flagEmoji;
  const DealsPage({super.key, required this.country, required this.maxDiscount, required this.flagEmoji});

  @override
  State<DealsPage> createState() => _DealsPageState();
}

class _DealsPageState extends State<DealsPage> {
  late String selectedDestination;

  final Map<String, Map<String, List<Map<String, dynamic>>>> hotelsByCountryAndDestination = {
    "Malaysia": {
      "Kuala Lumpur": [
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
      ],
      "Petaling Jaya": [
        {
          "name": "Sunway Resort",
          "location": "Petaling Jaya",
          "discount": 38,
          "image": "https://picsum.photos/300/200?random=13",
          "rating": 4.6,
        },
      ],
      "Penang": [
        // Add Penang hotels here if any
      ],
    },
    "Thailand": {
      "Bangkok": [
        {
          "name": "Bangkok Hotel 1",
          "location": "Central Bangkok",
          "discount": 22,
          "image": "https://picsum.photos/300/200?random=16",
          "rating": 4.2,
        },
      ],
      "Phuket": [
        {
          "name": "Phuket Resort",
          "location": "Patong Beach",
          "discount": 28,
          "image": "https://picsum.photos/300/200?random=17",
          "rating": 4.5,
        },
      ],
    },
    "Indonesia": {
      "Bali": [
        {
          "name": "Bali Beach Resort",
          "location": "Kuta",
          "discount": 30,
          "image": "https://picsum.photos/300/200?random=18",
          "rating": 4.4,
        },
      ],
      "Jakarta": [
        {
          "name": "Jakarta Hotel",
          "location": "Central Jakarta",
          "discount": 25,
          "image": "https://picsum.photos/300/200?random=19",
          "rating": 4.1,
        },
      ],
    },
    "Vietnam": {
      "Hanoi": [
        {
          "name": "Hanoi Hotel 1",
          "location": "Hanoi Center",
          "discount": 25,
          "image": "https://picsum.photos/300/200?random=14",
          "rating": 4.3,
        },
      ],
      "Ho Chi Minh City": [
        {
          "name": "Saigon Hotel",
          "location": "District 1",
          "discount": 30,
          "image": "https://picsum.photos/300/200?random=15",
          "rating": 4.4,
        },
      ],
    },
    "Cambodia": {
      "Phnom Penh": [
        {
          "name": "Phnom Penh Hotel",
          "location": "City Center",
          "discount": 20,
          "image": "https://picsum.photos/300/200?random=20",
          "rating": 4.0,
        },
      ],
      "Siem Reap": [
        {
          "name": "Siem Reap Resort",
          "location": "Near Angkor Wat",
          "discount": 22,
          "image": "https://picsum.photos/300/200?random=21",
          "rating": 4.3,
        },
      ],
    },
    "Singapore": {
      "Singapore City": [
        {
          "name": "Singapore Hotel",
          "location": "Marina Bay",
          "discount": 27,
          "image": "https://picsum.photos/300/200?random=22",
          "rating": 4.6,
        },
      ],
    },
  };

  @override
  void initState() {
    super.initState();
    final destinations = hotelsByCountryAndDestination[widget.country]?.keys.toList() ?? [];
    selectedDestination = destinations.isNotEmpty ? destinations[0] : '';
  }

  @override
  Widget build(BuildContext context) {
    final hotels = hotelsByCountryAndDestination[widget.country]?[selectedDestination] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text('Travel to ${widget.country} ${widget.flagEmoji}'),
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
                  'Travel to ${widget.country} ${widget.flagEmoji}',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Congratulations, grab up to ${widget.maxDiscount.toInt()}% off on our participating hotels!',
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
                    items: (hotelsByCountryAndDestination[widget.country]?.keys.toList() ?? [])
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          selectedDestination = value;
                        });
                      }
                    },
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
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => BookingPage(packageTitle: hotel['name'] as String, price: 70.0),
                        ),
                      );
                    },
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
              child: Text('Search for more hotels in \$selectedDestination'),
            ),
          ),
        ],
      ),
    );
  }
}
