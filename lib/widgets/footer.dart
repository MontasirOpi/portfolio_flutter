import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32),
      decoration: const BoxDecoration(
        color: Color(0xFF0C0E12),
        border: Border(top: BorderSide(color: Color(0xFF1F2937))),
      ),
      child: Center(
        child: Text(
          "© 2026 Fahim Montasir Opi",
          style: GoogleFonts.jetBrainsMono(
            color: const Color(0xFF9CA3AF),
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
