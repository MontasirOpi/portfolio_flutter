import 'package:flutter/material.dart';
import 'package:portfolio_flutter/pages/interests_activities_page.dart';
import 'package:portfolio_flutter/pages/skill_page.dart';
import 'package:portfolio_flutter/pages/work_experience_page.dart';
import 'package:portfolio_flutter/widgets/footer.dart';
import 'package:portfolio_flutter/widgets/nav_bar.dart';
import 'about_page.dart';
import 'projects_page.dart';
import 'contact_page.dart';

class HomePage extends StatefulWidget {
  final VoidCallback toggleTheme;
  final bool isDarkMode;

  const HomePage({
    super.key,
    required this.toggleTheme,
    required this.isDarkMode,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final ScrollController _scrollController = ScrollController();
  // 6 sections: About, Projects, Skills, Experience, Interests, Contact
  final List<GlobalKey> _sectionKeys = List.generate(6, (_) => GlobalKey());

  final List<Widget> _pages = [
    const AboutPage(),
    ProjectsPage(),
    const SkillsPage(),
    const WorkExperiencePage(),
    const InterestsActivitiesPage(),
    const ContactPage(),
  ];

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _navigateToSection(int index) {
    setState(() {
      _currentIndex = index;
    });

    final context = _sectionKeys[index].currentContext;
    if (context != null) {
      final box = context.findRenderObject() as RenderBox?;
      if (box != null) {
        final position = box.localToGlobal(Offset.zero).dy;
        final scrollPosition = _scrollController.position.pixels;

        _scrollController.animateTo(
          scrollPosition + position - 80,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          NavBar(
            toggleTheme: widget.toggleTheme,
            isDarkMode: widget.isDarkMode,
            onNavigate: _navigateToSection,
            currentIndex: _currentIndex,
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  for (int i = 0; i < _pages.length; i++)
                    Container(key: _sectionKeys[i], child: _pages[i]),
                  const Footer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
