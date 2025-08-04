import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        "© 2025 Fahim Montasir Opi",
        style: TextStyle(color: Colors.grey[600]),
      ),
    );
  }
}
