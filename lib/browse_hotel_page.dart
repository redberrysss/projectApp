import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package_page.dart'; 

class BrowseHotelPage extends StatefulWidget {
  const BrowseHotelPage({super.key});

  @override
  State<BrowseHotelPage> createState() => _BrowseHotelPageState();
}

class _BrowseHotelPageState extends State<BrowseHotelPage> {
  final TextEditingController locationController =
      TextEditingController(text: "Seksyen 19, Shah Alam");

  DateTime checkInDate = DateTime.now();
  DateTime checkOutDate = DateTime.now().add(const Duration(days: 1));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All rooms"),
        backgroundColor: Colors.teal[700],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ToggleButtons(
            borderRadius: BorderRadius.circular(8),
            isSelected: const [true, false],
            children: const [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text("Overnight"),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text("Day Use"),
              ),
            ],
            onPressed: (index) {},
          ),
          const SizedBox(height: 16),
          TextField(
            controller: locationController,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              suffixIcon: const Icon(Icons.location_on),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              labelText: "Location",
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildDatePicker(
                    "Check-in", checkInDate, (date) => setState(() => checkInDate = date)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildDatePicker(
                    "Check-out", checkOutDate, (date) => setState(() => checkOutDate = date)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              Icon(Icons.people),
              SizedBox(width: 8),
              Text("1 room 2 adults 0 children"),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Checkbox(value: true, onChanged: (_) {}),
              const Text("Show limited time offers first"),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                color: Colors.red,
                child: const Text(
                  "Save up to 20%",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PackagePage(packageTitle: "Available Hotels"),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text("Search", style: TextStyle(fontSize: 18)),
          ),
          const SizedBox(height: 24),
          const Text("Discount Coupons", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          ListTile(
            leading: const Icon(Icons.local_offer, size: 32, color: Colors.green),
            title: const Text("Up to RM200 Off Hotels"),
            subtitle: const Text("Min. spend RM130 | Expires in 3 days"),
            trailing: TextButton(onPressed: () {}, child: const Text("Collect")),
          )
        ],
      ),
    );
  }

  Widget _buildDatePicker(String label, DateTime selectedDate, Function(DateTime) onDateSelected) {
    return InkWell(
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime.now(),
          lastDate: DateTime(2100),
        );
        if (picked != null) {
          onDateSelected(picked);
        }
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: Text(DateFormat('EEE, d MMM').format(selectedDate)),
      ),
    );
  }
}
