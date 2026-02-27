import 'package:flutter/material.dart';

class DiagnosticButton extends StatelessWidget {
  const DiagnosticButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey.shade900,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {
          // Navigate to diagnosis screen later
        },
        child: const Text("Start Diagnosis", style: TextStyle(fontSize: 16)),
      ),
    );
  }
}
