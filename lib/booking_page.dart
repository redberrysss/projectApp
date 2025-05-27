import 'package:flutter/material.dart';
import 'payment_page.dart';

class BookingPage extends StatefulWidget {
  final String packageTitle;

  const BookingPage({Key? key, required this.packageTitle}) : super(key: key);

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final _formKey = GlobalKey<FormState>();

  DateTime? _checkInDate;
  DateTime? _checkOutDate;
  int _guests = 1;

  Future<void> _selectDate(BuildContext context, bool isCheckIn) async {
    final DateTime now = DateTime.now();
    final DateTime firstDate = isCheckIn ? now : (_checkInDate ?? now);
    final DateTime initialDate = firstDate;
    final DateTime lastDate = DateTime(now.year + 2);

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (pickedDate != null) {
      setState(() {
        if (isCheckIn) {
          _checkInDate = pickedDate;
          if (_checkOutDate != null && _checkOutDate!.isBefore(pickedDate)) {
            _checkOutDate = null;
          }
        } else {
          _checkOutDate = pickedDate;
        }
      });
    }
  }

void _confirmBooking() {
  if (_formKey.currentState?.validate() ?? false) {
    // Navigate to PaymentPage passing required booking details
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PaymentPage(
          packageTitle: widget.packageTitle,
          checkInDate: _checkInDate!,
          checkOutDate: _checkOutDate!,
          guests: _guests,
        ),
      ),
    );
  }
}

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[50],
      appBar: AppBar(
        title: Text('Book: ${widget.packageTitle}'),
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
                'Booking Details',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal[900],
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Package: ${widget.packageTitle}',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.teal[800],
                ),
              ),
              SizedBox(height: 30),
              ListTile(
                title: Text('Check-in Date',
                    style: TextStyle(fontWeight: FontWeight.w600)),
                subtitle: Text(
                  _checkInDate == null ? 'Select date' : _formatDate(_checkInDate!),
                  style: TextStyle(fontSize: 16),
                ),
                trailing: Icon(Icons.calendar_today, color: Colors.teal[700]),
                onTap: () => _selectDate(context, true),
              ),
              if (_checkInDate == null)
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 4.0),
                  child: Text(
                    'Please select check-in date',
                    style: TextStyle(color: Colors.red[700], fontSize: 12),
                  ),
                ),
              SizedBox(height: 20),
              ListTile(
                title: Text('Check-out Date',
                    style: TextStyle(fontWeight: FontWeight.w600)),
                subtitle: Text(
                  _checkOutDate == null ? 'Select date' : _formatDate(_checkOutDate!),
                  style: TextStyle(fontSize: 16),
                ),
                trailing: Icon(Icons.calendar_today, color: Colors.teal[700]),
                onTap: _checkInDate == null ? null : () => _selectDate(context, false),
              ),
              if (_checkOutDate == null)
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 4.0),
                  child: Text(
                    'Please select check-out date',
                    style: TextStyle(color: Colors.red[700], fontSize: 12),
                  ),
                ),
              SizedBox(height: 30),
              Row(
                children: [
                  Text(
                    'Guests:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.teal[900],
                    ),
                  ),
                  SizedBox(width: 20),
                  DropdownButton<int>(
                    value: _guests,
                    items: List.generate(10, (index) => index + 1)
                        .map(
                          (num) => DropdownMenuItem<int>(
                            value: num,
                            child: Text('$num'),
                          ),
                        )
                        .toList(),
                    onChanged: (int? value) {
                      if (value != null) {
                        setState(() {
                          _guests = value;
                        });
                      }
                    },
                  ),
                ],
              ),
              SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: (_checkInDate != null && _checkOutDate != null && !_checkOutDate!.isBefore(_checkInDate!))
                      ? _confirmBooking
                      : null,
                  style: ElevatedButton.styleFrom(
                   
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Confirm Booking',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
