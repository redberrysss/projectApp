import 'package:flutter/material.dart';

// Model to represent completed booking + payment record
class BookingRecord {
  final String packageTitle;
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final int adults;
  final int children;
  final int infants;
  final double amount;
  final String paymentMethod;

  BookingRecord({
    required this.packageTitle,
    required this.checkInDate,
    required this.checkOutDate,
    required this.adults,
    required this.children,
    required this.infants,
    required this.amount,
    required this.paymentMethod,
  });
}

// Singleton BookingManager to store booking/payment records globally
class BookingManager {
  BookingManager._privateConstructor();
  static final BookingManager instance = BookingManager._privateConstructor();

  final List<BookingRecord> _bookings = [];

  List<BookingRecord> get bookings => List.unmodifiable(_bookings);

  void addBooking(BookingRecord booking) {
    _bookings.add(booking);
  }
}

class MyBookingsPage extends StatelessWidget {
  const MyBookingsPage({Key? key}) : super(key: key);

  String _formatDate(DateTime d) => '${d.day}/${d.month}/${d.year}';

  @override
  Widget build(BuildContext context) {
    final bookings = BookingManager.instance.bookings;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bookings & Payments'),
        backgroundColor: Colors.teal[700],
      ),
      body: bookings.isEmpty
          ? const Center(child: Text('No bookings or payments made yet.'))
          : ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: bookings.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final booking = bookings[index];
                return ListTile(
                  title: Text(booking.packageTitle),
                  subtitle: Text(
                      'Check-in: ${_formatDate(booking.checkInDate)}\n'
                      'Check-out: ${_formatDate(booking.checkOutDate)}\n'
                      'Guests: Adults: ${booking.adults}, Children: ${booking.children}, Infants: ${booking.infants}\n'
                      'Payment Method: ${booking.paymentMethod}\n'
                      'Amount Paid: RM ${booking.amount.toStringAsFixed(2)}'),
                  isThreeLine: true,
                  onTap: () {
                    // Show detailed info dialog
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text('Booking Details'),
                        content: Text(
                          'Package: ${booking.packageTitle}\n'
                          'Check-in: ${_formatDate(booking.checkInDate)}\n'
                          'Check-out: ${_formatDate(booking.checkOutDate)}\n'
                          'Adults: ${booking.adults}\n'
                          'Children: ${booking.children}\n'
                          'Infants: ${booking.infants}\n'
                          'Payment Method: ${booking.paymentMethod}\n'
                          'Amount Paid: RM ${booking.amount.toStringAsFixed(2)}',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Close'),
                          )
                        ],
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
