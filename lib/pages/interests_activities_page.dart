import 'package:flutter/material.dart';

class InterestsActivitiesPage extends StatefulWidget {
  const InterestsActivitiesPage({super.key});

  @override
  State<InterestsActivitiesPage> createState() =>
      _InterestsActivitiesPageState();
}

class _InterestsActivitiesPageState extends State<InterestsActivitiesPage>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late List<AnimationController> _sectionControllers;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _sectionControllers = List.generate(
      2,
      (index) => AnimationController(
        duration: const Duration(milliseconds: 600),
        vsync: this,
      ),
    );
    _startAnimations();
  }

  void _startAnimations() async {
    _controller.forward();
    for (int i = 0; i < _sectionControllers.length; i++) {
      await Future.delayed(const Duration(milliseconds: 150));
      _sectionControllers[i].forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    for (var controller in _sectionControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;
    final isWide = size.width > 900;

    final learningTopics = [
      {
        'icon': Icons.code_rounded,
        'title': 'Python',
        'description': 'Advanced Python programming & libraries',
        'color': Colors.blue,
        'progress': 0.7,
      },
      {
        'icon': Icons.emoji_events_rounded,
        'title': 'Competitive Programming',
        'description': 'DSA, algorithms & problem solving',
        'color': Colors.amber,
        'progress': 0.6,
      },
      {
        'icon': Icons.cloud_rounded,
        'title': 'Cloud Architecture',
        'description': 'AWS, GCP, Azure services',
        'color': Colors.purple,
        'progress': 0.5,
      },
      {
        'icon': Icons.smart_toy_rounded,
        'title': 'AI/ML Integration',
        'description': 'TensorFlow, ML models in apps',
        'color': Colors.green,
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
        'title': 'Cross-Platform Development',
        'description': 'Building apps that work everywhere',
      },
      {
        'icon': Icons.design_services_rounded,
        'title': 'UI/UX Design',
        'description': 'Creating beautiful and intuitive interfaces',
      },
      {
        'icon': Icons.rocket_launch_rounded,
        'title': 'Performance Optimization',
        'description': 'Making apps faster and more efficient',
      },
      {
        'icon': Icons.explore_rounded,
        'title': 'New Technologies',
        'description': 'Always exploring latest tech trends',
      },
      {
        'icon': Icons.school_rounded,
        'title': 'Continuous Learning',
        'description': 'Never stop improving and learning',
      },
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.all(isWide ? 32 : 16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1400),
          child: FadeTransition(
            opacity: _controller,
            child: Column(
              children: [
                _buildHeader(isDark),
                const SizedBox(height: 40),

                // Currently Learning Section
                _buildSectionTitle('📚 Currently Learning', isDark),
                const SizedBox(height: 20),
                _buildLearningGrid(
                  learningTopics,
                  isDark,
                  isWide,
                  _sectionControllers[0],
                ),
                const SizedBox(height: 40),

                // Interests Section
                _buildSectionTitle('⚡ Interests & Passions', isDark),
                const SizedBox(height: 20),
                _buildInterestsGrid(
                  interests,
                  isDark,
                  isWide,
                  _sectionControllers[1],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(bool isDark) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isDark
                  ? [Colors.indigo.shade700, Colors.purple.shade700]
                  : [Colors.indigo.shade400, Colors.purple.shade400],
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color:
                    (isDark ? Colors.indigo.shade700 : Colors.indigo.shade300)
                        .withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: const Icon(
            Icons.lightbulb_rounded,
            size: 48,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Learning & Interests',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black87,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'My journey of continuous growth and exploration',
          style: TextStyle(
            fontSize: 16,
            color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title, bool isDark) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: isDark ? Colors.white : Colors.black87,
        letterSpacing: -0.3,
      ),
    );
  }

  Widget _buildLearningGrid(
    List<Map<String, dynamic>> topics,
    bool isDark,
    bool isWide,
    AnimationController controller,
  ) {
    return FadeTransition(
      opacity: controller,
      child: Wrap(
        spacing: 20,
        runSpacing: 20,
        alignment: WrapAlignment.center,
        children: topics.map((topic) {
          return SizedBox(
            width: isWide ? 320 : 340,
            child: _buildLearningCard(
              topic['icon'],
              topic['title'],
              topic['description'],
              topic['color'],
              topic['progress'],
              isDark,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildLearningCard(
    IconData icon,
    String title,
    String description,
    Color color,
    double progress,
    bool isDark,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey.shade900 : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
        ),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: color.withOpacity(isDark ? 0.2 : 0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: color, size: 32),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(
              fontSize: 12,
              color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Progress',
                    style: TextStyle(
                      fontSize: 11,
                      color: isDark
                          ? Colors.grey.shade500
                          : Colors.grey.shade600,
                    ),
                  ),
                  Text(
                    '${(progress * 100).toInt()}%',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: TweenAnimationBuilder<double>(
                  duration: const Duration(milliseconds: 1500),
                  curve: Curves.easeOutCubic,
                  tween: Tween<double>(begin: 0, end: progress),
                  builder: (context, value, child) {
                    return LinearProgressIndicator(
                      value: value,
                      backgroundColor: isDark
                          ? Colors.grey.shade800
                          : Colors.grey.shade200,
                      valueColor: AlwaysStoppedAnimation<Color>(color),
                      minHeight: 6,
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }



  Widget _buildInterestsGrid(
    List<Map<String, dynamic>> interests,
    bool isDark,
    bool isWide,
    AnimationController controller,
  ) {
    return FadeTransition(
      opacity: controller,
      child: Wrap(
        spacing: 20,
        runSpacing: 20,
        alignment: WrapAlignment.center,
        children: interests.map((interest) {
          return SizedBox(
            width: isWide ? 400 : double.infinity,
            child: _buildInterestCard(
              interest['icon'],
              interest['title'],
              interest['description'],
              isDark,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildInterestCard(
    IconData icon,
    String title,
    String description,
    bool isDark,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey.shade900 : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
        ),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDark
                    ? [Colors.indigo.shade700, Colors.purple.shade700]
                    : [Colors.indigo.shade400, Colors.purple.shade400],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
