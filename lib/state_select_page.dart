import 'package:flutter/material.dart';
import 'top_hotel_page.dart';

class StateSelectionPage extends StatelessWidget {
  const StateSelectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> states = [
      'Kuala Lumpur',
      'Selangor',
      'Penang',
      'Johor',
      'Sabah',
      'Sarawak',

    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select a State'),
        backgroundColor: Colors.teal[700],
      ),
      body: ListView.builder(
        itemCount: states.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(states[index]),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TopHotelsPage(state: states[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}