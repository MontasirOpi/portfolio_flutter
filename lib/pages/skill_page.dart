import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SkillsPage extends StatefulWidget {
  const SkillsPage({super.key});

  @override
  State<SkillsPage> createState() => _SkillsPageState();
}

class _SkillsPageState extends State<SkillsPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  final List<Map<String, dynamic>> _skillCategories = [
    {
      'title': 'MOBILE DEVELOPMENT',
      'icon': Icons.phone_android_rounded,
      'skills': ['Flutter', 'Dart', 'Android Dev', 'Responsive Design', 'GetX State Management'],
    },
    {
      'title': 'BACKEND & APIS',
      'icon': Icons.cloud_queue_rounded,
      'skills': ['REST APIs', 'JSON Serialization', 'Firebase Cloud', 'User Authentication', 'Push Notifications'],
    },
    {
      'title': 'DATABASES & CACHE',
      'icon': Icons.storage_rounded,
      'skills': ['SQLite Local', 'Hive Database', 'Shared Preferences'],
    },
    {
      'title': 'DEVOPS & DEPLOYMENT',
      'icon': Icons.sync_rounded,
      'skills': ['Git / Version Control', 'GitHub Actions', 'Play Store Console', 'App Store Connect', 'CI/CD Pipelines'],
    },
    {
      'title': 'TRAVEL TECHNOLOGY (OTA)',
      'icon': Icons.flight_takeoff_rounded,
      'skills': [
        'Flight Booking Systems',
        'Hotel Booking Systems',
        'Transfer Modules',
        'Insurance Modules',
        'eSIM API Integration',
        'B2B & B2C Platforms'
      ],
    },
    {
      'title': 'AI-ASSISTED DEVELOPMENT',
      'icon': Icons.smart_toy_outlined,
      'skills': [
        'Cursor AI Orchestration',
        'Agentic AI Workflows',
        'Coding Assistants',
        'Prompt Engineering',
        'Local LLM Deployment',
        'Ollama Server',
        'Open Source Models',
        'AI Automated Code Review',
        'AI Debugging & Diagnostics',
        'Multi-Agent Systems',
        'MCP Server Integrations'
      ],
    },
    {
      'title': 'AI TOOLS & PLATFORMS',
      'icon': Icons.psychology_outlined,
      'skills': ['Claude 3.5 Sonnet', 'GPT-4o / OpenAI', 'Gemini Pro', 'Cursor IDE', 'GitHub Copilot', 'OpenRouter APIs', 'Local Llama models'],
    },
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
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

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isWide ? 64 : 24,
        vertical: 80,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 48),
                _buildSkillsGrid(isWide),
              ],
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
          '// TECHNICAL SKILLS',
          style: GoogleFonts.jetBrainsMono(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF24DB67),
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Categorized competencies in Flutter engineering, travel systems, and AI development.',
          style: GoogleFonts.spaceGrotesk(
            fontSize: 16,
            color: const Color(0xFF9CA3AF),
          ),
        ),
      ],
    );
  }

  Widget _buildSkillsGrid(bool isWide) {
    return Wrap(
      spacing: 24,
      runSpacing: 24,
      children: _skillCategories.map((category) {
        // Expand AI-assisted card to span wider space for visual hierarchy
        final isAI = category['title'].toString().contains('AI-ASSISTED');
        final double cardWidth;
        if (isWide) {
          cardWidth = isAI ? 744.0 : 360.0;
        } else {
          cardWidth = double.infinity;
        }

        return Container(
          width: cardWidth,
          decoration: BoxDecoration(
            color: const Color(0xFF14161A),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isAI ? const Color(0xFF24DB67).withValues(alpha: 0.3) : const Color(0xFF1F2937),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.25),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.all(28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Category Header
              Row(
                children: [
                  Icon(
                    category['icon'] as IconData,
                    color: const Color(0xFF24DB67),
                    size: 26,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      category['title'] as String,
                      style: GoogleFonts.jetBrainsMono(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(height: 1, color: const Color(0xFF1F2937)),
              const SizedBox(height: 20),
              // Chips Wrap
              Wrap(
                spacing: 8,
                runSpacing: 10,
                children: (category['skills'] as List<String>).map((skill) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0C0E12),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: const Color(0xFF1F2937),
                        width: 1.0,
                      ),
                    ),
                    child: Text(
                      skill,
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 13.5,
                        color: const Color(0xFFE0E6EB),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
