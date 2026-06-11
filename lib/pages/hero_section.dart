import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback onViewProjects;

  const HeroSection({super.key, required this.onViewProjects});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

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

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _launchCV() async {
    final uri = Uri.parse('https://drive.google.com/file/d/19RfC_zxo38aq2a3ZstuaWDM79mXsj_sx/view?usp=sharing');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _launchUrl(String urlString) async {
    final uri = Uri.parse(urlString);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isWide = size.width > 900;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isWide ? 64 : 24,
        vertical: isWide ? 100 : 60,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: isWide ? _buildDesktopLayout() : _buildMobileLayout(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _buildHeroTextContent(true),
          ),
        ),
        const SizedBox(width: 48),
        Expanded(
          flex: 2,
          child: Center(
            child: _buildProfileAvatar(190),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildProfileAvatar(150),
        const SizedBox(height: 36),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: _buildHeroTextContent(false),
        ),
      ],
    );
  }

  List<Widget> _buildHeroTextContent(bool isLtr) {
    final textAlign = isLtr ? TextAlign.left : TextAlign.center;

    return [
      Text(
        '// HELLO WORLD, I\'M',
        style: GoogleFonts.jetBrainsMono(
          fontSize: 16,
          color: const Color(0xFF24DB67),
          fontWeight: FontWeight.w600,
          letterSpacing: 2.0,
        ),
      ),
      const SizedBox(height: 16),
      Text(
        'Fahim Montasir Opi',
        textAlign: textAlign,
        style: GoogleFonts.spaceGrotesk(
          fontSize: isLtr ? 64 : 44,
          fontWeight: FontWeight.w800,
          color: Colors.white,
          letterSpacing: -1.5,
          height: 1.1,
          shadows: [
            Shadow(
              color: const Color(0xFF24DB67).withValues(alpha: 0.3),
              blurRadius: 15,
            ),
          ],
        ),
      ),
      const SizedBox(height: 16),
      Text(
        'Associate Software Engineer',
        textAlign: textAlign,
        style: GoogleFonts.spaceGrotesk(
          fontSize: isLtr ? 26 : 20,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF24DB67),
          letterSpacing: 0.5,
        ),
      ),
      const SizedBox(height: 16),
      ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: Text(
          'Specializing in premium Flutter mobile and web development, High-Performance Online Travel Agency (OTA) booking engines, and automated AI-assisted workflows.',
          textAlign: textAlign,
          style: GoogleFonts.spaceGrotesk(
            fontSize: 17,
            color: const Color(0xFF9CA3AF),
            height: 1.6,
          ),
        ),
      ),
      const SizedBox(height: 36),
      Wrap(
        spacing: 16,
        runSpacing: 16,
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: isLtr ? WrapAlignment.start : WrapAlignment.center,
        children: [
          ElevatedButton(
            onPressed: widget.onViewProjects,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF24DB67),
              foregroundColor: const Color(0xFF0C0E12),
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 4,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'VIEW PROJECTS',
                  style: GoogleFonts.jetBrainsMono(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.arrow_forward_rounded, size: 16),
              ],
            ),
          ),
          OutlinedButton(
            onPressed: _launchCV,
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF24DB67),
              side: const BorderSide(color: Color(0xFF24DB67), width: 1.5),
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'DOWNLOAD CV',
                  style: GoogleFonts.jetBrainsMono(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.download_rounded, size: 16),
              ],
            ),
          ),
          _SocialIconButton(
            iconPath: 'assets/icons/github.svg',
            url: 'https://github.com/MontasirOpi',
            tooltip: 'GitHub Profile',
            onTap: () => _launchUrl('https://github.com/MontasirOpi'),
          ),
          _SocialIconButton(
            iconPath: 'assets/icons/linkedin.svg',
            url: 'https://www.linkedin.com/in/fahim-montasir-opi-161b65256/',
            tooltip: 'LinkedIn Profile',
            onTap: () => _launchUrl('https://www.linkedin.com/in/fahim-montasir-opi-161b65256/'),
          ),
        ],
      ),
    ];
  }

  Widget _buildProfileAvatar(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: const Color(0xFF24DB67),
          width: 3,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF24DB67).withValues(alpha: 0.15),
            blurRadius: 40,
            spreadRadius: 8,
          ),
        ],
        image: const DecorationImage(
          image: AssetImage('assets/images/profile.webp'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _SocialIconButton extends StatefulWidget {
  final String iconPath;
  final String url;
  final String tooltip;
  final VoidCallback onTap;

  const _SocialIconButton({
    required this.iconPath,
    required this.url,
    required this.tooltip,
    required this.onTap,
  });

  @override
  State<_SocialIconButton> createState() => _SocialIconButtonState();
}

class _SocialIconButtonState extends State<_SocialIconButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltip,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _isHovered
                  ? const Color(0xFF24DB67).withValues(alpha: 0.15)
                  : const Color(0xFF14161A).withValues(alpha: 0.5),
              border: Border.all(
                color: _isHovered
                    ? const Color(0xFF24DB67)
                    : const Color(0xFF1F2937),
                width: 1.5,
              ),
              boxShadow: [
                if (_isHovered)
                  BoxShadow(
                    color: const Color(0xFF24DB67).withValues(alpha: 0.3),
                    blurRadius: 12,
                    spreadRadius: 1,
                  ),
              ],
            ),
            child: SvgPicture.asset(
              widget.iconPath,
              width: 20,
              height: 20,
              colorFilter: ColorFilter.mode(
                _isHovered ? const Color(0xFF24DB67) : const Color(0xFFE0E6EB),
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
