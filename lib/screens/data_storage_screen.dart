
import 'package:flutter/material.dart';

class DataStorageScreen extends StatefulWidget {
  const DataStorageScreen({super.key});

  @override
  State<DataStorageScreen> createState() => _DataStorageScreenState();
}

class _DataStorageScreenState extends State<DataStorageScreen> {
  String _uploadQuality = 'Medium';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data and Storage'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Storage usage'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to storage usage screen
            },
          ),
          ListTile(
            title: const Text('Media upload quality'),
            subtitle: Text(_uploadQuality),
            onTap: () => _showUploadQualityDialog(context),
          ),
        ],
      ),
    );
  }

  void _showUploadQualityDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Media upload quality'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<String>(
                title: const Text('Low'),
                value: 'Low',
                groupValue: _uploadQuality,
                onChanged: (value) {
                  setState(() {
                    _uploadQuality = value!;
                  });
                  Navigator.of(context).pop();
                },
              ),
              RadioListTile<String>(
                title: const Text('Medium'),
                value: 'Medium',
                groupValue: _uploadQuality,
                onChanged: (value) {
                  setState(() {
                    _uploadQuality = value!;
                  });
                  Navigator.of(context).pop();
                },
              ),
              RadioListTile<String>(
                title: const Text('High'),
                value: 'High',
                groupValue: _uploadQuality,
                onChanged: (value) {
                  setState(() {
                    _uploadQuality = value!;
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
