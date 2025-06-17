import 'package:flutter/material.dart';
import 'payment_page.dart';

final Color mainGreen = Colors.teal;

class BookingPage extends StatelessWidget {
  final String packageTitle;

  const BookingPage({Key? key, required this.packageTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BookingStepWhenWho(packageTitle: packageTitle);
  }
}

class BookingStepWhenWho extends StatefulWidget {
  final String packageTitle;

  const BookingStepWhenWho({Key? key, required this.packageTitle}) : super(key: key);

  @override
  State<BookingStepWhenWho> createState() => _BookingStepWhenWhoState();
}

class _BookingStepWhenWhoState extends State<BookingStepWhenWho> {
  DateTime? _checkInDate;
  DateTime? _checkOutDate;
  TimeOfDay? keyCollectionTime;
  TimeOfDay? keyReturnTime;
  int adults = 1;
  int children = 0;
  int infants = 0;

  String _formatDate(DateTime? d) => d == null ? "Select date" : "${d.day}/${d.month}/${d.year}";
  String _formatTime(TimeOfDay? t) => t == null ? "Select time" : "${t.format(context)}";

  bool get canProceed =>
      _checkInDate != null &&
      _checkOutDate != null &&
      _checkOutDate!.isAfter(_checkInDate!) &&
      keyCollectionTime != null &&
      keyReturnTime != null;

  Future<void> _selectDate(BuildContext context, bool isCheckIn) async {
    final now = DateTime.now();
    final DateTime firstDate = isCheckIn ? now : (_checkInDate ?? now);
    final DateTime initialDate = isCheckIn
        ? (_checkInDate ?? now)
        : (_checkOutDate ??
            (_checkInDate != null
                ? _checkInDate!.add(const Duration(days: 1))
                : now.add(const Duration(days: 1))));
    final DateTime lastDate = DateTime(now.year + 2);

    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: isCheckIn
          ? firstDate
          : (_checkInDate ?? firstDate).add(const Duration(days: 1)),
      lastDate: lastDate,
    );
    if (picked != null) {
      setState(() {
        if (isCheckIn) {
          _checkInDate = picked;
          if (_checkOutDate != null && !_checkOutDate!.isAfter(picked)) {
            _checkOutDate = null;
            keyReturnTime = null;
          }
        } else {
          _checkOutDate = picked;
        }
      });
    }
  }

  Future<void> _selectTime(BuildContext context, bool isCollection) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      helpText: isCollection
          ? 'Select the time you want to pick up the key (Check-in Time)'
          : 'Select the time you want to return the key (Check-out Time)',
      confirmText: 'CONFIRM',
      cancelText: 'CANCEL',
    );
    if (picked != null) {
      setState(() {
        if (isCollection) {
          keyCollectionTime = picked;
        } else {
          keyReturnTime = picked;
        }
      });
    }
  }

  Widget _greenDot() => Container(
        width: 10, height: 10, margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(color: mainGreen, shape: BoxShape.circle),
      );

  Widget _guestRowTile({
    required String label,
    required int value,
    required VoidCallback onAdd,
    required VoidCallback? onRemove,
    required String ageInfo,
  }) =>
      Padding(
        padding: const EdgeInsets.only(left: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: const EdgeInsets.only(left: 0, right: 0),
              title: Row(
                children: [
                  _greenDot(),
                  Text(label, style: const TextStyle(fontSize: 16)),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _greenCircleButton(
                    icon: Icons.remove,
                    onPressed: onRemove ?? () {},
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text('$value',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                  _greenCircleButton(
                    icon: Icons.add,
                    onPressed: onAdd,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, bottom: 4),
              child: Text(
                ageInfo,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      );

  Widget _greenCircleButton(
      {required IconData icon, required VoidCallback onPressed}) {
    return InkResponse(
      onTap: onPressed,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: mainGreen,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }

  Widget _dateRowTile({
    required String label,
    required DateTime? date,
    required VoidCallback onPressed,
  }) =>
      ListTile(
        title: Row(
          children: [
            _greenDot(),
            Text(label, style: const TextStyle(fontSize: 16)),
          ],
        ),
        subtitle: Text(_formatDate(date)),
        trailing: IconButton(
          icon: const Icon(Icons.calendar_today, color: Colors.teal),
          tooltip: "Select date",
          onPressed: onPressed,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Booking',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: mainGreen,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              const Text(
                "------------Booking Details------------",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 24),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "When",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _dateRowTile(
                label: 'Check-in Date',
                date: _checkInDate,
                onPressed: () => _selectDate(context, true),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 32.0),
                child: ListTile(
                  leading: const Icon(Icons.vpn_key, color: Colors.amber),
                  title: const Text('Key Collection (Check-in Time)'),
                  subtitle: keyCollectionTime == null
                      ? null
                      : Text(_formatTime(keyCollectionTime)),
                  trailing: IconButton(
                    icon: const Icon(Icons.access_time, color: Colors.teal),
                    tooltip: "Select time",
                    onPressed: () => _selectTime(context, true),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 48.0, right: 16, bottom: 12),
                child: const Text(
                  "Please select the time when you want to collect the key.",
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ),
              _dateRowTile(
                label: 'Check-out Date',
                date: _checkOutDate,
                onPressed: () => _selectDate(context, false),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 32.0),
                child: ListTile(
                  leading: const Icon(Icons.vpn_key, color: Colors.amber),
                  title: const Text('Key Return (Check-out Time)'),
                  subtitle: keyReturnTime == null
                      ? null
                      : Text(_formatTime(keyReturnTime)),
                  trailing: IconButton(
                    icon: const Icon(Icons.access_time, color: Colors.teal),
                    tooltip: "Select time",
                    onPressed: () => _selectTime(context, false),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 48.0, right: 16, bottom: 12),
                child: const Text(
                  "Please select the time when you want to return the key.",
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 16),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Who",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              _guestRowTile(
                label: 'Adults',
                value: adults,
                onAdd: () => setState(() => adults++),
                onRemove: adults > 1 ? () => setState(() => adults--) : null,
                ageInfo: 'Age 13 and above',
              ),
              _guestRowTile(
                label: 'Children',
                value: children,
                onAdd: () => setState(() => children++),
                onRemove: children > 0 ? () => setState(() => children--) : null,
                ageInfo: 'Age below 13',
              ),
              _guestRowTile(
                label: 'Infants',
                value: infants,
                onAdd: () => setState(() => infants++),
                onRemove: infants > 0 ? () => setState(() => infants--) : null,
                ageInfo: 'Age 0 to 2',
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: canProceed
                          ? () {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  pageBuilder: (context, animation, secondaryAnimation) =>
                                      BookingStepAdditionalOptions(
                                        packageTitle: widget.packageTitle,
                                        checkInDate: _checkInDate!,
                                        checkOutDate: _checkOutDate!,
                                        keyCollectionTime: keyCollectionTime!,
                                        keyReturnTime: keyReturnTime!,
                                        adults: adults,
                                        children: children,
                                        infants: infants,
                                      ),
                                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                    return FadeTransition(opacity: animation, child: child);
                                  },
                                  transitionDuration: const Duration(milliseconds: 400),
                                ),
                              );
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: canProceed ? mainGreen : null,
                      ),
                      child: Text(
                        'Next',
                        style: TextStyle(
                          color: canProceed ? mainGreen : null,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BookingStepAdditionalOptions extends StatefulWidget {
  final String packageTitle;
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final TimeOfDay keyCollectionTime;
  final TimeOfDay keyReturnTime;
  final int adults;
  final int children;
  final int infants;

  const BookingStepAdditionalOptions({
    Key? key,
    required this.packageTitle,
    required this.checkInDate,
    required this.checkOutDate,
    required this.keyCollectionTime,
    required this.keyReturnTime,
    required this.adults,
    required this.children,
    required this.infants,
  }) : super(key: key);

  @override
  State<BookingStepAdditionalOptions> createState() => _BookingStepAdditionalOptionsState();
}

class _BookingStepAdditionalOptionsState extends State<BookingStepAdditionalOptions> {
  bool petAllowed = false;
  bool breakfastProvided = false;
  bool needExtraBed = false;
  String? additionalOptionsText;
  bool agreeToTerms = false;

  void _showSummaryDialog() {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierDismissible: true,
        barrierColor: Colors.black38,
        pageBuilder: (context, animation, secondaryAnimation) =>
          BookingSummaryDialog(
            packageTitle: widget.packageTitle,
            checkInDate: widget.checkInDate,
            checkOutDate: widget.checkOutDate,
            keyCollectionTime: widget.keyCollectionTime,
            keyReturnTime: widget.keyReturnTime,
            adults: widget.adults,
            children: widget.children,
            infants: widget.infants,
            petAllowed: petAllowed,
            breakfastProvided: breakfastProvided,
            needExtraBed: needExtraBed,
            additionalOptionsText: additionalOptionsText,
            mainGreen: mainGreen,
          ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 400),
      ),
    );
  }

  Widget _customGreenCheckboxTile({
    required bool value,
    required ValueChanged<bool?> onChanged,
    required String title,
    required IconData icon,
  }) {
    return InkWell(
      onTap: () => onChanged(!value),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: value ? mainGreen.withOpacity(0.2) : Colors.transparent,
          border: Border.all(
            color: value ? mainGreen : Colors.grey.shade300,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Checkbox(
              value: value,
              onChanged: onChanged,
              activeColor: mainGreen,
              checkColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  color: value ? mainGreen : Colors.black87,
                  fontWeight: value ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Icon(
                icon,
                color: mainGreen,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Booking',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: mainGreen,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 32),
              const Text(
                "Additional Options",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 18),
              _customGreenCheckboxTile(
                value: petAllowed,
                onChanged: (val) => setState(() => petAllowed = val ?? false),
                title: "Pet Allowed",
                icon: Icons.pets,
              ),
              _customGreenCheckboxTile(
                value: breakfastProvided,
                onChanged: (val) => setState(() => breakfastProvided = val ?? false),
                title: "Breakfast Provided",
                icon: Icons.bakery_dining,
              ),
              _customGreenCheckboxTile(
                value: needExtraBed,
                onChanged: (val) => setState(() => needExtraBed = val ?? false),
                title: "Need Extra Bed",
                icon: Icons.bed,
              ),
              const SizedBox(height: 32),
              const Text(
                "Special Requirements",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 18),
              TextField(
                minLines: 2,
                maxLines: 6,
                decoration: InputDecoration(
                  labelText: 'Special Requirements (optional)',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onChanged: (val) => setState(() {
                  additionalOptionsText = val;
                }),
              ),
              const SizedBox(height: 32),
              const Text(
                "Terms & Confirmation",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 12),
              Theme(
                data: Theme.of(context).copyWith(
                  checkboxTheme: CheckboxThemeData(
                    fillColor: MaterialStateProperty.all(mainGreen),
                    checkColor: MaterialStateProperty.all(Colors.white),
                  ),
                ),
                child: CheckboxListTile(
                  value: agreeToTerms,
                  onChanged: (val) => setState(() => agreeToTerms = val ?? false),
                  title: const Text("I agree to the homestay rules and terms."),
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: mainGreen,
                  checkColor: Colors.white,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: agreeToTerms
                    ? _showSummaryDialog
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: mainGreen,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Confirm Booking'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BookingSummaryDialog extends StatelessWidget {
  final String packageTitle;
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final TimeOfDay keyCollectionTime;
  final TimeOfDay keyReturnTime;
  final int adults;
  final int children;
  final int infants;
  final bool petAllowed;
  final bool breakfastProvided;
  final bool needExtraBed;
  final String? additionalOptionsText;
  final Color mainGreen;

  const BookingSummaryDialog({
    Key? key,
    required this.packageTitle,
    required this.checkInDate,
    required this.checkOutDate,
    required this.keyCollectionTime,
    required this.keyReturnTime,
    required this.adults,
    required this.children,
    required this.infants,
    required this.petAllowed,
    required this.breakfastProvided,
    required this.needExtraBed,
    required this.additionalOptionsText,
    required this.mainGreen,
  }) : super(key: key);

  String _formatDate(DateTime? d) =>
      d == null ? "Select date" : "${d.day}/${d.month}/${d.year}";
  String _formatTime(TimeOfDay? t) =>
      t == null ? "Select time" : "${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}";

  Widget _row(String label, String value) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 132,
              child: Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.teal,
                ),
              ),
            ),
            Expanded(
              child: Text(
                value,
                style: const TextStyle(
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Booking Summary',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 16),
                _row('Homestay:', packageTitle),
                _row(
                  'Check-in:',
                  "${_formatDate(checkInDate)} ${_formatTime(keyCollectionTime)}",
                ),
                _row(
                  'Check-out:',
                  "${_formatDate(checkOutDate)} ${_formatTime(keyReturnTime)}",
                ),
                _row('Adults:', '$adults'),
                _row('Children:', '$children'),
                _row('Infants:', '$infants'),
                _row('Pet Allowed:', petAllowed ? "Yes" : "No"),
                _row('Breakfast Provided:', breakfastProvided ? "Yes" : "No"),
                _row('Need Extra Bed:', needExtraBed ? "Yes" : "No"),
                _row(
                  'Special Requirements:',
                  (additionalOptionsText?.isNotEmpty == true)
                      ? additionalOptionsText!
                      : "-",
                ),
                const SizedBox(height: 28),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      int totalGuests = adults + children + infants;
                      int totalNights = checkOutDate.difference(checkInDate).inDays;

                      double pricePerGuestPerNight = 70.0;
                      double totalAmount = totalGuests * pricePerGuestPerNight * totalNights;

                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) {
                            return PaymentPage(
                              packageTitle: packageTitle,
                              checkInDate: checkInDate,
                              checkOutDate: checkOutDate,
                              guests: totalGuests,
                              totalAmount: totalAmount,
                            );
                          },
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            return FadeTransition(opacity: animation, child: child);
                          },
                          transitionDuration: const Duration(milliseconds: 400),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mainGreen,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Make Payment'),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      'Back',
                      style: TextStyle(
                        color: mainGreen,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Null get newMethod => null;
}