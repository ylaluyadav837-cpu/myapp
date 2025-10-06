import 'package:flutter/material.dart';

class NeedsScreen extends StatelessWidget {
  const NeedsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Needs'),
      ),
      body: const Center(
        child: Text('This is the Needs screen.'),
      ),
    );
  }
}
