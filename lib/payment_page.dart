import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'rating_page.dart';
import 'my_booking_page.dart';

enum PaymentMethod { card, onlineBanking, tng }

class PaymentPage extends StatefulWidget {
  final String packageTitle;
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final int guests;
  final double totalAmount;

  const PaymentPage({
    super.key,
    required this.packageTitle,
    required this.checkInDate,
    required this.checkOutDate,
    required this.guests,
    required this.totalAmount,
  });

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final _formKey = GlobalKey<FormState>();

  String cardNumber = '';
  String expiryDate = '';
  String cvv = '';
  String bankUsername = '';
  String bankPin = '';

  PaymentMethod selectedMethod = PaymentMethod.card;
  String selectedBank = 'Maybank';
  bool isProcessing = false;

  final List<String> availableBanks = [
    'Maybank',
    'CIMB',
    'Public Bank',
    'RHB',
    'Bank Islam',
  ];

  late double totalAmount;

  @override
  void initState() {
    super.initState();
    totalAmount = widget.totalAmount;
  }

  void _submitPayment() async {
    if (selectedMethod == PaymentMethod.card || selectedMethod == PaymentMethod.onlineBanking) {
      if (!(_formKey.currentState?.validate() ?? false)) return;
    }

    setState(() => isProcessing = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => isProcessing = false);

    _showReceiptDialog('Payment Successful via ${selectedMethod == PaymentMethod.card ? "Card" : selectedBank}');
  }

  void _submitTngPayment() async {
    setState(() => isProcessing = true);
    await Future.delayed(const Duration(seconds: 3));
    setState(() => isProcessing = false);

    _showReceiptDialog('Payment Successful via TNG');
  }

  void _showReceiptDialog(String title) {
    final now = DateTime.now();

    // Add booking record to BookingManager
    BookingManager.instance.addBooking(
      BookingRecord(
        packageTitle: widget.packageTitle,
        checkInDate: widget.checkInDate,
        checkOutDate: widget.checkOutDate,
        adults: widget.guests,
        children: 0,
        infants: 0,
        amount: totalAmount,
        paymentMethod: selectedMethod == PaymentMethod.card
            ? 'Card'
            : selectedMethod == PaymentMethod.onlineBanking
                ? selectedBank
                : 'TNG',
      ),
    );

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Date: ${_formatDate(now)}'),
            Text('Time: ${now.hour}:${now.minute.toString().padLeft(2, '0')}'),
            const SizedBox(height: 10),
            Text('Package: ${widget.packageTitle}'),
            Text('Check-in: ${_formatDate(widget.checkInDate)}'),
            Text('Check-out: ${_formatDate(widget.checkOutDate)}'),
            Text('Guests: ${widget.guests}'),
            Text('Payment Method: ${selectedMethod == PaymentMethod.card ? 'Card' : selectedMethod == PaymentMethod.onlineBanking ? selectedBank : 'TNG'}'),
            const SizedBox(height: 10),
            Text('Amount: RM ${totalAmount.toStringAsFixed(2)}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => RatingPage(packageTitle: widget.packageTitle),
                ),
              );
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[50],
      appBar: AppBar(
        title: const Text('Payment', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.teal[700],
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: isProcessing
          ? const Center(child: CircularProgressIndicator(color: Colors.teal))
          : Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    Text(
                      'Pay For: ${widget.packageTitle}',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.teal[900]),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'From ${_formatDate(widget.checkInDate)} to ${_formatDate(widget.checkOutDate)} for ${widget.guests} guest(s)',
                      style: TextStyle(fontSize: 16, color: Colors.teal[800]),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Total Amount: RM ${totalAmount.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 18, color: Colors.black87, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 30),
                    DropdownButtonFormField<PaymentMethod>(
                      value: selectedMethod,
                      decoration: InputDecoration(
                        labelText: 'Payment Method',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      items: const [
                        DropdownMenuItem(value: PaymentMethod.card, child: Text('Credit/Debit Card')),
                        DropdownMenuItem(value: PaymentMethod.onlineBanking, child: Text('Online Banking')),
                        DropdownMenuItem(value: PaymentMethod.tng, child: Text('Touch \'n Go eWallet')),
                      ],
                      onChanged: (value) {
                        if (value != null) setState(() => selectedMethod = value);
                      },
                    ),
                    const SizedBox(height: 20),
                    if (selectedMethod == PaymentMethod.card) _buildCardInputFields(),
                    if (selectedMethod == PaymentMethod.onlineBanking) _buildOnlineBankingFields(),
                    if (selectedMethod == PaymentMethod.tng) _buildTngSection(),
                    const SizedBox(height: 30),
                    if (selectedMethod != PaymentMethod.tng)
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _submitPayment,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal[700],
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          child: const Text('Payment Confirmation', style: TextStyle(fontSize: 18, color: Colors.white)),
                        ),
                      ),
                  ],
                ),
              ),
            ),
    );
  }

  Column _buildCardInputFields() {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Card Number',
            prefixIcon: const Icon(Icons.credit_card),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          maxLength: 16,
          obscureText: true,
          validator: (value) {
            if (value == null || value.trim().length != 16) {
              return 'Enter your 16-digit number';
            }
            return null;
          },
          onChanged: (value) => cardNumber = value.trim(),
        ),
        const SizedBox(height: 20),
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Expired Date (MM/YY)',
            prefixIcon: const Icon(Icons.calendar_today),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          keyboardType: TextInputType.datetime,
          inputFormatters: [
            LengthLimitingTextInputFormatter(5),
            FilteringTextInputFormatter.allow(RegExp(r'[0-9/]')),
          ],
          validator: (value) {
            if (value == null || !RegExp(r'^(0[1-9]|1[0-2])\/([0-9]{2})$').hasMatch(value)) {
              return 'Enter Expired Date MM/YY';
            }
            return null;
          },
          onChanged: (value) => expiryDate = value.trim(),
        ),
        const SizedBox(height: 20),
        TextFormField(
          decoration: InputDecoration(
            labelText: 'CVV',
            prefixIcon: const Icon(Icons.lock),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          keyboardType: TextInputType.number,
          obscureText: true,
          maxLength: 3,
          validator: (value) {
            if (value == null || value.trim().length != 3) {
              return 'Please enter 3-digit CVV';
            }
            return null;
          },
          onChanged: (value) => cvv = value.trim(),
        ),
      ],
    );
  }

  Column _buildOnlineBankingFields() {
    return Column(
      children: [
        DropdownButtonFormField<String>(
          value: selectedBank,
          decoration: InputDecoration(
            labelText: 'Select Bank',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          items: availableBanks.map((bank) {
            return DropdownMenuItem(value: bank, child: Text(bank));
          }).toList(),
          onChanged: (value) {
            if (value != null) setState(() => selectedBank = value);
          },
        ),
        const SizedBox(height: 20),
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Bank Username',
            prefixIcon: const Icon(Icons.person),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter your username';
            }
            return null;
          },
          onChanged: (value) => bankUsername = value.trim(),
        ),
        const SizedBox(height: 20),
        TextFormField(
          decoration: InputDecoration(
            labelText: '6-digit Transaction PIN',
            prefixIcon: const Icon(Icons.lock),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          keyboardType: TextInputType.number,
          obscureText: true,
          inputFormatters: [
            LengthLimitingTextInputFormatter(6),
            FilteringTextInputFormatter.digitsOnly,
          ],
          validator: (value) {
            if (value == null || value.length != 6) {
              return 'Enter a 6-digit PIN';
            }
            return null;
          },
          onChanged: (value) => bankPin = value.trim(),
        ),
      ],
    );
  }

  Column _buildTngSection() {
    return Column(
      children: [
        Text(
          'You will be redirected to Touch \'n Go eWallet to complete your payment.',
          style: TextStyle(fontSize: 16, color: Colors.teal[800]),
        ),
        const SizedBox(height: 20),
        Center(
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.teal),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.network(
              'https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=simulated_payment_tng_123',
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Scan QR with your TNG eWallet App',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, color: Colors.teal[700]),
        ),
        const SizedBox(height: 20),
        Center(
          child: ElevatedButton.icon(
            onPressed: _submitTngPayment,
            icon: const Icon(Icons.open_in_new),
            label: const Text('Open TNG App'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ),
      ],
    );
  }
}
