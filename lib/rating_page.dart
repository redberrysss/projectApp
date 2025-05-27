import 'package:flutter/material.dart';

class RatingPage extends StatefulWidget {
  final String packageTitle;

  const RatingPage({Key? key, required this.packageTitle}) : super(key: key);

  @override
  _RatingPageState createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  double _rating = 0;
  final _feedbackController = TextEditingController();

  void _submitRating() {
    if (_rating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please provide a rating before submitting.')),
      );
      return;
    }

    String feedback = _feedbackController.text.trim();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Thank you for rating ${widget.packageTitle} with $_rating star(s).'
          '${feedback.isNotEmpty ? "\nYour feedback: $feedback" : ""}',
        ),
        duration: Duration(seconds: 3),
      ),
    );

    // Navigate back to the home or first screen after rating submission
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  Widget _buildStar(int index) {
    if (_rating >= index) {
      return Icon(Icons.star, color: Colors.amber, size: 40);
    } else if (_rating > index - 1 && _rating < index) {
      return Icon(Icons.star_half, color: Colors.amber, size: 40);
    } else {
      return Icon(Icons.star_border, color: Colors.amber, size: 40);
    }
  }

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[50],
      appBar: AppBar(
        title: Text('Rate Your Experience'),
        backgroundColor: Colors.teal[700],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Rate the package: ${widget.packageTitle}',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.teal[900],
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                final starIndex = index + 1;
                return IconButton(
                  icon: _buildStar(starIndex),
                  onPressed: () {
                    setState(() {
                      _rating = starIndex.toDouble();
                    });
                  },
                );
              }),
            ),
            SizedBox(height: 30),
            TextField(
              controller: _feedbackController,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: 'Optional feedback',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _submitRating,
                style: ElevatedButton.styleFrom(
               
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Submit Rating',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}