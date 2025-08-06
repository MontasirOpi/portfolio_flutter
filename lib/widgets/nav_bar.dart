import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class NavBar extends StatelessWidget {
  final VoidCallback toggleTheme;
  final bool isDarkMode;

  const NavBar({
    super.key,
    required this.toggleTheme,
    required this.isDarkMode,
  });

  // Generic URL launcher
  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile = constraints.maxWidth < 600;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: isMobile
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Row: Name + Theme toggle
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Fahim Montasir Opi",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            isDarkMode ? Icons.light_mode : Icons.dark_mode,
                          ),
                          onPressed: toggleTheme,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Icons Row
                    Wrap(
                      spacing: 20,
                      runSpacing: 10,
                      children: [
                        _buildIcon('assets/icons/dart.svg', 'https://dart.dev/'),
                        _buildIcon('assets/icons/flutter-logo.svg', 'https://flutter.dev/'),
                        _buildIcon('assets/icons/github.svg', 'https://github.com/MontasirOpi', size: 40),
                        _buildIcon('assets/icons/linkedin.svg', 'https://www.linkedin.com/in/fahim-montasir-opi-161b65256/'),
                      ],
                    )
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Left: Name + tech icons
                    Row(
                      children: [
                        const Text(
                          "Fahim Montasir Opi",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 30),
                        _buildIcon('assets/icons/dart.svg', 'https://dart.dev/'),
                        const SizedBox(width: 20),
                        _buildIcon('assets/icons/flutter-logo.svg', 'https://flutter.dev/'),
                      ],
                    ),
                    // Right: Social + theme toggle
                    Row(
                      children: [
                        _buildIcon('assets/icons/github.svg', 'https://github.com/MontasirOpi', size: 40),
                        const SizedBox(width: 20),
                        _buildIcon('assets/icons/linkedin.svg', 'https://www.linkedin.com/in/fahim-montasir-opi-161b65256/'),
                        const SizedBox(width: 40),
                        IconButton(
                          icon: Icon(
                            isDarkMode ? Icons.light_mode : Icons.dark_mode,
                          ),
                          onPressed: toggleTheme,
                        ),
                      ],
                    )
                  ],
                ),
        );
      },
    );
  }

  Widget _buildIcon(String assetPath, String url, {double size = 30}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(4),
        onTap: () => _launchURL(url),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: SvgPicture.asset(
            assetPath,
            height: size,
            width: size,
          ),
        ),
      ),
    );
  }
}
