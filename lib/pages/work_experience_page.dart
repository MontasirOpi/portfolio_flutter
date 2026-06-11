import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WorkExperiencePage extends StatefulWidget {
  const WorkExperiencePage({super.key});

  @override
  State<WorkExperiencePage> createState() => _WorkExperiencePageState();
}

class _WorkExperiencePageState extends State<WorkExperiencePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  final List<Map<String, dynamic>> _experiences = [
    {
      'company': 'Innovate Solutions',
      'role': 'Associate Software Engineer',
      'duration': 'Nov 2025 - Present',
      'isCurrent': true,
      'responsibilities': [
        'Developed and maintained OTA (Online Travel Agency) mobile applications using Flutter and GetX.',
        'Integrated REST APIs for flight, hotel, transfer, insurance, and eSIM booking systems.',
        'Published and maintained Android and iOS applications on the Google Play Store & Apple App Store.',
        'Collaborated with cross-functional teams to deliver scalable, high-performance travel booking solutions.',
        'Improved application performance, UI consistency, memory allocations, and code maintainability.',
        'Integrated dynamic WebSocket streams to handle real-time statuses across device fleets.',
      ],
      'technologies': ['Flutter', 'Dart', 'GetX', 'REST API', 'Firebase', 'eSIM Integration', 'OTA Systems', 'WebSocket'],
    },
    {
      'company': 'Eon System',
      'role': 'Junior Flutter Developer',
      'duration': 'Aug 2025 - Oct 2025',
      'isCurrent': false,
      'responsibilities': [
        'Worked on building cross-platform mobile applications using Flutter & Dart.',
        'Collaborated with senior developers to design and implement premium, responsive UI components.',
        'Integrated third-party payment gateway APIs and RESTful services.',
        'Managed application state using GetX state management structures.',
        'Built 2 complete mobile app modules from scratch and optimized rendering lifecycles.',
      ],
      'technologies': ['Flutter', 'Dart', 'GetX', 'REST API', 'Git', 'Payment Integration'],
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
          constraints: const BoxConstraints(maxWidth: 900),
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 48),
                _buildTimeline(isWide),
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
          '// WORK EXPERIENCE',
          style: GoogleFonts.jetBrainsMono(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF24DB67),
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'My professional journey in software engineering and mobile development.',
          style: GoogleFonts.spaceGrotesk(
            fontSize: 16,
            color: const Color(0xFF9CA3AF),
          ),
        ),
      ],
    );
  }

  Widget _buildTimeline(bool isWide) {
    return Column(
      children: List.generate(_experiences.length, (index) {
        final exp = _experiences[index];
        final isLast = index == _experiences.length - 1;

        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Vertical timeline line and glowing node
              _buildTimelineIndicator(exp['isCurrent'] as bool, isLast),
              const SizedBox(width: 24),
              // Timeline details card
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: _buildExperienceCard(exp, isWide),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildTimelineIndicator(bool isCurrent, bool isLast) {
    return SizedBox(
      width: 24,
      child: Column(
        children: [
          // Glowing Circle Node
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: isCurrent ? const Color(0xFF24DB67) : const Color(0xFF0C0E12),
              shape: BoxShape.circle,
              border: Border.all(
                color: isCurrent ? const Color(0xFF24DB67) : const Color(0xFF1F2937),
                width: 3,
              ),
              boxShadow: isCurrent
                  ? [
                      BoxShadow(
                        color: const Color(0xFF24DB67).withValues(alpha: 0.4),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ]
                  : null,
            ),
          ),
          // Vertical Line segment
          if (!isLast)
            Expanded(
              child: Container(
                width: 2,
                color: const Color(0xFF1F2937),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildExperienceCard(Map<String, dynamic> exp, bool isWide) {
    final bool isCurrent = exp['isCurrent'] as bool;
    final responsibilities = exp['responsibilities'] as List<String>;
    final technologies = exp['technologies'] as List<String>;

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF14161A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isCurrent ? const Color(0xFF24DB67).withValues(alpha: 0.4) : const Color(0xFF1F2937),
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
      padding: EdgeInsets.all(isWide ? 28 : 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Role, Company and Date
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exp['role'] as String,
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      exp['company'] as String,
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF24DB67),
                      ),
                    ),
                  ],
                ),
              ),
              if (isWide) _buildDateBadge(exp['duration'] as String),
            ],
          ),
          if (!isWide) ...[
            const SizedBox(height: 12),
            _buildDateBadge(exp['duration'] as String),
          ],
          const SizedBox(height: 20),
          // Divider
          Container(height: 1, color: const Color(0xFF1F2937)),
          const SizedBox(height: 16),
          // Responsibilities Checklist
          ...responsibilities.map((resp) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 4.0),
                      child: Icon(
                        Icons.circle,
                        size: 6,
                        color: Color(0xFF24DB67),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        resp,
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 14.5,
                          color: const Color(0xFF9CA3AF),
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          const SizedBox(height: 20),
          // Tech Badges Wrap
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: technologies.map((tech) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF0C0E12),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: const Color(0xFF1F2937)),
                ),
                child: Text(
                  tech,
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 11,
                    color: const Color(0xFF9CA3AF),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildDateBadge(String duration) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF0C0E12),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFF1F2937)),
      ),
      child: Text(
        duration,
        style: GoogleFonts.jetBrainsMono(
          fontSize: 11.5,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
