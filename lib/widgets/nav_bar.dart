import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class NavBar extends StatefulWidget {
  final VoidCallback toggleTheme;
  final bool isDarkMode;
  final Function(int) onNavigate;
  final int currentIndex;

  const NavBar({
    super.key,
    required this.toggleTheme,
    required this.isDarkMode,
    required this.onNavigate,
    required this.currentIndex,
  });

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  bool _isMobileMenuOpen = false;

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not launch $url'),
            backgroundColor: Colors.red.shade700,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDarkMode;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? Colors.grey.shade900 : Colors.white,
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.3)
                : Colors.grey.shade300,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          bool isMobile = constraints.maxWidth < 900;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: isMobile
                ? _buildMobileNav(isDark)
                : _buildDesktopNav(isDark),
          );
        },
      ),
    );
  }

  Widget _buildDesktopNav(bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Left: Logo/Name + Tech Icons
        Row(
          children: [
            _buildLogo(isDark),
            const SizedBox(width: 40),
            _buildTechIcons(isDark),
          ],
        ),

        // Center: Navigation Links
        Row(
          children: [
            _buildNavLink('About', 0, isDark),
            _buildNavLink('Projects', 1, isDark),
            _buildNavLink('Skills', 2, isDark),
            _buildNavLink('Interests', 3, isDark),
            _buildNavLink('Contact', 4, isDark),
          ],
        ),

        // Right: Social Icons + CV Download + Theme Toggle
        Row(
          children: [
            _buildSocialIcons(isDark),
            const SizedBox(width: 16),
            _buildDownloadCVButton(isDark),
            const SizedBox(width: 24),
            _buildThemeToggle(isDark),
          ],
        ),
      ],
    );
  }

  Widget _buildMobileNav(bool isDark) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildLogo(isDark),
            Row(
              children: [
                _buildThemeToggle(isDark),
                const SizedBox(width: 8),
                IconButton(
                  icon: Icon(
                    _isMobileMenuOpen
                        ? Icons.close_rounded
                        : Icons.menu_rounded,
                    size: 28,
                  ),
                  onPressed: () {
                    setState(() {
                      _isMobileMenuOpen = !_isMobileMenuOpen;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
        if (_isMobileMenuOpen) ...[
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? Colors.grey.shade800 : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildMobileNavLink('About', 0, isDark),
                _buildMobileNavLink('Projects', 1, isDark),
                _buildMobileNavLink('Skills', 2, isDark),
                _buildMobileNavLink('Interests', 3, isDark),
                _buildMobileNavLink('Contact', 4, isDark),
                const SizedBox(height: 8),
                _buildDownloadCVButton(isDark, isMobile: true),
                const Divider(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildIcon(
                      'assets/icons/dart.svg',
                      'https://dart.dev/',
                      isDark,
                    ),
                    _buildIcon(
                      'assets/icons/flutter-logo.svg',
                      'https://flutter.dev/',
                      isDark,
                    ),
                    _buildIcon(
                      'assets/icons/github.svg',
                      'https://github.com/MontasirOpi',
                      isDark,
                      size: 32,
                    ),
                    _buildIcon(
                      'assets/icons/linkedin.svg',
                      'https://www.linkedin.com/in/fahim-montasir-opi-161b65256/',
                      isDark,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildLogo(bool isDark) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isDark
                  ? [Colors.indigo.shade700, Colors.purple.shade700]
                  : [Colors.indigo.shade400, Colors.purple.shade400],
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(Icons.code_rounded, color: Colors.white, size: 24),
        ),
        const SizedBox(width: 12),
        Text(
          "Fahim Montasir Opi",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black87,
            letterSpacing: -0.3,
          ),
        ),
      ],
    );
  }

  Widget _buildNavLink(String label, int index, bool isDark) {
    final isActive = widget.currentIndex == index;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextButton(
        onPressed: () {
          widget.onNavigate(index);
        },
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          backgroundColor: isActive
              ? (isDark
                    ? Colors.indigo.shade900.withOpacity(0.5)
                    : Colors.indigo.shade50)
              : Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
            color: isActive
                ? (isDark ? Colors.indigo.shade200 : Colors.indigo.shade700)
                : (isDark ? Colors.grey.shade300 : Colors.grey.shade700),
            letterSpacing: 0.2,
          ),
        ),
      ),
    );
  }

  Widget _buildMobileNavLink(String label, int index, bool isDark) {
    final isActive = widget.currentIndex == index;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: TextButton(
        onPressed: () {
          widget.onNavigate(index);
          setState(() {
            _isMobileMenuOpen = false;
          });
        },
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          backgroundColor: isActive
              ? (isDark
                    ? Colors.indigo.shade900.withOpacity(0.5)
                    : Colors.indigo.shade100)
              : Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          children: [
            if (isActive) ...[
              Container(
                width: 4,
                height: 20,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isDark
                        ? [Colors.indigo.shade400, Colors.purple.shade400]
                        : [Colors.indigo.shade600, Colors.purple.shade600],
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),
            ] else
              const SizedBox(width: 16),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                color: isActive
                    ? (isDark ? Colors.indigo.shade200 : Colors.indigo.shade700)
                    : (isDark ? Colors.grey.shade300 : Colors.grey.shade700),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTechIcons(bool isDark) {
    return Row(
      children: [
        _buildIcon('assets/icons/dart.svg', 'https://dart.dev/', false),
        const SizedBox(width: 16),
        _buildIcon(
          'assets/icons/flutter-logo.svg',
          'https://flutter.dev/',
          false,
        ),
      ],
    );
  }

  Widget _buildSocialIcons(bool isDark) {
    return Row(
      children: [
        _buildIcon(
          'assets/icons/github.svg',
          'https://github.com/MontasirOpi',
          false,
          size: 28,
        ),
        const SizedBox(width: 16),
        _buildIcon(
          'assets/icons/linkedin.svg',
          'https://www.linkedin.com/in/fahim-montasir-opi-161b65256/',
          false,
        ),
      ],
    );
  }

  Widget _buildIcon(
    String assetPath,
    String url,
    bool isDark, {
    double size = 26,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () => _launchURL(url),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isDark ? Colors.grey.shade800 : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: SvgPicture.asset(
            assetPath,
            height: size,
            width: size,
            colorFilter: isDark
                ? const ColorFilter.mode(Colors.white70, BlendMode.srcIn)
                : null,
          ),
        ),
      ),
    );
  }

  Widget _buildThemeToggle(bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? Colors.grey.shade800 : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: IconButton(
        icon: Icon(
          isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
          color: isDark ? Colors.yellow.shade300 : Colors.indigo.shade700,
        ),
        onPressed: widget.toggleTheme,
        tooltip: isDark ? 'Switch to Light Mode' : 'Switch to Dark Mode',
      ),
    );
  }

  Widget _buildDownloadCVButton(bool isDark, {bool isMobile = false}) {
    return ElevatedButton.icon(
      onPressed: () => _launchURL(
        'https://drive.google.com/file/d/19RfC_zxo38aq2a3ZstuaWDM79mXsj_sx/view?usp=sharing',
      ),
      icon: const Icon(Icons.download_rounded, size: 18),
      label: Text(
        'Download CV',
        style: TextStyle(
          fontSize: isMobile ? 15 : 14,
          fontWeight: FontWeight.w600,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: isDark
            ? Colors.indigo.shade700
            : Colors.indigo.shade600,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 24 : 16,
          vertical: isMobile ? 14 : 12,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 0,
      ),
    );
  }
}
