
import 'package:flutter/material.dart';

class ColorSelectionScreen extends StatelessWidget {
  const ColorSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Color'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
        ),
        itemCount: Colors.primaries.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Set the selected color as the chat background
            },
            child: CircleAvatar(
              backgroundColor: Colors.primaries[index],
            ),
          );
        },
      ),
    );
  }
}
