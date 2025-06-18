import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package_page.dart';
import 'location_hotels_page.dart';

DateTime? _selectedCheckIn;
DateTime? _selectedCheckOut;

class BrowseHotelPage extends StatefulWidget {
  const BrowseHotelPage({super.key});

  @override
  State<BrowseHotelPage> createState() => _BrowseHotelPageState();
}

class _BrowseHotelPageState extends State<BrowseHotelPage> {
  final TextEditingController locationController = TextEditingController(
    text: "Seksyen 19, Shah Alam",
  );

  DateTime checkInDate = DateTime.now();
  DateTime checkOutDate = DateTime.now().add(const Duration(days: 1));

  bool showLimitedTimeOffersFirst = true;

  List<String> locationSuggestions = [
    "Seksyen 19, Shah Alam",
    "Kuala Lumpur",
    "Petaling Jaya",
    "Penang",
    "Bangkok",
    "Phuket",
    "Bali",
    "Jakarta",
    "Hanoi",
    "Ho Chi Minh City",
    "Phnom Penh",
    "Siem Reap",
    "Singapore City",
  ];

  List<String> filteredSuggestions = [];

  @override
  void initState() {
    super.initState();
    filteredSuggestions = locationSuggestions;
  }

  void _filterLocations(String input) {
    setState(() {
      filteredSuggestions = locationSuggestions
          .where((location) =>
              location.toLowerCase().contains(input.toLowerCase()))
          .toList();
    });
  }

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
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              labelText: "Location",
            ),
            onChanged: (value) {
              _filterLocations(value);
            },
          ),
          if (filteredSuggestions.isNotEmpty)
            Container(
              margin: const EdgeInsets.only(top: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.teal.shade200),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: filteredSuggestions.length,
                itemBuilder: (context, index) {
                  final suggestion = filteredSuggestions[index];
                  return ListTile(
                    title: Text(suggestion),
                    onTap: () {
                      setState(() {
                        locationController.text = suggestion;
                        filteredSuggestions = [];
                      });
                    },
                  );
                },
              ),
            ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: _selectedCheckIn ?? DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                      builder: (context, child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: ColorScheme.light(
                              primary: Colors.teal[700]!,
                              onPrimary: Colors.white,
                              onSurface: Colors.teal[900]!,
                            ),
                            textButtonTheme: TextButtonThemeData(
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.teal[700],
                              ),
                            ),
                          ),
                          child: child!,
                        );
                      },
                    );
                    if (picked != null) {
                      setState(() {
                        _selectedCheckIn = picked;
                        if (_selectedCheckOut != null &&
                            _selectedCheckOut!.isBefore(picked)) {
                          _selectedCheckOut = null;
                        }
                      });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.teal[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.teal[200]!),
                    ),
                    child: Text(
                      _selectedCheckIn == null
                          ? 'Select Check-In'
                          : 'Check-In: ${_selectedCheckIn!.day}/${_selectedCheckIn!.month}/${_selectedCheckIn!.year}',
                      style: TextStyle(
                        color: Colors.teal[900],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: GestureDetector(
                  onTap: _selectedCheckIn == null
                      ? null
                      : () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: _selectedCheckOut ??
                                _selectedCheckIn!.add(
                                  const Duration(days: 1),
                                ),
                            firstDate: _selectedCheckIn!.add(
                              const Duration(days: 1),
                            ),
                            lastDate: DateTime.now().add(
                              const Duration(days: 366),
                            ),
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: ColorScheme.light(
                                    primary: Colors.teal[700]!,
                                    onPrimary: Colors.white,
                                    onSurface: Colors.teal[900]!,
                                  ),
                                  textButtonTheme: TextButtonThemeData(
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.teal[700],
                                    ),
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );
                          if (picked != null) {
                            setState(() {
                              _selectedCheckOut = picked;
                            });
                          }
                        },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.teal[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.teal[200]!),
                    ),
                    child: Text(
                      _selectedCheckOut == null
                          ? 'Select Check-Out'
                          : 'Check-Out: ${_selectedCheckOut!.day}/${_selectedCheckOut!.month}/${_selectedCheckOut!.year}',
                      style: TextStyle(
                        color: Colors.teal[900],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
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
              Checkbox(
                value: showLimitedTimeOffersFirst,
                onChanged: (bool? value) {
                  setState(() {
                    showLimitedTimeOffersFirst = value ?? false;
                  });
                },
                activeColor: Colors.teal[700],
              ),
              const Text("Show limited time offers first"),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                color: Colors.red,
                child: const Text(
                  "Save up to 20%",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LocationHotelsPage(location: locationController.text),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: Colors.teal[700],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text("Search", style: TextStyle(fontSize: 18)),
              ),
          const SizedBox(height: 24),
          const Text(
            "Discount Coupons",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ListTile(
            leading: const Icon(
              Icons.local_offer,
              size: 32,
              color: Colors.green,
            ),
            title: const Text("Up to RM200 Off Hotels"),
            subtitle: const Text("Min. spend RM130 | Expires in 3 days"),
            trailing: TextButton(
              onPressed: () {},
              child: const Text("Collect"),
            ),
          ),
        ],
      ),
    );
  }
}
