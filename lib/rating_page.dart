import 'package:flutter/material.dart';

class RatingPage extends StatefulWidget {
  final String packageTitle;

  const RatingPage({Key? key, required this.packageTitle}) : super(key: key);

  @override
  _RatingPageState createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> with SingleTickerProviderStateMixin {
  double _rating = 0;
  final _feedbackController = TextEditingController();
  late AnimationController _submitButtonController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _submitButtonController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  String _getRatingText() {
    if (_rating == 0) return 'Tap to rate';
    if (_rating == 1) return 'Poor';
    if (_rating == 2) return 'Fair';
    if (_rating == 3) return 'Good';
    if (_rating == 4) return 'Very Good';
    return 'Excellent';
  }
void _submitRating() async {
    if (_rating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.error_outline, color: Colors.white),
              SizedBox(width: 8),
              Text('Please provide a rating before submitting.'),
            ],
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    if (!_formKey.currentState!.validate()) return;

    // Animate button
    _submitButtonController.forward();
String feedback = _feedbackController.text.trim();

    // Simulating network delay
    await Future.delayed(Duration(milliseconds: 800));

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 8),
                Text('Rating submitted successfully!'),
              ],
            ),
            if (feedback.isNotEmpty) ...[
              SizedBox(height: 4),
              Text('Your feedback has been recorded.',
                  style: TextStyle(fontSize: 12)),
            ],
          ],
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 3),
      ),
    );

    // Reset animation and navigate back
    _submitButtonController.reverse();
    Navigator.of(context).popUntil((route) => route.isFirst);
  }
 Widget _buildStar(int index) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 300),
      tween: Tween(begin: 0.0, end: _rating >= index ? 1.0 : 0.0),
      builder: (context, value, child) {
        return Icon(
          _rating >= index
              ? Icons.star
              : _rating > index - 1
                  ? Icons.star_half
                  : Icons.star_border,
          color: Color.lerp(Colors.grey[400], Colors.amber, value),
          size: 40 + (value * 4),
        );
      },
    );
  }

  @override
  void dispose() {
    _feedbackController.dispose();
    _submitButtonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[50],
      appBar: AppBar(
        title: Text('Rate Your Experience'),
        backgroundColor: Colors.teal[700],
        elevation: 0,
        centerTitle: true,
      ),
 body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Rate the package:',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.teal[900],
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                widget.packageTitle,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal[900],
                ),
              ),
              SizedBox(height: 40),
              Center(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        final starIndex = index + 1;
                        return GestureDetector(
                          onTapDown: (details) {
                            setState(() {
                              _rating = starIndex.toDouble();
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            child: _buildStar(starIndex),
          ),
                        );
                      }),
                    ),
                    SizedBox(height: 16),
                    AnimatedSwitcher(
                      duration: Duration(milliseconds: 200),
                      child: Text(
                        _getRatingText(),
                        key: ValueKey(_rating),
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.teal[700],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              TextFormField(
                controller: _feedbackController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'Optional feedback',
                  hintText: 'Tell us more about your experience...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.teal),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.teal, width: 2),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value) {
                  if (value != null && value.length > 500) {
                    return 'Feedback must be less than 500 characters';
                  }
                  return null;
                },
              ),
              SizedBox(height: 40),
              AnimatedBuilder(
                animation: _submitButtonController,
                builder: (context, child) {
                  return SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: _submitButtonController.isAnimating ? null : _submitRating,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal[700],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                      child: _submitButtonController.isAnimating
                          ? SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
                              'Submit Rating',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
   );
  }
}