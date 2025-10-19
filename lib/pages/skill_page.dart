import 'package:flutter/material.dart';

class SkillsPage extends StatefulWidget {
  const SkillsPage({super.key});

  @override
  State<SkillsPage> createState() => _SkillsPageState();
}

class _SkillsPageState extends State<SkillsPage> with TickerProviderStateMixin {
  late AnimationController _controller;
  late List<AnimationController> _skillControllers;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _skillControllers = List.generate(
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
    for (int i = 0; i < _skillControllers.length; i++) {
      await Future.delayed(const Duration(milliseconds: 150));
      _skillControllers[i].forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    for (var controller in _skillControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;
    final isWide = size.width > 800;

    final programmingLanguages = [
      {'name': 'Dart', 'icon': Icons.code, 'level': 0.9, 'color': Colors.blue},
      {
        'name': 'Python',
        'icon': Icons.terminal,
        'level': 0.85,
        'color': Colors.green,
      },
      {
        'name': 'JavaScript',
        'icon': Icons.javascript,
        'level': 0.8,
        'color': Colors.amber,
      },
      {
        'name': 'C++',
        'icon': Icons.memory,
        'level': 0.75,
        'color': Colors.deepPurple,
      },
    ];

    final frameworks = [
      {
        'name': 'Flutter',
        'icon': Icons.flutter_dash,
        'level': 0.9,
        'color': Colors.blue,
      },
      {'name': 'React', 'icon': Icons.web, 'level': 0.8, 'color': Colors.cyan},
    ];

    final databases = [
      {
        'name': 'Firebase',
        'icon': Icons.cloud,
        'level': 0.85,
        'color': Colors.orange,
      },
      {
        'name': 'Supabase',
        'icon': Icons.storage,
        'level': 0.8,
        'color': Colors.green,
      },
      {
        'name': 'MongoDB',
        'icon': Icons.dns,
        'level': 0.75,
        'color': Colors.greenAccent,
      },
    ];

    final ides = [
      {
        'name': 'VS Code',
        'icon': Icons.code_off,
        'level': 0.9,
        'color': Colors.blueAccent,
      },
      {
        'name': 'Android Studio',
        'icon': Icons.android,
        'level': 0.85,
        'color': Colors.green,
      },
      {
        'name': 'Cursor',
        'icon': Icons.edit,
        'level': 0.8,
        'color': Colors.purple,
      },
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.all(isWide ? 32 : 16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1400),
          child: FadeTransition(
            opacity: _controller,
            child: SlideTransition(
              position:
                  Tween<Offset>(
                    begin: const Offset(0, 0.2),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: _controller,
                      curve: Curves.easeOutCubic,
                    ),
                  ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(isDark),
                  const SizedBox(height: 40),
                  // Row with Programming Languages and Frameworks
                  LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth > 900) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: _buildSkillSection(
                                'Programming Languages',
                                programmingLanguages,
                                isDark,
                                _skillControllers[0],
                                Icons.code_rounded,
                              ),
                            ),
                            const SizedBox(width: 24),
                            Expanded(
                              child: _buildSkillSection(
                                'Frameworks & Libraries',
                                frameworks,
                                isDark,
                                _skillControllers[0],
                                Icons.layers_rounded,
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Column(
                          children: [
                            _buildSkillSection(
                              'Programming Languages',
                              programmingLanguages,
                              isDark,
                              _skillControllers[0],
                              Icons.code_rounded,
                            ),
                            const SizedBox(height: 24),
                            _buildSkillSection(
                              'Frameworks & Libraries',
                              frameworks,
                              isDark,
                              _skillControllers[0],
                              Icons.layers_rounded,
                            ),
                          ],
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 32),
                  // Row with Databases and IDEs
                  LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth > 900) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: _buildSkillSection(
                                'Databases',
                                databases,
                                isDark,
                                _skillControllers[1],
                                Icons.storage_rounded,
                              ),
                            ),
                            const SizedBox(width: 24),
                            Expanded(
                              child: _buildSkillSection(
                                'IDEs & Tools',
                                ides,
                                isDark,
                                _skillControllers[1],
                                Icons.build_rounded,
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Column(
                          children: [
                            _buildSkillSection(
                              'Databases',
                              databases,
                              isDark,
                              _skillControllers[1],
                              Icons.storage_rounded,
                            ),
                            const SizedBox(height: 24),
                            _buildSkillSection(
                              'IDEs & Tools',
                              ides,
                              isDark,
                              _skillControllers[1],
                              Icons.build_rounded,
                            ),
                          ],
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 40),
                  _buildFooterNote(isDark),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(bool isDark) {
    return Column(
      children: [
        Center(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDark
                    ? [Colors.indigo.shade700, Colors.purple.shade700]
                    : [Colors.indigo.shade400, Colors.purple.shade400],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
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
              Icons.emoji_objects_rounded,
              size: 48,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Technical Skills',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black87,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'My expertise across various technologies and tools',
          style: TextStyle(
            fontSize: 16,
            color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
            letterSpacing: 0.3,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildSkillSection(
    String title,
    List<Map<String, dynamic>> skills,
    bool isDark,
    AnimationController controller,
    IconData headerIcon,
  ) {
    return FadeTransition(
      opacity: controller,
      child: SlideTransition(
        position: Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero)
            .animate(
              CurvedAnimation(parent: controller, curve: Curves.easeOutCubic),
            ),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: isDark
                ? Colors.grey.shade900.withOpacity(0.5)
                : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
              width: 1,
            ),
            boxShadow: [
              if (!isDark)
                BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: isDark
                            ? [Colors.indigo.shade600, Colors.purple.shade600]
                            : [Colors.indigo.shade300, Colors.purple.shade300],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(headerIcon, color: Colors.white, size: 24),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black87,
                        letterSpacing: -0.3,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ...skills.map(
                (skill) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _buildSkillCard(
                    skill['name'],
                    skill['icon'],
                    skill['level'],
                    skill['color'],
                    isDark,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSkillCard(
    String name,
    IconData icon,
    double level,
    Color color,
    bool isDark,
  ) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(isDark ? 0.2 : 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: color.withOpacity(0.3), width: 1),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
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
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                      Text(
                        '${(level * 100).toInt()}%',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: isDark
                              ? Colors.grey.shade400
                              : Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: TweenAnimationBuilder<double>(
                      duration: const Duration(milliseconds: 1200),
                      curve: Curves.easeOutCubic,
                      tween: Tween<double>(begin: 0, end: level),
                      builder: (context, value, child) {
                        return LinearProgressIndicator(
                          value: value,
                          backgroundColor: isDark
                              ? Colors.grey.shade800
                              : Colors.grey.shade200,
                          valueColor: AlwaysStoppedAnimation<Color>(color),
                          minHeight: 8,
                        );
                      },
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

  Widget _buildFooterNote(bool isDark) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color: isDark
              ? Colors.indigo.shade900.withOpacity(0.3)
              : Colors.indigo.shade50,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark ? Colors.indigo.shade700 : Colors.indigo.shade200,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.school_rounded,
              color: isDark ? Colors.indigo.shade300 : Colors.indigo.shade700,
              size: 20,
            ),
            const SizedBox(width: 12),
            Text(
              'Continuously learning and expanding my skillset',
              style: TextStyle(
                fontSize: 14,
                color: isDark ? Colors.indigo.shade200 : Colors.indigo.shade700,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
