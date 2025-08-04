import 'package:flutter/material.dart';
import '../widgets/nav_bar.dart';
import 'about_page.dart';
import 'projects_page.dart';
import 'contact_page.dart';
import '../widgets/footer.dart';

class HomePage extends StatelessWidget {
  final VoidCallback toggleTheme;
  final bool isDarkMode;

  const HomePage({super.key, required this.toggleTheme, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            NavBar(toggleTheme: toggleTheme, isDarkMode: isDarkMode),
            const AboutPage(),
            const ProjectsPage(),
            const ContactPage(),
            const Footer(),
          ],
        ),
      ),
    );
  }
}
