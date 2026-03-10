import 'package:flutter/material.dart';
import 'package:lost_and_found/utils/app_theme.dart';
import 'package:intl/intl.dart'; // Add intl: ^0.19.0 to your pubspec.yaml

class AdminLogsScreen extends StatefulWidget {
  const AdminLogsScreen({super.key});

  @override
  State<AdminLogsScreen> createState() => _AdminLogsScreenState();
}

class _AdminLogsScreenState extends State<AdminLogsScreen> {
  DateTimeRange? selectedDateRange;

  // Function to open the Date Picker
  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2023),
      lastDate: DateTime.now(),
      initialDateRange: selectedDateRange,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppTheme.primaryBlue,
              onPrimary: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        selectedDateRange = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction Logs',
            style: TextStyle(color: Colors.white)),
        backgroundColor: AppTheme.primaryBlue,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          // ── Date Filter Header ──────────────────────────────────────────
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Filter by Date:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(
                      selectedDateRange == null
                          ? 'Showing all records'
                          : '${DateFormat('MMM dd').format(selectedDateRange!.start)} - ${DateFormat('MMM dd').format(selectedDateRange!.end)}',
                      style: const TextStyle(color: AppTheme.textGrey),
                    ),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: () => _selectDateRange(context),
                  icon: const Icon(Icons.calendar_today, size: 18),
                  label: const Text('Select Date'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryBlue,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),

          // ── The Log List ────────────────────────────────────────────────
          Expanded(
            child: ListView.builder(
              itemCount: 5, // Replace with your actual database list length
              itemBuilder: (context, index) {
                return _LogTile(
                  itemName: "Black Wallet",
                  receiver: "John Doe",
                  date: DateTime.now(),
                  status: "Claimed",
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ── Log Tile Widget ───────────────────────────────────────────────────────
class _LogTile extends StatelessWidget {
  final String itemName;
  final String receiver;
  final DateTime date;
  final String status;

  const _LogTile({
    required this.itemName,
    required this.receiver,
    required this.date,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: AppTheme.bgLight,
          child: Icon(Icons.receipt_long, color: AppTheme.primaryBlue),
        ),
        title:
            Text(itemName, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(
            'Claimed by: $receiver\non ${DateFormat('yyyy-MM-dd').format(date)}'),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.green.shade100,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text('SUCCESS',
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 10,
                  fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
