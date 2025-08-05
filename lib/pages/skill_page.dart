import 'package:flutter/material.dart';

class SkillsPage extends StatelessWidget {
  const SkillsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final programmingLanguages = [
      {'name': 'Dart', 'icon': Icons.code},
      {'name': 'Python', 'icon': Icons.terminal},
      {'name': 'JavaScript', 'icon': Icons.javascript},
      {'name': 'C++', 'icon': Icons.memory},
    ];

    final frameworks = [
      {'name': 'Flutter', 'icon': Icons.flutter_dash},
      {'name': 'React', 'icon': Icons.web},
    ];

    final databases = [
      {'name': 'Firebase', 'icon': Icons.cloud},
      {'name': 'Supabase', 'icon': Icons.storage},
      {'name': 'MongoDB', 'icon': Icons.dns},
    ];

    final ides = [
      {'name': 'VS Code', 'icon': Icons.code_off},
      {'name': 'Android Studio', 'icon': Icons.android},
      {'name': 'Cursor', 'icon': Icons.edit},
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? Colors.grey[900] : Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            if (!isDark)
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
          ],
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                '💻 My Developer Skills',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.indigo[100] : Colors.indigo.shade800,
                ),
              ),
            ),
            const SizedBox(height: 24),
            _buildSkillSection('Programming Languages', programmingLanguages, isDark),
            const Divider(height: 32),
            _buildSkillSection('Frameworks', frameworks, isDark),
            const Divider(height: 32),
            _buildSkillSection('Databases', databases, isDark),
            const Divider(height: 32),
            _buildSkillSection('IDEs & Tools', ides, isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillSection(String title, List<Map<String, dynamic>> skills, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: skills.map((skill) {
            return _buildSkillChip(skill['name'], skill['icon'], isDark);
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSkillChip(String name, IconData icon, bool isDark) {
    return Chip(
      label: Text(
        name,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: isDark ? Colors.white : Colors.black,
        ),
      ),
      avatar: Icon(
        icon,
        size: 20,
        color: isDark ? Colors.indigo[200] : Colors.indigo,
      ),
      backgroundColor: isDark ? Colors.indigo.shade900.withOpacity(0.2) : Colors.indigo.shade50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: isDark ? Colors.indigo.shade300 : Colors.indigo.shade100,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    );
  }
}
