import 'package:flutter/material.dart';
import 'package:portfolio_flutter/pages/fun_fact_page.dart';
import 'package:portfolio_flutter/pages/skill_page.dart';
import 'package:portfolio_flutter/widgets/footer.dart';
import 'package:portfolio_flutter/widgets/nav_bar.dart';

import 'about_page.dart';
import 'projects_page.dart';
import 'contact_page.dart';


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
            const SkillsPage(),
            const FunFactsPage(),
            const ContactPage(),
            const Footer(),
          ],
        ),
      ),
    );
  }
}
