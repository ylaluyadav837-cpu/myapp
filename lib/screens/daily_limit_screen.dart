
import 'package:flutter/material.dart';

class DailyLimitScreen extends StatefulWidget {
  const DailyLimitScreen({super.key});

  @override
  State<DailyLimitScreen> createState() => _DailyLimitScreenState();
}

class _DailyLimitScreenState extends State<DailyLimitScreen> {
  Duration _selectedTime = const Duration(hours: 2, minutes: 30);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Limit'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              _selectedTime.inHours >= 24 ? 'Full Day' : '${_selectedTime.inHours}h ${_selectedTime.inMinutes.remainder(60)}m',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              alignment: WrapAlignment.center,
              children: [
                _buildTimeChip(const Duration(minutes: 30)),
                _buildTimeChip(const Duration(hours: 1)),
                _buildTimeChip(const Duration(hours: 1, minutes: 30)),
                _buildTimeChip(const Duration(hours: 2)),
                _buildTimeChip(const Duration(hours: 2, minutes: 30)),
                _buildTimeChip(const Duration(hours: 3)),
                _buildTimeChip(const Duration(hours: 24)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeChip(Duration duration) {
    String label;
    if (duration.inHours >= 24) {
      label = 'Full Day';
    } else {
      label = '${duration.inHours > 0 ? '${duration.inHours}h' : ''} ${duration.inMinutes.remainder(60)}m'.trim();
    }
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTime = duration;
        });
      },
      child: Chip(
        label: Text(label),
        backgroundColor: _selectedTime == duration
            ? Theme.of(context).primaryColor
            : Theme.of(context).chipTheme.backgroundColor,
        labelStyle: TextStyle(
          color: _selectedTime == duration
              ? Theme.of(context).colorScheme.onPrimary
              : Theme.of(context).chipTheme.labelStyle?.color,
        ),
      ),
    );
  }
}
