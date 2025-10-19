import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _statsController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _statsController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _scaleAnimation = Tween<double>(
      begin: 0.9,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.2, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
    Future.delayed(const Duration(milliseconds: 400), () {
      _statsController.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _statsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;
    final isWide = size.width > 900;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1400),
          child: Column(
            children: [
              _buildMainSection(isDark, isWide),
              const SizedBox(height: 32),
              _buildStatsSection(isDark, isWide),
              const SizedBox(height: 32),
              _buildExpertiseSection(isDark, isWide),
              const SizedBox(height: 32),
              _buildInterestsSection(isDark),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainSection(bool isDark, bool isWide) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [Colors.grey.shade900, Colors.grey.shade800]
              : [Colors.white, Colors.grey.shade50],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.4)
                : Colors.grey.shade300,
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: isWide
          ? IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(flex: 2, child: _buildProfileImage(isDark)),
                  Expanded(flex: 3, child: _buildProfileContent(isDark)),
                ],
              ),
            )
          : Column(
              children: [
                _buildProfileImage(isDark),
                _buildProfileContent(isDark),
              ],
            ),
    );
  }

  Widget _buildProfileImage(bool isDark) {
    return Hero(
      tag: 'profile-image',
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              bottomLeft: Radius.circular(24),
            ),
            child: Stack(
              children: [
                Image.asset(
                  'assets/images/opi1.jpg',
                  height: 500,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  color: isDark ? Colors.black.withOpacity(0.3) : null,
                  colorBlendMode: isDark ? BlendMode.darken : null,
                ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: isDark
                          ? Colors.black.withOpacity(0.7)
                          : Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isDark
                            ? Colors.indigo.shade700
                            : Colors.indigo.shade200,
                        width: 2,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildQuickStat(
                          Icons.verified_rounded,
                          'Certified',
                          isDark,
                        ),
                        _buildQuickStat(
                          Icons.star_rounded,
                          'Top Rated',
                          isDark,
                        ),
                        _buildQuickStat(
                          Icons.workspace_premium_rounded,
                          'Pro',
                          isDark,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuickStat(IconData icon, String label, bool isDark) {
    return Row(
      children: [
        Icon(
          icon,
          color: isDark ? Colors.indigo.shade300 : Colors.indigo.shade600,
          size: 20,
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildProfileContent(bool isDark) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SlideTransition(
            position: _slideAnimation,
            child: FadeTransition(
              opacity: _fadeAnimation,
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
                    child: const Icon(
                      Icons.waving_hand_rounded,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      "Hi, I'm Fahim Montasir Opi",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black87,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          SlideTransition(
            position: _slideAnimation,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isDark
                        ? [
                            Colors.indigo.shade900.withOpacity(0.5),
                            Colors.purple.shade900.withOpacity(0.5),
                          ]
                        : [Colors.indigo.shade50, Colors.purple.shade50],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isDark
                        ? Colors.indigo.shade700
                        : Colors.indigo.shade200,
                  ),
                ),
                child: Text(
                  '🚀 Flutter Developer | Mobile & Web Specialist',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isDark
                        ? Colors.indigo.shade200
                        : Colors.indigo.shade700,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          SlideTransition(
            position: _slideAnimation,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Text(
                "I'm a passionate Flutter Developer with expertise in building beautiful, responsive, and high-performance cross-platform applications for Android, iOS, and Web. I specialize in crafting user-friendly interfaces, integrating RESTful APIs, Firebase, and ensuring smooth state management using tools like GetX and BLoC.",
                style: TextStyle(
                  fontSize: 16,
                  color: isDark ? Colors.grey.shade300 : Colors.grey.shade700,
                  height: 1.8,
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          SlideTransition(
            position: _slideAnimation,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _buildTagChip('Cross-Platform', isDark),
                  _buildTagChip('Clean Code', isDark),
                  _buildTagChip('UI/UX Design', isDark),
                  _buildTagChip('API Integration', isDark),
                  _buildTagChip('State Management', isDark),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTagChip(String label, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.indigo.shade900.withOpacity(0.3)
            : Colors.indigo.shade50,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? Colors.indigo.shade700 : Colors.indigo.shade200,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: isDark ? Colors.indigo.shade200 : Colors.indigo.shade700,
        ),
      ),
    );
  }

  Widget _buildStatsSection(bool isDark, bool isWide) {
    final stats = [
      {
        'icon': Icons.code_rounded,
        'value': '10+',
        'label': 'Projects Completed',
      },
      {
        'icon': Icons.emoji_events_rounded,
        'value': '5+',
        'label': 'Awards & Achievements',
      },
      {'icon': Icons.people_rounded, 'value': '0+', 'label': 'Happy Clients'},
      {
        'icon': Icons.schedule_rounded,
        'value': '1+',
        'label': 'Years Experience',
      },
    ];

    return FadeTransition(
      opacity: _statsController,
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? [Colors.indigo.shade900, Colors.purple.shade900]
                : [Colors.indigo.shade400, Colors.purple.shade400],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.indigo.shade900.withOpacity(0.5)
                  : Colors.indigo.shade300,
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: isWide
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: stats
                    .map((stat) => _buildStatCard(stat, isDark))
                    .toList(),
              )
            : Column(
                children: stats.map((stat) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: _buildStatCard(stat, isDark),
                  );
                }).toList(),
              ),
      ),
    );
  }

  Widget _buildStatCard(Map<String, dynamic> stat, bool isDark) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 1500),
      tween: Tween<double>(begin: 0, end: 1),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(stat['icon'], color: Colors.white, size: 36),
              ),
              const SizedBox(height: 12),
              Text(
                stat['value'],
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                stat['label'],
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.9),
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildExpertiseSection(bool isDark, bool isWide) {
    final expertise = [
      {
        'icon': Icons.phone_android_rounded,
        'title': 'Mobile Development',
        'description':
            'Building native-quality apps for iOS and Android using Flutter',
      },
      {
        'icon': Icons.web_rounded,
        'title': 'Web Development',
        'description': 'Creating responsive and performant web applications',
      },
      {
        'icon': Icons.design_services_rounded,
        'title': 'UI/UX Design',
        'description': 'Crafting beautiful and intuitive user interfaces',
      },
      {
        'icon': Icons.api_rounded,
        'title': 'API Integration',
        'description':
            'Seamless integration with RESTful APIs and backend services',
      },
    ];

    return Column(
      children: [
        Text(
          'Areas of Expertise',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black87,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 24),
        isWide
            ? Row(
                children: expertise
                    .map(
                      (item) => Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: _buildExpertiseCard(item, isDark),
                        ),
                      ),
                    )
                    .toList(),
              )
            : Column(
                children: expertise
                    .map(
                      (item) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: _buildExpertiseCard(item, isDark),
                      ),
                    )
                    .toList(),
              ),
      ],
    );
  }

  Widget _buildExpertiseCard(Map<String, dynamic> item, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(24),
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
              offset: const Offset(0, 6),
            ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDark
                    ? [Colors.indigo.shade700, Colors.purple.shade700]
                    : [Colors.indigo.shade400, Colors.purple.shade400],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(item['icon'], color: Colors.white, size: 32),
          ),
          const SizedBox(height: 16),
          Text(
            item['title'],
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            item['description'],
            style: TextStyle(
              fontSize: 14,
              color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildInterestsSection(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey.shade900 : Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.favorite_rounded,
                color: isDark ? Colors.red.shade400 : Colors.red.shade600,
                size: 28,
              ),
              const SizedBox(width: 12),
              Text(
                'Beyond Coding',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            'When I\'m not coding, I enjoy exploring new technologies, contributing to open-source projects, and sharing knowledge with the developer community. I believe in continuous learning and staying updated with the latest trends in mobile and web development.',
            style: TextStyle(
              fontSize: 16,
              color: isDark ? Colors.grey.shade300 : Colors.grey.shade700,
              height: 1.8,
              letterSpacing: 0.2,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
