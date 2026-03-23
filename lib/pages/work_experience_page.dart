import 'package:flutter/material.dart';

class WorkExperiencePage extends StatefulWidget {
  const WorkExperiencePage({super.key});

  @override
  State<WorkExperiencePage> createState() => _WorkExperiencePageState();
}

class _WorkExperiencePageState extends State<WorkExperiencePage>
    with TickerProviderStateMixin {
  late AnimationController _headerController;
  late AnimationController _timelineController;
  late Animation<double> _headerFade;
  late Animation<Offset> _headerSlide;

  final List<Map<String, dynamic>> _experiences = [
    {
      'company': 'Eon System',
      'role': 'Junior Flutter Developer',
      'type': 'Internship',
      'duration': '3 Months',
      'startDate': 'August 2025',
      'endDate': 'October 2025',
      'isCurrent': false,
      'description':
          'Started my professional journey as a Junior Flutter Developer intern at Eon System. '
              'Worked on building cross-platform mobile applications using Flutter & Dart. '
              'Collaborated with senior developers to design and implement UI components, '
              'integrate RESTful APIs, and manage app state using GetX. Gained hands-on '
              'experience in the full mobile app development lifecycle.',
      'skills': ['Flutter', 'Dart', 'GetX', 'REST API', 'Git'],
      'icon': Icons.rocket_launch_rounded,
      'color1': Color(0xFF667eea),
      'color2': Color(0xFF764ba2),
      'achievements': [
        'Built 2 complete mobile app modules from scratch',
        'Integrated payment gateway API',
        'Improved app performance by optimizing widget builds',
      ],
    },
    {
      'company': 'Innovate Solution',
      'role': 'Associate Software Engineer',
      'type': 'Full-time · Mobile Application Developer',
      'duration': 'Present',
      'startDate': 'November 2025',
      'endDate': 'Present',
      'isCurrent': true,
      'description':
          'Currently working as an Associate Software Engineer (Mobile Application Developer) at Innovate Solution. '
              'Leading mobile development efforts to build scalable, production-ready Flutter applications '
              'for both Android and iOS platforms. Responsible for architecting features, '
              'conducting code reviews, and mentoring junior developers. Actively involved in '
              'sprint planning and agile processes.',
      'skills': [
        'Flutter',
        'Dart',
        'BLoC',
        'Firebase',
        'REST API',
        'Agile',
        'CI/CD',
      ],
      'icon': Icons.business_center_rounded,
      'color1': Color(0xFF11998e),
      'color2': Color(0xFF38ef7d),
      'achievements': [
        'Leading mobile development for 3+ production apps',
        'Implemented CI/CD pipeline for automated deployments',
        'Reduced app crash rate by 40% through robust error handling',
        'Mentoring 2 junior developers on Flutter best practices',
      ],
    },
  ];

  @override
  void initState() {
    super.initState();
    _headerController = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );
    _timelineController = AnimationController(
      duration: const Duration(milliseconds: 1400),
      vsync: this,
    );

    _headerFade = CurvedAnimation(
      parent: _headerController,
      curve: Curves.easeInOut,
    );
    _headerSlide = Tween<Offset>(
      begin: const Offset(0, -0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _headerController, curve: Curves.easeOut));

    _headerController.forward();
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) _timelineController.forward();
    });
  }

  @override
  void dispose() {
    _headerController.dispose();
    _timelineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isWide = MediaQuery.of(context).size.width > 800;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(isDark),
              const SizedBox(height: 48),
              _buildTimeline(isDark, isWide),
              const SizedBox(height: 40),
              _buildSummaryCard(isDark),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(bool isDark) {
    return FadeTransition(
      opacity: _headerFade,
      child: SlideTransition(
        position: _headerSlide,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: isDark
                          ? [const Color(0xFF667eea), const Color(0xFF764ba2)]
                          : [const Color(0xFF667eea), const Color(0xFF764ba2)],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF667eea).withOpacity(0.4),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.work_history_rounded,
                    color: Colors.white,
                    size: 34,
                  ),
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Work & Experience',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w800,
                        color: isDark ? Colors.white : Colors.black87,
                        letterSpacing: -0.8,
                      ),
                    ),
                    Text(
                      'My professional journey in software development',
                      style: TextStyle(
                        fontSize: 15,
                        color: isDark
                            ? Colors.grey.shade400
                            : Colors.grey.shade600,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Stats row
            Wrap(
              spacing: 16,
              runSpacing: 12,
              alignment: WrapAlignment.center,
              children: [
                _buildHeaderStat(
                  Icons.business_rounded,
                  '2',
                  'Companies',
                  isDark,
                ),
                _buildHeaderStat(
                  Icons.timeline_rounded,
                  '8+',
                  'Months',
                  isDark,
                ),
                _buildHeaderStat(
                  Icons.apps_rounded,
                  '5+',
                  'Apps Built',
                  isDark,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderStat(
    IconData icon,
    String value,
    String label,
    bool isDark,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.indigo.shade900.withOpacity(0.3)
            : Colors.indigo.shade50,
        borderRadius: BorderRadius.circular(40),
        border: Border.all(
          color: isDark ? Colors.indigo.shade700 : Colors.indigo.shade200,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 18,
            color: isDark ? Colors.indigo.shade300 : Colors.indigo.shade600,
          ),
          const SizedBox(width: 8),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 16,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeline(bool isDark, bool isWide) {
    return Column(
      children: List.generate(_experiences.length, (index) {
        final exp = _experiences[index];
        final isLast = index == _experiences.length - 1;

        return AnimatedBuilder(
          animation: _timelineController,
          builder: (context, child) {
            final delay = index * 0.3;
            final progress = (_timelineController.value - delay).clamp(
              0.0,
              1.0,
            );
            final curve = Curves.easeOutCubic.transform(progress);

            return Opacity(
              opacity: curve,
              child: Transform.translate(
                offset: Offset(0, 40 * (1 - curve)),
                child: child,
              ),
            );
          },
          child: _buildTimelineItem(exp, isDark, isLast, index),
        );
      }),
    );
  }

  Widget _buildTimelineItem(
    Map<String, dynamic> exp,
    bool isDark,
    bool isLast,
    int index,
  ) {
    final Color c1 = exp['color1'] as Color;
    final Color c2 = exp['color2'] as Color;
    final bool isCurrent = exp['isCurrent'] as bool;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline column (dot + line)
          SizedBox(
            width: 60,
            child: Column(
              children: [
                // Dot
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [c1, c2],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: c1.withOpacity(0.5),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Icon(
                    exp['icon'] as IconData,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                // Vertical line
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 3,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            c2.withOpacity(0.8),
                            isDark
                                ? Colors.grey.shade800
                                : Colors.grey.shade200,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          // Card
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 32),
              child: _buildExperienceCard(exp, isDark, c1, c2, isCurrent),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceCard(
    Map<String, dynamic> exp,
    bool isDark,
    Color c1,
    Color c2,
    bool isCurrent,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? Colors.grey.shade900 : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.3)
                : Colors.grey.shade200,
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
          if (isCurrent)
            BoxShadow(
              color: c1.withOpacity(0.15),
              blurRadius: 30,
              spreadRadius: 2,
            ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card Header with gradient
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [c1.withOpacity(0.15), c2.withOpacity(0.08)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              border: Border(
                bottom: BorderSide(
                  color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Company name
                          Text(
                            exp['company'] as String,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: isDark ? Colors.white : Colors.black87,
                              letterSpacing: -0.3,
                            ),
                          ),
                          const SizedBox(height: 4),
                          // Role
                          Text(
                            exp['role'] as String,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: c1,
                              letterSpacing: 0.1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Current badge
                    if (isCurrent)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [c1, c2]),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: c1.withOpacity(0.4),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Text(
                              'Current',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      )
                    else
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: isDark
                              ? Colors.grey.shade800
                              : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isDark
                                ? Colors.grey.shade700
                                : Colors.grey.shade300,
                          ),
                        ),
                        child: Text(
                          'Completed',
                          style: TextStyle(
                            color: isDark
                                ? Colors.grey.shade300
                                : Colors.grey.shade600,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                // Meta info row
                Wrap(
                  spacing: 12,
                  runSpacing: 8,
                  children: [
                    _buildMetaChip(
                      Icons.badge_rounded,
                      exp['type'] as String,
                      isDark,
                      c1,
                    ),
                    _buildMetaChip(
                      Icons.calendar_today_rounded,
                      '${exp['startDate']} – ${exp['endDate']}',
                      isDark,
                      c1,
                    ),
                    _buildMetaChip(
                      Icons.hourglass_bottom_rounded,
                      exp['duration'] as String,
                      isDark,
                      c1,
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Card Body
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Description
                Text(
                  exp['description'] as String,
                  style: TextStyle(
                    fontSize: 14.5,
                    color: isDark ? Colors.grey.shade300 : Colors.grey.shade700,
                    height: 1.75,
                    letterSpacing: 0.1,
                  ),
                ),
                const SizedBox(height: 20),
                // Achievements
                _buildAchievements(
                  exp['achievements'] as List<String>,
                  isDark,
                  c1,
                ),
                const SizedBox(height: 20),
                // Skills
                _buildSkillChips(
                  exp['skills'] as List<String>,
                  isDark,
                  c1,
                  c2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetaChip(
    IconData icon,
    String label,
    bool isDark,
    Color accentColor,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 14,
          color: accentColor.withOpacity(0.8),
        ),
        const SizedBox(width: 5),
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildAchievements(
    List<String> achievements,
    bool isDark,
    Color accentColor,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.emoji_events_rounded,
              size: 18,
              color: accentColor,
            ),
            const SizedBox(width: 8),
            Text(
              'Key Achievements',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: isDark ? Colors.white : Colors.black87,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...achievements.map(
          (a) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 6),
                  width: 7,
                  height: 7,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [accentColor, accentColor.withOpacity(0.6)],
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    a,
                    style: TextStyle(
                      fontSize: 14,
                      color: isDark
                          ? Colors.grey.shade300
                          : Colors.grey.shade700,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSkillChips(
    List<String> skills,
    bool isDark,
    Color c1,
    Color c2,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code_rounded, size: 18, color: c1),
            const SizedBox(width: 8),
            Text(
              'Technologies Used',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: skills
              .map(
                (skill) => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        c1.withOpacity(isDark ? 0.25 : 0.12),
                        c2.withOpacity(isDark ? 0.15 : 0.06),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: c1.withOpacity(isDark ? 0.5 : 0.3),
                    ),
                  ),
                  child: Text(
                    skill,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isDark ? c1.withOpacity(0.9) : c1,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  Widget _buildSummaryCard(bool isDark) {
    return AnimatedBuilder(
      animation: _timelineController,
      builder: (context, child) {
        final progress = (_timelineController.value - 0.5).clamp(0.0, 1.0);
        final curve = Curves.easeOutCubic.transform(progress);
        return Opacity(
          opacity: curve,
          child: Transform.translate(
            offset: Offset(0, 30 * (1 - curve)),
            child: child,
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? [
                    const Color(0xFF667eea).withOpacity(0.15),
                    const Color(0xFF764ba2).withOpacity(0.1),
                  ]
                : [
                    const Color(0xFF667eea).withOpacity(0.07),
                    const Color(0xFF764ba2).withOpacity(0.05),
                  ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isDark
                ? const Color(0xFF667eea).withOpacity(0.3)
                : const Color(0xFF667eea).withOpacity(0.2),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                ),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.trending_up_rounded,
                color: Colors.white,
                size: 28,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Growing Every Day 🚀',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'From internship to full-time engineer — continuously learning, building, and contributing to impactful mobile solutions.',
                    style: TextStyle(
                      fontSize: 14,
                      color: isDark
                          ? Colors.grey.shade300
                          : Colors.grey.shade600,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
