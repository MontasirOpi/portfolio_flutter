import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  void _downloadCV() {
    launchUrl(Uri.parse('assets/resume/fahim_montasir_cv.pdf'));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          const Text("Get in Touch", style: TextStyle(fontSize: 24)),
          const SizedBox(height: 16),
          const Text("📧 montasiropi@gmail.com"),
          const SizedBox(height: 8),
          InkWell(
              child: const Text("🔗 GitHub", style: TextStyle(color: Colors.blue)),
              onTap: () => launchUrl(Uri.parse("https://github.com/MontasirOpi"))),
          InkWell(
              child: const Text("🔗 LinkedIn", style: TextStyle(color: Colors.blue)),
              onTap: () => launchUrl(Uri.parse("https://www.linkedin.com/in/fahim-montasir-opi-161b65256/"))),
          const SizedBox(height: 20),
          ElevatedButton.icon(
              onPressed: _downloadCV,
              icon: const Icon(Icons.download),
              label: const Text("Download CV")),
        ],
      ),
    );
  }
}
