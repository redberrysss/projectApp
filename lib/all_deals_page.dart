import 'package:flutter/material.dart';

class AllDealsPage extends StatelessWidget {
  const AllDealsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> allDeals = [
      {
        'title': 'Travel to Malaysia',
        'subtitle': 'Up to 20% OFF',
        'imageUrl': 'https://picsum.photos/300/200?random=6',
        'discount': 20,
        'country': 'Malaysia',
      },
      {
        'title': 'Travel to Thailand',
        'subtitle': 'Up to 20% OFF',
        'imageUrl': 'https://picsum.photos/300/200?random=7',
        'discount': 20,
        'country': 'Thailand',
      },
      {
        'title': 'Travel to Indonesia',
        'subtitle': 'Relax with an ocean view',
        'imageUrl': 'https://picsum.photos/300/200?random=8',
        'discount': 30,
        'country': 'Indonesia',
      },
      {
        'title': 'Travel to Vietnam',
        'subtitle': 'Up to 20% OFF',
        'imageUrl': 'https://picsum.photos/300/200?random=9',
        'discount': 20,
        'country': 'Vietnam',
      },
      {
        'title': 'Travel to Cambodia',
        'subtitle': 'Up to 20% OFF',
        'imageUrl': 'https://picsum.photos/300/200?random=10',
        'discount': 20,
        'country': 'Cambodia',
      },
      {
        'title': 'Travel to Singapore',
        'subtitle': 'Up to 20% OFF',
        'imageUrl': 'https://picsum.photos/300/200?random=11',
        'discount': 20,
        'country': 'Singapore',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Hotel Deals'),
        backgroundColor: Colors.teal[700],
      ),
      body: ListView.builder(
        itemCount: allDeals.length,
        itemBuilder: (context, index) {
          final deal = allDeals[index];
          return ListTile(
            leading: Icon(Icons.local_offer, color: Colors.teal[700]),
            title: Text(deal['title']),
            subtitle: Text(deal['subtitle']),
            trailing: Text(deal['country']),
            onTap: () {
              // TODO: Implement navigation to deal details if needed
            },
          );
        },
      ),
    );
  }
}
