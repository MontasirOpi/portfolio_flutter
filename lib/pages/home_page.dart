import 'package:flutter/material.dart';
import 'package:portfolio_flutter/pages/hero_section.dart';
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
  // 6 sections: Hero, About, Projects, Experience, Skills, Contact
  final List<GlobalKey> _sectionKeys = List.generate(6, (_) => GlobalKey());

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HeroSection(onViewProjects: () => _navigateToSection(2)), // Index 2: Projects
      const AboutPage(),
      const ProjectsPage(),
      const WorkExperiencePage(),
      const SkillsPage(),
      const ContactPage(),
    ];
  }

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
                    Container(
                      key: _sectionKeys[i],
                      child: DeferredSection(
                        delay: Duration(milliseconds: 150 * i), // Stagger page rendering to defer layout pressure
                        child: _pages[i],
                      ),
                    ),
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

/// A wrapper widget that defers the building of heavy page trees
/// to separate frames, improving initial frame rendering speed.
class DeferredSection extends StatefulWidget {
  final Widget child;
  final Duration delay;

  const DeferredSection({
    super.key,
    required this.child,
    required this.delay,
  });

  @override
  State<DeferredSection> createState() => _DeferredSectionState();
}

class _DeferredSectionState extends State<DeferredSection> {
  bool _shouldRender = false;

  @override
  void initState() {
    super.initState();
    if (widget.delay == Duration.zero) {
      _shouldRender = true;
    } else {
      Future.delayed(widget.delay, () {
        if (mounted) {
          setState(() {
            _shouldRender = true;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_shouldRender) {
      return widget.child;
    }
    // Lightweight placeholder size to reserve coordinate offsets for scroll navigation
    return const SizedBox(
      height: 400,
      child: Center(
        child: CircularProgressIndicator(
          color: Color(0xFF24DB67),
          strokeWidth: 2,
        ),
      ),
    );
  }
}
