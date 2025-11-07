
import 'package:flutter/material.dart';
import 'package:padosi/screens/daily_limit_screen.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TimeManagementScreen extends StatefulWidget {
  const TimeManagementScreen({super.key});

  @override
  State<TimeManagementScreen> createState() => _TimeManagementScreenState();
}

class _TimeManagementScreenState extends State<TimeManagementScreen> {
  bool _sleepMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Time Management'),
      ),
      body: ListView(
        children: [
          _buildDailyAverage(context),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.timer_outlined),
            title: const Text('Daily limit'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DailyLimitScreen()),
              );
            },
          ),
          SwitchListTile(
            secondary: const Icon(Icons.nights_stay_outlined),
            title: const Text('Sleep mode'),
            value: _sleepMode,
            onChanged: (bool value) {
              setState(() {
                _sleepMode = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDailyAverage(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData('Mon', 2.5),
      ChartData('Tue', 3.0),
      ChartData('Wed', 1.5),
      ChartData('Thu', 4.0),
      ChartData('Fri', 2.0),
      ChartData('Sat', 5.0),
      ChartData('Sun', 3.5),
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 0,
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Daily average',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                '2h 30m', // Placeholder value
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 150,
                child: SfCartesianChart(
                  primaryXAxis: const CategoryAxis(),
                  series: <CartesianSeries>[
                    ColumnSeries<ChartData, String>(
                      dataSource: chartData,
                      xValueMapper: (ChartData data, _) => data.day,
                      yValueMapper: (ChartData data, _) => data.hours,
                      // Optional: customize bar appearance
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Per day using app on this device in the last week',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.day, this.hours);
  final String day;
  final double hours;
}
