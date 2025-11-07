
import 'package:flutter/material.dart';

class EkycScreen extends StatelessWidget {
  const EkycScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('eKYC Verification'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Icon(
                Icons.shield_outlined,
                size: 100,
                color: Colors.blue,
              ),
              const SizedBox(height: 20),
              Text(
                'Verify Your Identity',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 10),
              const Text(
                'To complete your eKYC, please have your documents ready for a quick and secure verification process.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // TODO: Implement the eKYC process
                },
                child: const Text('Start Verification'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
