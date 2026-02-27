import 'package:flutter/material.dart';

class EmergencyButton extends StatelessWidget {
  const EmergencyButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.red,
      elevation: 8,
      onPressed: () {
        // Navigate to emergency mode (later)
      },
      child: const Icon(Icons.warning_amber_rounded, size: 32),
    );
  }
}
