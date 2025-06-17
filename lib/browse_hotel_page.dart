import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package_page.dart';

class BrowseHotelPage extends StatefulWidget {
  const BrowseHotelPage({Key? key}) : super(key: key);

  @override
  State<BrowseHotelPage> createState() => _BrowseHotelPageState();
}

class _BrowseHotelPageState extends State<BrowseHotelPage> {
  bool isDayUse = false;
  DateTime? _selectedDayUseDate;
  DateTime? _selectedCheckIn;
  DateTime? _selectedCheckOut;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Browse Hotels'),
        backgroundColor: Colors.teal[700],
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              // Navigate to profile page if needed
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose Stay Type',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.teal[900],
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<bool>(
                    title: Text('Overnight', style: TextStyle(color: Colors.teal[900])),
                    value: false,
                    groupValue: isDayUse,
                    onChanged: (val) {
                      setState(() {
                        isDayUse = false;
                      });
                    },
                    activeColor: Colors.teal[700],
                  ),
                ),
                Expanded(
                  child: RadioListTile<bool>(
                    title: Text('Day Use', style: TextStyle(color: Colors.teal[900])),
                    value: true,
                    groupValue: isDayUse,
                    onChanged: (val) {
                      setState(() {
                        isDayUse = true;
                      });
                    },
                    activeColor: Colors.teal[700],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (isDayUse)
              GestureDetector(
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: _selectedDayUseDate ?? DateTime.now(),
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
                      _selectedDayUseDate = picked;
                    });
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.teal[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.teal[200]!),
                  ),
                  child: Text(
                    _selectedDayUseDate == null
                        ? 'Select Day Use Date'
                        : 'Day Use: ${_selectedDayUseDate!.day}/${_selectedDayUseDate!.month}/${_selectedDayUseDate!.year}',
                    style: TextStyle(
                      color: Colors.teal[900],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
            else
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
                            if (_selectedCheckOut != null && _selectedCheckOut!.isBefore(picked)) {
                              _selectedCheckOut = null;
                            }
                          });
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
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
                                initialDate: _selectedCheckOut ?? _selectedCheckIn!.add(const Duration(days: 1)),
                                firstDate: _selectedCheckIn!.add(const Duration(days: 1)),
                                lastDate: DateTime.now().add(const Duration(days: 366)),
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
                        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
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
            const Spacer(),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal[700],
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                ),
                onPressed: () {
                  if (isDayUse) {
                    if (_selectedDayUseDate == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please select a day use date.')),
                      );
                      return;
                    }
                    // Handle day use search logic here
                  } else {
                    if (_selectedCheckIn == null || _selectedCheckOut == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please select check-in and check-out dates.')),
                      );
                      return;
                    }
                    // Handle overnight search logic here
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Search submitted!')),
                  );
                },
                child: const Text(
                  'Search',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}