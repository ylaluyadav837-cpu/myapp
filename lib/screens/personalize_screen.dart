
import 'package:flutter/material.dart';

class PersonalizeScreen extends StatelessWidget {
  const PersonalizeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personalize'),
      ),
      body: const Center(
        child: Text('Personalize Screen'),
      ),
    );
  }
}
