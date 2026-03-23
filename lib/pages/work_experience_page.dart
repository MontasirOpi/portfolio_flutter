import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WorkExperiencePage extends StatefulWidget {
  const WorkExperiencePage({super.key});

  @override
  State<WorkExperiencePage> createState() => _WorkExperiencePageState();
}

class _WorkExperiencePageState extends State<WorkExperiencePage>
    with TickerProviderStateMixin {
  late AnimationController _timelineController;

  final List<Map<String, dynamic>> _experiences = [
    {
      'company': 'Innovate Solution',
      'role': 'Associate Software Engineer',
      'type': 'Full-time · Mobile Application Developer',
      'duration': 'Present',
      'startDate': 'Nov 2025',
      'endDate': 'Present',
      'isCurrent': true,
      'description':
          'Leading mobile development efforts to build scalable, production-ready Flutter applications for both Android and iOS platforms. Responsible for architecting features, conducting code reviews, and mentoring junior developers. Actively involved in sprint planning and agile processes.',
      'skills': ['Flutter', 'Dart', 'BLoC', 'Firebase', 'REST API', 'CI/CD'],
      'achievements': [
        'Leading mobile development for 3+ production apps',
        'Implemented CI/CD pipeline for automated deployments',
        'Reduced app crash rate by 40% through robust error handling',
      ],
    },
    {
      'company': 'Eon System',
      'role': 'Junior Flutter Developer',
      'type': 'Internship',
      'duration': '3 Months',
      'startDate': 'Aug 2025',
      'endDate': 'Oct 2025',
      'isCurrent': false,
      'description':
          'Started my professional journey as a Junior Flutter Developer intern. Worked on building cross-platform mobile applications using Flutter & Dart. Collaborated with senior developers to design and implement UI components, integrate RESTful APIs, and manage app state using GetX.',
      'skills': ['Flutter', 'Dart', 'GetX', 'REST API', 'Git'],
      'achievements': [
        'Built 2 complete mobile app modules from scratch',
        'Integrated payment gateway API',
        'Improved app performance by optimizing widget builds',
      ],
    },
  ];

  @override
  void initState() {
    super.initState();
    _timelineController = AnimationController(
      duration: const Duration(milliseconds: 1400),
      vsync: this,
    );

    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) _timelineController.forward();
    });
  }

  @override
  void dispose() {
    _timelineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 48),
              _buildTimeline(),
            ],
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
          'My professional journey in software development.',
          style: GoogleFonts.spaceGrotesk(
            fontSize: 16,
            color: const Color(0xFF9CA3AF),
          ),
        ),
      ],
    );
  }

  Widget _buildTimeline() {
    return Column(
      children: List.generate(_experiences.length, (index) {
        final exp = _experiences[index];

        return AnimatedBuilder(
          animation: _timelineController,
          builder: (context, child) {
            final delay = index * 0.3;
            final progress = (_timelineController.value - delay).clamp(0.0, 1.0);
            final curve = Curves.easeOutCubic.transform(progress);

            return Opacity(
              opacity: curve,
              child: Transform.translate(
                offset: Offset(0, 40 * (1 - curve)),
                child: child,
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: _buildExperienceCard(exp),
          ),
        );
      }),
    );
  }

  Widget _buildExperienceCard(Map<String, dynamic> exp) {
    final bool isCurrent = exp['isCurrent'] as bool;

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF14161A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isCurrent ? const Color(0xFF24DB67).withOpacity(0.5) : const Color(0xFF1F2937),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exp['company'] as String,
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF24DB67),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      exp['role'] as String,
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF0C0E12),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFF1F2937)),
                ),
                child: Text(
                  '${exp['startDate']} - ${exp['endDate']}',
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 12,
                    color: const Color(0xFF9CA3AF),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            exp['description'] as String,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 16,
              color: const Color(0xFFE0E6EB),
              height: 1.6,
            ),
          ),
          const SizedBox(height: 24),
          ...((exp['achievements'] as List<String>).map(
            (a) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '>',
                    style: TextStyle(
                      color: Color(0xFF24DB67),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      a,
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 15,
                        color: const Color(0xFF9CA3AF),
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
          const SizedBox(height: 24),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: (exp['skills'] as List<String>).map((skill) {
              return Text(
                '#$skill',
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 13,
                  color: const Color(0xFF24DB67).withOpacity(0.8),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
