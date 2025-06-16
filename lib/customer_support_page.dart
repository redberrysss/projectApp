import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'home_page.dart';

class CustomerSupportPage extends StatefulWidget {
  @override
  _CustomerSupportPageState createState() => _CustomerSupportPageState();
}

class _CustomerSupportPageState extends State<CustomerSupportPage> {
  final String phoneNumber = '60164805956';
  final TextEditingController _chatController = TextEditingController();

  Future<void> _makePhoneCall(BuildContext context) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Cannot make a call')),
      );
    }
  }

  Future<void> _openWhatsApp(BuildContext context) async {
    String message = _chatController.text.trim();
    if (message.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please write a message before sending')),
      );
      return;
    }

    final Uri whatsappUri = Uri.parse(
      'https://api.whatsapp.com/send?phone=60164805956&text=TripJr%20%20!!',
    );

    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Cannot open WhatsApp')),
      );
    }
  }

  @override
  void dispose() {
    _chatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
  title: Text(
    'Customer Support',
    style: TextStyle(color: Colors.white), 
  ),
  backgroundColor: Colors.teal.shade700,
  iconTheme: IconThemeData(color: Colors.white),
),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Customer Service Chat',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade800,
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.teal.shade100),
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.teal.shade50,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  TextField(
                    controller: _chatController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: 'Write message here...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.teal.shade50,
                    ),
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
  onPressed: () => _openWhatsApp(context),
  icon: Icon(Icons.send, color: Colors.white),
  label: Text('Chat Us',
    style: TextStyle(color: Colors.white), 
  ),
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.teal,
    padding: EdgeInsets.symmetric(vertical: 14),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
),

                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),

            ElevatedButton.icon(
              onPressed: () => _makePhoneCall(context),
              icon: Icon(Icons.call, color: Colors.white),
              label: Text('Call Us', style: TextStyle(fontSize: 16,  color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal.shade700,
                padding: EdgeInsets.symmetric(vertical: 14, horizontal: 30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),

            SizedBox(height: 30),

            Text(
              '🕒 Support Hours',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade800,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Monday - Friday: 9:00 AM - 6:00 PM\nSaturday: 9:00 AM - 1:00 PM\nSunday & Public Holiday: Closed',
              style: TextStyle(
                fontSize: 16,
                color: Colors.teal.shade700,
              ),
            ),

            SizedBox(height: 30),

            Text(
              '❓ Frequently Asked Questions',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade800,
              ),
            ),
            SizedBox(height: 8),
            ExpansionTile(
              title: Text('How can I modify my booking?',
                  style: TextStyle(color: Colors.teal.shade800)),
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  child: Text(
                    'You can modify your booking from the Booking page by entering your details again.',
                    style: TextStyle(color: Colors.teal.shade700),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Text('Do you offer refunds?',
                  style: TextStyle(color: Colors.teal.shade800)),
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  child: Text(
                    'Refunds are subject to our cancellation policy. Please contact support.',
                    style: TextStyle(color: Colors.teal.shade700),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Text('How do I contact customer service?',
                  style: TextStyle(color: Colors.teal.shade800)),
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  child: Text(
                    'You can call or chat with us via WhatsApp using the options above.',
                    style: TextStyle(color: Colors.teal.shade700),
                  ),
                ),
              ],
            ),

            SizedBox(height: 30),

            Center(
              child: TextButton.icon(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
                icon: Icon(Icons.home, color: Colors.teal.shade700),
                label: Text(
                  'Back to Home',
                  style: TextStyle(color: Colors.teal.shade700, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}