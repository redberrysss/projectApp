import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // No favorite hotels added yet
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Hotels'),
        backgroundColor: Colors.teal[700],
      ),
      body: const Center(
        child: Text(
          'No favorite hotels yet.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
