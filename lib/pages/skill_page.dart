import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SkillsPage extends StatefulWidget {
  const SkillsPage({super.key});

  @override
  State<SkillsPage> createState() => _SkillsPageState();
}

class _SkillsPageState extends State<SkillsPage> with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _startAnimations();
  }

  void _startAnimations() async {
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isWide = size.width > 900;

    final programmingLanguages = [
      {'name': 'Dart', 'icon': Icons.code_rounded, 'level': 0.9},
      {'name': 'Python', 'icon': Icons.terminal_rounded, 'level': 0.85},
      {'name': 'JavaScript', 'icon': Icons.javascript_rounded, 'level': 0.8},
      {'name': 'C++', 'icon': Icons.memory_rounded, 'level': 0.75},
    ];

    final frameworks = [
      {'name': 'Flutter', 'icon': Icons.flutter_dash_rounded, 'level': 0.9},
      {'name': 'React', 'icon': Icons.web_rounded, 'level': 0.8},
    ];

    final databases = [
      {'name': 'Firebase', 'icon': Icons.cloud_rounded, 'level': 0.85},
      {'name': 'Supabase', 'icon': Icons.storage_rounded, 'level': 0.8},
      {'name': 'MongoDB', 'icon': Icons.dns_rounded, 'level': 0.75},
    ];

    final ides = [
      {'name': 'VS Code', 'icon': Icons.code_off_rounded, 'level': 0.9},
      {'name': 'Android Studio', 'icon': Icons.android_rounded, 'level': 0.85},
      {'name': 'Cursor', 'icon': Icons.edit_rounded, 'level': 0.8},
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: FadeTransition(
            opacity: _controller,
            child: SlideTransition(
              position: Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero)
                  .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   _buildHeader(),
                   const SizedBox(height: 48),
                   isWide
                       ? Row(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Expanded(child: _buildSkillCategory('// LANGUAGES', programmingLanguages)),
                             const SizedBox(width: 32),
                             Expanded(child: _buildSkillCategory('// FRAMEWORKS', frameworks)),
                           ],
                         )
                       : Column(
                           children: [
                             _buildSkillCategory('// LANGUAGES', programmingLanguages),
                             const SizedBox(height: 32),
                             _buildSkillCategory('// FRAMEWORKS', frameworks),
                           ],
                         ),
                   const SizedBox(height: 32),
                   isWide
                       ? Row(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Expanded(child: _buildSkillCategory('// DATABASES', databases)),
                             const SizedBox(width: 32),
                             Expanded(child: _buildSkillCategory('// TOOLS', ides)),
                           ],
                         )
                       : Column(
                           children: [
                             _buildSkillCategory('// DATABASES', databases),
                             const SizedBox(height: 32),
                             _buildSkillCategory('// TOOLS', ides),
                           ],
                         ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '// SKILLS',
          style: GoogleFonts.jetBrainsMono(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF24DB67),
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'My technical stack and proficiency levels.',
          style: GoogleFonts.spaceGrotesk(
            fontSize: 16,
            color: const Color(0xFF9CA3AF),
          ),
        ),
      ],
    );
  }

  Widget _buildSkillCategory(String title, List<Map<String, dynamic>> skills) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: const Color(0xFF14161A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF1F2937)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.jetBrainsMono(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 24),
          ...skills.map(
            (skill) => Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: _buildSkillItem(skill['name'], skill['icon'], skill['level']),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillItem(String name, IconData icon, double level) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF24DB67), size: 24),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '${(level * 100).toInt()}%',
                    style: GoogleFonts.jetBrainsMono(
                      fontSize: 14,
                      color: const Color(0xFF9CA3AF),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: TweenAnimationBuilder<double>(
                  duration: const Duration(milliseconds: 1200),
                  curve: Curves.easeOutCubic,
                  tween: Tween<double>(begin: 0, end: level),
                  builder: (context, value, child) {
                    return LinearProgressIndicator(
                      value: value,
                      backgroundColor: const Color(0xFF0C0E12),
                      valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF24DB67)),
                      minHeight: 6,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
