import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

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
          constraints: const BoxConstraints(maxWidth: 1100),
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '// ABOUT ME',
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF24DB67),
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 24),
                isWide
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(flex: 3, child: _buildBiographyText()),
                          const SizedBox(width: 48),
                          Expanded(flex: 2, child: _buildStatsGrid(true)),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildBiographyText(),
                          const SizedBox(height: 40),
                          _buildStatsGrid(false),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBiographyText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Passionate Flutter Engineer & Travel Tech Specialist',
          style: GoogleFonts.spaceGrotesk(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'I am an Associate Software Engineer specializing in cross-platform mobile development with Flutter and Dart. My primary expertise revolves around Travel Technology (OTA systems), including flights, hotels, and tourist services, and integrating AI-assisted engineering into real-world projects.',
          style: GoogleFonts.spaceGrotesk(
            fontSize: 16.5,
            color: const Color(0xFF9CA3AF),
            height: 1.6,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'I leverage advanced AI coding workflows (Cursor, Claude, and Agentic scripts) to accelerate design iterations, implement strict static checks, and automate deployment tasks. Focused on clean state management models (GetX, BLoC) and high-performance scrolling metrics to deliver premium products.',
          style: GoogleFonts.spaceGrotesk(
            fontSize: 16.5,
            color: const Color(0xFF9CA3AF),
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildStatsGrid(bool isDesktop) {
    final stats = [
      {'val': '3+ Yrs', 'lbl': 'Development Experience'},
      {'val': '10+', 'lbl': 'Mobile Apps Deployed'},
      {'val': '60 FPS', 'lbl': 'Target Render Speeds'},
      {'val': '90%', 'lbl': 'Asset Memory Optimizations'},
      {'val': '100%', 'lbl': 'Clean Code and Architecture'},
      {'val': 'OTA', 'lbl': 'Flight & Hotel Domain Expert'},
    ];

    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: stats.map((s) => _buildStatCard(s['val']!, s['lbl']!, isDesktop)).toList(),
    );
  }

  Widget _buildStatCard(String value, String label, bool isDesktop) {
    final cardWidth = isDesktop ? 180.0 : 160.0;
    return Container(
      width: cardWidth,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF14161A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF1F2937),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF24DB67),
              shadows: [
                Shadow(
                  color: const Color(0xFF24DB67).withValues(alpha: 0.2),
                  blurRadius: 10,
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 13,
              color: const Color(0xFF9CA3AF),
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}
