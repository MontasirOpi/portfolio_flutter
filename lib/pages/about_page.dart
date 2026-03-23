import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeOut));

    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isWide = size.width > 900;
    
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isWide ? 64 : 24,
        vertical: isWide ? 80 : 40,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: SlideTransition(
            position: _slideAnimation,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                   _buildProfileImage(),
                   const SizedBox(height: 32),
                   _buildGreeting(),
                   const SizedBox(height: 16),
                   _buildNameHighlight(),
                   const SizedBox(height: 16),
                   _buildRoles(),
                   const SizedBox(height: 16),
                   _buildTechStacks(),
                   const SizedBox(height: 32),
                   _buildLocation(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return Container(
      width: 180,
      height: 180,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF24DB67).withOpacity(0.15),
            blurRadius: 60,
            spreadRadius: 10,
          ),
        ],
        border: Border.all(
          color: const Color(0xFF24DB67),
          width: 2,
        ),
        image: const DecorationImage(
          image: AssetImage('assets/images/opi1.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildGreeting() {
    return Text(
      '// Hello, I\'m',
      style: GoogleFonts.jetBrainsMono(
        fontSize: 16,
        color: const Color(0xFF24DB67),
        fontWeight: FontWeight.w500,
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _buildNameHighlight() {
    return Text(
      'Fahim Montasir Opi',
      textAlign: TextAlign.center,
      style: GoogleFonts.spaceGrotesk(
        fontSize: MediaQuery.of(context).size.width > 600 ? 56 : 40,
        fontWeight: FontWeight.w800,
        color: Colors.white,
        letterSpacing: -1.0,
        shadows: [
          Shadow(
            color: const Color(0xFF24DB67).withOpacity(0.5),
            blurRadius: 20,
          ),
          Shadow(
            color: const Color(0xFF24DB67).withOpacity(0.2),
            blurRadius: 40,
          ),
        ],
      ),
    );
  }

  Widget _buildRoles() {
    return Text(
      'Flutter Developer | Mobile & Web Specialist',
      textAlign: TextAlign.center,
      style: GoogleFonts.spaceGrotesk(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: const Color(0xFF9CA3AF),
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildTechStacks() {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 8,
      children: [
        _buildTechText('Flutter'),
        _buildDot(),
        _buildTechText('Dart'),
        _buildDot(),
        _buildTechText('Firebase'),
        _buildDot(),
        _buildTechText('Supabase'),
        _buildDot(),
        _buildTechText('GetX'),
        _buildDot(),
        _buildTechText('BLoC'),
      ],
    );
  }

  Widget _buildTechText(String text) {
    return Text(
      text,
      style: GoogleFonts.jetBrainsMono(
        fontSize: 14,
        color: const Color(0xFF24DB67),
      ),
    );
  }

  Widget _buildDot() {
    return const Text(
      '•',
      style: TextStyle(
        fontSize: 14,
        color: Color(0xFF9CA3AF),
      ),
    );
  }

  Widget _buildLocation() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.location_on_outlined, color: Color(0xFF9CA3AF), size: 16),
        const SizedBox(width: 8),
        Text(
          'Dhaka, Bangladesh',
          style: GoogleFonts.spaceGrotesk(
            fontSize: 14,
            color: const Color(0xFF9CA3AF),
          ),
        ),
      ],
    );
  }
}
