import 'package:flutter/material.dart';
import 'rating_page.dart';

class PaymentPage extends StatefulWidget {
  final String packageTitle;
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final int guests;

  const PaymentPage({
    Key? key,
    required this.packageTitle,
    required this.checkInDate,
    required this.checkOutDate,
    required this.guests,
  }) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final _formKey = GlobalKey<FormState>();

  String cardNumber = '';
  String expiryDate = '';
  String cvv = '';

  void _submitPayment() {
    if (_formKey.currentState?.validate() ?? false) {
      // Navigate to RatingPage
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => RatingPage(packageTitle: widget.packageTitle),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[50],
      appBar: AppBar(
        title: Text('Payment'),
        backgroundColor: Colors.teal[700],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                'Pay for: ${widget.packageTitle}',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal[900],
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Booking from ${_formatDate(widget.checkInDate)} to ${_formatDate(widget.checkOutDate)} for ${widget.guests} guest(s).',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.teal[800],
                ),
              ),
              SizedBox(height: 30),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Card Number',
                  prefixIcon: Icon(Icons.credit_card),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                keyboardType: TextInputType.number,
                maxLength: 16,
                validator: (value) {
                  if (value == null || value.trim().length != 16) {
                    return 'Enter a valid 16-digit card number';
                  }
                  return null;
                },
                onChanged: (value) => cardNumber = value.trim(),
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Expiry Date (MM/YY)',
                  prefixIcon: Icon(Icons.calendar_today),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                keyboardType: TextInputType.datetime,
                maxLength: 5,
                validator: (value) {
                  if (value == null || !RegExp(r'^(0[1-9]|1[0-2])\/?([0-9]{2})$').hasMatch(value)) {
                    return 'Enter expiry in MM/YY format';
                  }
                  return null;
                },
                onChanged: (value) => expiryDate = value.trim(),
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'CVV',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                keyboardType: TextInputType.number,
                maxLength: 3,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.trim().length != 3) {
                    return 'Enter a valid 3-digit CVV';
                  }
                  return null;
                },
                onChanged: (value) => cvv = value.trim(),
              ),
              SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _submitPayment,
                  style: ElevatedButton.styleFrom(
                    
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Confirm Payment',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}