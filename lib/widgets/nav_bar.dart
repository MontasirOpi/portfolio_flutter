import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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

  Future<void> _launchCV() async {
    final uri = Uri.parse(
      'https://drive.google.com/file/d/1emV0wbFCU4XH-b5TFi_WA27WWIPjo2-K/view?usp=sharing',
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0C0E12),
      child: LayoutBuilder(
        builder: (context, constraints) {
          bool isMobile = constraints.maxWidth < 900;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: isMobile ? _buildMobileNav() : _buildDesktopNav(),
          );
        },
      ),
    );
  }

  Widget _buildDesktopNav() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildLogo(),
        Row(
          children: [
            _buildNavLink('Home', 0),
            _buildNavLink('About', 1),
            _buildNavLink('Projects', 2),
            _buildNavLink('Experience', 3),
            _buildNavLink('Skills', 4),
            _buildNavLink('Contact', 5),
            const SizedBox(width: 16),
            OutlinedButton(
              onPressed: _launchCV,
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF24DB67),
                side: const BorderSide(color: Color(0xFF24DB67)),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              child: Text(
                'CV',
                style: GoogleFonts.jetBrainsMono(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMobileNav() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildLogo(),
            IconButton(
              icon: Icon(
                _isMobileMenuOpen ? Icons.close_rounded : Icons.menu_rounded,
                color: Colors.white,
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
        if (_isMobileMenuOpen) ...[
          const SizedBox(height: 24),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildMobileNavLink('Home', 0),
              _buildMobileNavLink('About', 1),
              _buildMobileNavLink('Projects', 2),
              _buildMobileNavLink('Experience', 3),
              _buildMobileNavLink('Skills', 4),
              _buildMobileNavLink('Contact', 5),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: OutlinedButton(
                  onPressed: _launchCV,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF24DB67),
                    side: const BorderSide(color: Color(0xFF24DB67)),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text(
                    'DOWNLOAD CV',
                    style: GoogleFonts.jetBrainsMono(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildLogo() {
    return Text(
      "OPI",
      style: GoogleFonts.spaceGrotesk(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        letterSpacing: -0.5,
      ),
    );
  }

  Widget _buildNavLink(String label, int index) {
    final isActive = widget.currentIndex == index;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => widget.onNavigate(index),
          child: Text(
            label,
            style: GoogleFonts.jetBrainsMono(
              fontSize: 14,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
              color: isActive
                  ? const Color(0xFF24DB67)
                  : const Color(0xFF9CA3AF),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileNavLink(String label, int index) {
    final isActive = widget.currentIndex == index;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GestureDetector(
        onTap: () {
          widget.onNavigate(index);
          setState(() {
            _isMobileMenuOpen = false;
          });
        },
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: GoogleFonts.jetBrainsMono(
            fontSize: 18,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
            color: isActive ? const Color(0xFF24DB67) : const Color(0xFF9CA3AF),
          ),
        ),
      ),
    );
  }
}
