import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("Hi, I'm Fahim Montasir Opi 👋",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          Text(
            "I'm a passionate Flutter Developer focused on building smooth, responsive mobile and web apps. I enjoy solving real-world problems with beautiful and performant UIs using Flutter, Firebase, REST APIs, and modern tools like Supabase and Git.",
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
