import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InterestsActivitiesPage extends StatefulWidget {
  const InterestsActivitiesPage({super.key});

  @override
  State<InterestsActivitiesPage> createState() =>
      _InterestsActivitiesPageState();
}

class _InterestsActivitiesPageState extends State<InterestsActivitiesPage>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 800), vsync: this);
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

    final learningTopics = [
      {
        'icon': Icons.code_rounded,
        'title': 'Python',
        'description': 'Advanced Python programming & libraries',
        'progress': 0.7,
      },
      {
        'icon': Icons.emoji_events_rounded,
        'title': 'Competitive Programming',
        'description': 'DSA, algorithms & problem solving',
        'progress': 0.6,
      },
      {
        'icon': Icons.cloud_rounded,
        'title': 'Cloud Architecture',
        'description': 'AWS, GCP, Azure services',
        'progress': 0.5,
      },
      {
        'icon': Icons.smart_toy_rounded,
        'title': 'AI/ML Integration',
        'description': 'TensorFlow, ML models in apps',
        'progress': 0.4,
      },
    ];

    final interests = [
      {
        'icon': Icons.psychology_rounded,
        'title': 'Problem Solving',
        'description': 'Love tackling complex algorithmic challenges',
      },
      {
        'icon': Icons.devices_rounded,
        'title': 'Cross-Platform',
        'description': 'Building apps that work everywhere',
      },
      {
        'icon': Icons.design_services_rounded,
        'title': 'UI/UX Design',
        'description': 'Creating beautiful and intuitive interfaces',
      },
      {
        'icon': Icons.rocket_launch_rounded,
        'title': 'Performance',
        'description': 'Making apps faster and more efficient',
      },
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: FadeTransition(
            opacity: _controller,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '// LEARNING & INTERESTS',
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF24DB67),
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'My journey of continuous growth and exploration.',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 16,
                    color: const Color(0xFF9CA3AF),
                  ),
                ),
                const SizedBox(height: 48),
                Text(
                  '// CURRENTLY LEARNING',
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 24),
                Wrap(
                  spacing: 24,
                  runSpacing: 24,
                  children: learningTopics.map((topic) {
                    return SizedBox(
                      width: isWide ? 350 : double.infinity,
                      child: _buildLearningCard(topic),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 48),
                Text(
                  '// PASSIONS',
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 24),
                Wrap(
                  spacing: 24,
                  runSpacing: 24,
                  children: interests.map((interest) {
                    return SizedBox(
                      width: isWide ? 350 : double.infinity,
                      child: _buildInterestCard(interest),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLearningCard(Map<String, dynamic> topic) {
    double progress = topic['progress'];
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF14161A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF1F2937)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(topic['icon'], color: const Color(0xFF24DB67), size: 28),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  topic['title'],
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            topic['description'],
            style: GoogleFonts.spaceGrotesk(
              fontSize: 14,
              color: const Color(0xFF9CA3AF),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Progress',
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 12,
                  color: const Color(0xFF9CA3AF),
                ),
              ),
              Text(
                '${(progress * 100).toInt()}%',
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 12,
                  color: const Color(0xFF24DB67),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: const Color(0xFF0C0E12),
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF24DB67)),
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInterestCard(Map<String, dynamic> interest) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF14161A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF1F2937)),
      ),
      child: Row(
        children: [
          Icon(interest['icon'], color: const Color(0xFF24DB67), size: 28),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  interest['title'],
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  interest['description'],
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 13,
                    color: const Color(0xFF9CA3AF),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
