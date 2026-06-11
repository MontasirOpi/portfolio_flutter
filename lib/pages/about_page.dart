import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

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
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isWide = size.width > 950;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isWide ? 64 : 24,
        vertical: 80,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '// ABOUT ME',
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF24DB67),
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 48),
                isWide
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Expanded(
                            flex: 5,
                            child: Center(child: SmartphoneMockup()),
                          ),
                          const SizedBox(width: 64),
                          Expanded(
                            flex: 6,
                            child: _buildDetailsSection(true),
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SmartphoneMockup(),
                          const SizedBox(height: 60),
                          _buildDetailsSection(false),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailsSection(bool isDesktop) {
    final skills = [
      'Flutter',
      'Dart',
      'GetX',
      'REST API',
      'Firebase',
      'Android',
      'OTA Systems',
      'eSIM',
      'Travel Technology',
      'AI Development',
      'Cursor AI',
      'Agentic AI',
      'GitHub',
      'Play Store Deployment',
    ];

    return Column(
      crossAxisAlignment: isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        _buildBiographyText(isDesktop),
        const SizedBox(height: 36),
        Text(
          "METRICS & STATISTICS",
          style: GoogleFonts.jetBrainsMono(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF9CA3AF),
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 16),
        _buildStatsGrid(isDesktop),
        const SizedBox(height: 36),
        Text(
          "TECHNOLOGY STACK",
          style: GoogleFonts.jetBrainsMono(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF9CA3AF),
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          alignment: isDesktop ? WrapAlignment.start : WrapAlignment.center,
          children: skills.map((s) => _SkillTagChip(label: s)).toList(),
        ),
      ],
    );
  }

  Widget _buildBiographyText(bool isDesktop) {
    final textAlign = isDesktop ? TextAlign.left : TextAlign.center;
    final crossAxisAlignment = isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.center;

    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          'Mobile Application Developer &\nAI-Assisted Software Engineer',
          textAlign: textAlign,
          style: GoogleFonts.spaceGrotesk(
            fontSize: isDesktop ? 30 : 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            height: 1.2,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'I am a Flutter Developer specializing in building scalable mobile applications and travel technology platforms. My expertise includes OTA systems, flight booking, hotel booking, transfer management, insurance integration, and eSIM solutions.',
          textAlign: textAlign,
          style: GoogleFonts.spaceGrotesk(
            fontSize: 15.5,
            color: const Color(0xFF9CA3AF),
            height: 1.6,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'I develop high-performance Android and cross-platform applications using Flutter, GetX, REST APIs, and modern software architecture principles. I have experience deploying and maintaining production applications on the Google Play Store while continuously improving performance, user experience, and maintainability.',
          textAlign: textAlign,
          style: GoogleFonts.spaceGrotesk(
            fontSize: 15.5,
            color: const Color(0xFF9CA3AF),
            height: 1.6,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'I also leverage modern AI tools and agentic workflows to accelerate development, debugging, code reviews, documentation, and automation, enabling faster delivery of high-quality software solutions.',
          textAlign: textAlign,
          style: GoogleFonts.spaceGrotesk(
            fontSize: 15.5,
            color: const Color(0xFF9CA3AF),
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildStatsGrid(bool isDesktop) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      alignment: isDesktop ? WrapAlignment.start : WrapAlignment.center,
      children: [
        _buildStatCard(label: 'Experience', counterVal: 2, suffix: '+ Years'),
        _buildStatCard(label: 'Projects Completed', counterVal: 10, suffix: '+'),
        _buildStatCard(label: 'Lines of Code', counterVal: 50000, suffix: '+'),
        _buildStatCard(label: 'Apps Published', staticText: 'Multiple'),
      ],
    );
  }

  Widget _buildStatCard({required String label, int? counterVal, String? staticText, String suffix = "+"}) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF14161A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF1F2937),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (counterVal != null)
            AnimatedCounter(targetValue: counterVal, suffix: suffix)
          else if (staticText != null)
            Text(
              staticText,
              style: GoogleFonts.spaceGrotesk(
                fontSize: 26,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF24DB67),
                shadows: [
                  Shadow(
                    color: const Color(0xFF24DB67).withValues(alpha: 0.25),
                    blurRadius: 10,
                  ),
                ],
              ),
            ),
          const SizedBox(height: 6),
          Text(
            label,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 12,
              color: const Color(0xFF9CA3AF),
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedCounter extends StatefulWidget {
  final int targetValue;
  final String suffix;
  final Duration duration;

  const AnimatedCounter({
    super.key,
    required this.targetValue,
    required this.suffix,
    this.duration = const Duration(seconds: 2),
  });

  @override
  State<AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _animation = IntTween(begin: 0, end: widget.targetValue).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        String displayVal;
        if (widget.targetValue == 50000) {
          final kVal = (_animation.value / 1000).toStringAsFixed(0);
          displayVal = "${kVal}K";
        } else {
          displayVal = _animation.value.toString();
        }

        return Text(
          "$displayVal${widget.suffix}",
          style: GoogleFonts.spaceGrotesk(
            fontSize: 26,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF24DB67),
            shadows: [
              Shadow(
                color: const Color(0xFF24DB67).withValues(alpha: 0.25),
                blurRadius: 10,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SkillTagChip extends StatefulWidget {
  final String label;

  const _SkillTagChip({required this.label});

  @override
  State<_SkillTagChip> createState() => _SkillTagChipState();
}

class _SkillTagChipState extends State<_SkillTagChip> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: _isHovered
              ? const Color(0xFF24DB67).withValues(alpha: 0.1)
              : const Color(0xFF14161A),
          border: Border.all(
            color: _isHovered
                ? const Color(0xFF24DB67)
                : const Color(0xFF1F2937),
            width: 1.2,
          ),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            if (_isHovered)
              BoxShadow(
                color: const Color(0xFF24DB67).withValues(alpha: 0.15),
                blurRadius: 8,
              ),
          ],
        ),
        child: Text(
          widget.label,
          style: GoogleFonts.jetBrainsMono(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: _isHovered ? const Color(0xFF24DB67) : const Color(0xFF9CA3AF),
          ),
        ),
      ),
    );
  }
}

class SmartphoneMockup extends StatefulWidget {
  const SmartphoneMockup({super.key});

  @override
  State<SmartphoneMockup> createState() => _SmartphoneMockupState();
}

class _SmartphoneMockupState extends State<SmartphoneMockup> with SingleTickerProviderStateMixin {
  late PageController _pageController;
  int _currentPage = 0;
  late AnimationController _floatController;
  late Animation<double> _floatAnimation;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    
    // Auto-slide pages every 3.5 seconds
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAutoSlide();
    });

    _floatController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(begin: -12, end: 12).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );
  }

  void _startAutoSlide() {
    Future.delayed(const Duration(seconds: 4), () {
      if (!mounted) return;
      final nextPage = (_currentPage + 1) % 5;
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      ).then((_) {
        _currentPage = nextPage;
        _startAutoSlide();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _floatAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _floatAnimation.value),
          child: child,
        );
      },
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          // Background Glow
          Container(
            width: 260,
            height: 480,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF24DB67).withValues(alpha: 0.05),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF24DB67).withValues(alpha: 0.05),
                  blurRadius: 100,
                  spreadRadius: 20,
                )
              ],
            ),
          ),
          
          // Rotating Ring Orbit
          const _RotatingTechRing(),
          
          // Smartphone Mockup Frame
          Container(
            width: 245,
            height: 490,
            decoration: BoxDecoration(
              color: const Color(0xFF0C0E12),
              borderRadius: BorderRadius.circular(36),
              border: Border.all(
                color: const Color(0xFF1F2937),
                width: 8,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.5),
                  blurRadius: 25,
                  offset: const Offset(0, 15),
                ),
                BoxShadow(
                  color: const Color(0xFF24DB67).withValues(alpha: 0.03),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: Stack(
                children: [
                  PageView(
                    controller: _pageController,
                    onPageChanged: (index) => _currentPage = index,
                    children: [
                      _buildTravelScreen(),
                      _buildHotelScreen(),
                      _buildFlightScreen(),
                      _buildInsuranceScreen(),
                      _buildESimScreen(),
                    ],
                  ),
                  
                  // Camera Punch Hole / Dynamic Island
                  Positioned(
                    top: 10,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        width: 75,
                        height: 18,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1F2937),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Floating Badges (Asynchronously animated)
          Positioned(
            left: -65,
            top: 40,
            child: const _FloatingBadgeWidget(text: "Flutter Developer", icon: Icons.flutter_dash_rounded),
          ),
          Positioned(
            right: -65,
            top: 100,
            child: const _FloatingBadgeWidget(text: "Mobile Engineer", icon: Icons.phone_android_rounded),
          ),
          Positioned(
            left: -55,
            bottom: 120,
            child: const _FloatingBadgeWidget(text: "OTA Specialist", icon: Icons.explore_rounded),
          ),
          Positioned(
            right: -75,
            bottom: 60,
            child: const _FloatingBadgeWidget(text: "AI-Assisted Dev", icon: Icons.psychology_rounded),
          ),
          
          // Floating Tech Icons
          Positioned(
            left: -40,
            top: 180,
            child: _FloatingIconWidget(
              offsetMultiplier: 1,
              child: SvgPicture.asset(
                'assets/icons/flutter.svg',
                width: 22,
                height: 22,
              ),
            ),
          ),
          Positioned(
            right: -30,
            top: 240,
            child: const _FloatingIconWidget(
              offsetMultiplier: 2,
              child: Icon(Icons.android_rounded, size: 24, color: Color(0xFF24DB67)),
            ),
          ),
          Positioned(
            left: -30,
            bottom: 40,
            child: const _FloatingIconWidget(
              offsetMultiplier: 3,
              child: Icon(Icons.psychology_rounded, size: 24, color: Colors.blueAccent),
            ),
          ),
        ],
      ),
    );
  }

  // --- Mock Screen Builders ---

  Widget _buildTravelScreen() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0F172A), Color(0xFF0C0E12)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      padding: const EdgeInsets.fromLTRB(14, 38, 14, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Nosafer Travel",
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF24DB67),
                ),
              ),
              const Icon(Icons.notifications_outlined, size: 16, color: Colors.white),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            "Explore\nThe World",
            style: GoogleFonts.spaceGrotesk(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF1E293B),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFF334155)),
            ),
            child: Row(
              children: [
                const Icon(Icons.search, size: 14, color: Color(0xFF94A3B8)),
                const SizedBox(width: 8),
                Text(
                  "Where to go next?",
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 11,
                    color: const Color(0xFF94A3B8),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: ["Flights", "Hotels", "Visas", "eSIM"].map((cat) {
                final isSelected = cat == "Flights";
                return Container(
                  margin: const EdgeInsets.only(right: 6),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFF24DB67) : const Color(0xFF1E293B),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    cat,
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? const Color(0xFF0C0E12) : Colors.white,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(
                  colors: [Color(0xFF1E1B4B), Color(0xFF311042)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border.all(color: const Color(0xFF4338CA).withValues(alpha: 0.3)),
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFF24DB67).withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      "PROMO",
                      style: GoogleFonts.jetBrainsMono(
                        fontSize: 8,
                        color: const Color(0xFF24DB67),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    "Summer Deal\n30% OFF Flights",
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Book by June 30",
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 9,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHotelScreen() {
    return Container(
      color: const Color(0xFF0F172A),
      padding: const EdgeInsets.fromLTRB(14, 38, 14, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.arrow_back_ios, size: 12, color: Colors.white),
                  const SizedBox(width: 6),
                  Text(
                    "Hotel Details",
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const Icon(Icons.favorite_border, size: 16, color: Colors.white),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: const LinearGradient(
                  colors: [Color(0xFF020617), Color(0xFF1E293B)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border.all(color: const Color(0xFF334155)),
              ),
              child: Stack(
                children: [
                  const Center(
                    child: Icon(Icons.hotel_rounded, size: 40, color: Color(0xFF24DB67)),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.star, size: 10, color: Color(0xFFFFC107)),
                          const SizedBox(width: 2),
                          Text(
                            "4.9",
                            style: GoogleFonts.spaceGrotesk(fontSize: 9, color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "Grand Palace Resort",
            style: GoogleFonts.spaceGrotesk(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.location_on, size: 10, color: Color(0xFF24DB67)),
              const SizedBox(width: 4),
              Text(
                "Dubai Marina, UAE",
                style: GoogleFonts.spaceGrotesk(fontSize: 10, color: const Color(0xFF94A3B8)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildAmenityChip(Icons.wifi, "WiFi"),
              _buildAmenityChip(Icons.pool, "Pool"),
              _buildAmenityChip(Icons.spa, "Spa"),
              _buildAmenityChip(Icons.restaurant, "Food"),
            ],
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Price",
                    style: GoogleFonts.spaceGrotesk(fontSize: 9, color: const Color(0xFF94A3B8)),
                  ),
                  Text(
                    "\$180/night",
                    style: GoogleFonts.spaceGrotesk(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFF24DB67),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  "Book Now",
                  style: GoogleFonts.spaceGrotesk(fontSize: 10, fontWeight: FontWeight.bold, color: const Color(0xFF0C0E12)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAmenityChip(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: const Color(0xFF1E293B),
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFF334155)),
          ),
          child: Icon(icon, size: 12, color: const Color(0xFF24DB67)),
        ),
        const SizedBox(height: 4),
        Text(label, style: GoogleFonts.spaceGrotesk(fontSize: 8, color: const Color(0xFF94A3B8))),
      ],
    );
  }

  Widget _buildFlightScreen() {
    return Container(
      color: const Color(0xFF0C0E12),
      padding: const EdgeInsets.fromLTRB(14, 38, 14, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.arrow_back_ios, size: 12, color: Colors.white),
                  const SizedBox(width: 6),
                  Text(
                    "Select Flight",
                    style: GoogleFonts.spaceGrotesk(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ],
              ),
              const Icon(Icons.filter_list_rounded, size: 16, color: Colors.white),
            ],
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF14161A),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF24DB67).withValues(alpha: 0.15)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("DAC", style: GoogleFonts.spaceGrotesk(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.white)),
                        Text("Dhaka", style: GoogleFonts.spaceGrotesk(fontSize: 9, color: const Color(0xFF9CA3AF))),
                      ],
                    ),
                    Column(
                      children: [
                        const Icon(Icons.flight_takeoff_rounded, size: 13, color: Color(0xFF24DB67)),
                        Container(
                          width: 45,
                          height: 1,
                          color: const Color(0xFF1F2937),
                        ),
                        Text("5h 15m", style: GoogleFonts.jetBrainsMono(fontSize: 7, color: const Color(0xFF24DB67))),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("DXB", style: GoogleFonts.spaceGrotesk(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.white)),
                        Text("Dubai", style: GoogleFonts.spaceGrotesk(fontSize: 9, color: const Color(0xFF9CA3AF))),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Divider(color: Color(0xFF1F2937), thickness: 1, height: 1),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildTicketDetail("Date", "14 June, 2026"),
                    _buildTicketDetail("Dep Time", "14:30"),
                    _buildTicketDetail("Class", "Economy"),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _buildFlightListItem("Emirates", "08:15", "12:30", "\$420"),
          const SizedBox(height: 8),
          _buildFlightListItem("FlyDubai", "18:00", "22:15", "\$350"),
          const Spacer(),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF24DB67)),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: Text(
                "Confirm & Select Seat",
                style: GoogleFonts.spaceGrotesk(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF24DB67)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTicketDetail(String title, String val) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: GoogleFonts.spaceGrotesk(fontSize: 8, color: const Color(0xFF9CA3AF))),
        const SizedBox(height: 2),
        Text(val, style: GoogleFonts.spaceGrotesk(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.white)),
      ],
    );
  }

  Widget _buildFlightListItem(String airline, String dep, String arr, String price) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF14161A),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF1F2937)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.flight_rounded, size: 12, color: Color(0xFF24DB67)),
              const SizedBox(width: 6),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(airline, style: GoogleFonts.spaceGrotesk(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white)),
                  Text("$dep - $arr", style: GoogleFonts.spaceGrotesk(fontSize: 8, color: const Color(0xFF9CA3AF))),
                ],
              ),
            ],
          ),
          Text(price, style: GoogleFonts.spaceGrotesk(fontSize: 10, fontWeight: FontWeight.bold, color: const Color(0xFF24DB67))),
        ],
      ),
    );
  }

  Widget _buildInsuranceScreen() {
    return Container(
      color: const Color(0xFF0F172A),
      padding: const EdgeInsets.fromLTRB(14, 38, 14, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.arrow_back_ios, size: 12, color: Colors.white),
                  const SizedBox(width: 6),
                  Text(
                    "Travel Insurance",
                    style: GoogleFonts.spaceGrotesk(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ],
              ),
              const Icon(Icons.security, size: 16, color: Colors.white),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            "Select Plan",
            style: GoogleFonts.spaceGrotesk(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 12),
          _buildInsurancePlanCard(
            title: "Premium Guard",
            price: "\$25/trip",
            subtitle: "100% Medical Coverage",
            isSelected: true,
          ),
          const SizedBox(height: 10),
          _buildInsurancePlanCard(
            title: "Basic Shield",
            price: "\$12/trip",
            subtitle: "Essential flight coverage",
            isSelected: false,
          ),
          const SizedBox(height: 16),
          Text(
            "PLAN BENEFITS",
            style: GoogleFonts.jetBrainsMono(fontSize: 8, fontWeight: FontWeight.bold, color: const Color(0xFF94A3B8)),
          ),
          const SizedBox(height: 6),
          _buildBenefitItem("COVID-19 Medical coverage up to \$100k"),
          _buildBenefitItem("Trip delay & cancellation protection"),
          _buildBenefitItem("Baggage loss/damage protection"),
          const Spacer(),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFF24DB67),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: Text(
                "Select Premium Guard",
                style: GoogleFonts.spaceGrotesk(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF0C0E12)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInsurancePlanCard({required String title, required String price, required String subtitle, required bool isSelected}) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF1E293B) : const Color(0xFF14161A),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isSelected ? const Color(0xFF24DB67) : const Color(0xFF1F2937),
          width: isSelected ? 1.2 : 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: GoogleFonts.spaceGrotesk(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 2),
              Text(subtitle, style: GoogleFonts.spaceGrotesk(fontSize: 9, color: const Color(0xFF94A3B8))),
            ],
          ),
          Text(price, style: GoogleFonts.spaceGrotesk(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF24DB67))),
        ],
      ),
    );
  }

  Widget _buildBenefitItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        children: [
          const Icon(Icons.check, size: 10, color: Color(0xFF24DB67)),
          const SizedBox(width: 6),
          Expanded(
            child: Text(text, style: GoogleFonts.spaceGrotesk(fontSize: 9, color: Colors.white70)),
          ),
        ],
      ),
    );
  }

  Widget _buildESimScreen() {
    return Container(
      color: const Color(0xFF0C0E12),
      padding: const EdgeInsets.fromLTRB(14, 38, 14, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.arrow_back_ios, size: 12, color: Colors.white),
                  const SizedBox(width: 6),
                  Text(
                    "Global eSIM",
                    style: GoogleFonts.spaceGrotesk(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ],
              ),
              const Icon(Icons.wifi_tethering_rounded, size: 16, color: Colors.white),
            ],
          ),
          const SizedBox(height: 18),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: const LinearGradient(
                colors: [Color(0xFF2E1065), Color(0xFF14161A)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              border: Border.all(color: const Color(0xFF7C3AED).withValues(alpha: 0.25)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.sim_card_outlined, size: 20, color: Color(0xFF24DB67)),
                    Text(
                      "LTE / 5G",
                      style: GoogleFonts.jetBrainsMono(fontSize: 7, color: Colors.white70, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Text(
                  "UAE eSIM Plan",
                  style: GoogleFonts.spaceGrotesk(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 2),
                Text(
                  "10 GB Data / 30 Days",
                  style: GoogleFonts.spaceGrotesk(fontSize: 10, color: const Color(0xFF24DB67)),
                ),
                const SizedBox(height: 12),
                Text(
                  "Status: Ready to install",
                  style: GoogleFonts.spaceGrotesk(fontSize: 9, color: const Color(0xFF9CA3AF)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Text(
            "Destination",
            style: GoogleFonts.spaceGrotesk(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF14161A),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFF1F2937)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.map_rounded, size: 12, color: Color(0xFF24DB67)),
                    const SizedBox(width: 6),
                    Text("United Arab Emirates", style: GoogleFonts.spaceGrotesk(fontSize: 10, color: Colors.white)),
                  ],
                ),
                const Icon(Icons.keyboard_arrow_down, size: 12, color: Colors.white),
              ],
            ),
          ),
          const Spacer(),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFF24DB67),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: Text(
                "Activate eSIM Plan",
                style: GoogleFonts.spaceGrotesk(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF0C0E12)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RotatingTechRing extends StatefulWidget {
  const _RotatingTechRing();

  @override
  State<_RotatingTechRing> createState() => _RotatingTechRingState();
}

class _RotatingTechRingState extends State<_RotatingTechRing> with SingleTickerProviderStateMixin {
  late AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      duration: const Duration(seconds: 16),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _rotationController,
      child: Container(
        width: 300,
        height: 300,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: const Color(0xFF24DB67).withValues(alpha: 0.15),
            width: 1.2,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 150 - 6,
              child: Container(
                width: 12,
                height: 12,
                decoration: const BoxDecoration(
                  color: Color(0xFF24DB67),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 150 - 6,
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF24DB67), width: 2),
                  color: const Color(0xFF0C0E12),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FloatingBadgeWidget extends StatefulWidget {
  final String text;
  final IconData icon;

  const _FloatingBadgeWidget({required this.text, required this.icon});

  @override
  State<_FloatingBadgeWidget> createState() => _FloatingBadgeWidgetState();
}

class _FloatingBadgeWidgetState extends State<_FloatingBadgeWidget> with SingleTickerProviderStateMixin {
  late AnimationController _floatController;
  late Animation<double> _floatAnimation;

  @override
  void initState() {
    super.initState();
    _floatController = AnimationController(
      duration: Duration(milliseconds: 3000 + widget.text.hashCode % 1500),
      vsync: this,
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(begin: -6, end: 6).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _floatAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _floatAnimation.value),
          child: child,
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFF14161A).withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color(0xFF24DB67).withValues(alpha: 0.2),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(widget.icon, size: 12, color: const Color(0xFF24DB67)),
            const SizedBox(width: 5),
            Text(
              widget.text,
              style: GoogleFonts.spaceGrotesk(
                fontSize: 10.5,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FloatingIconWidget extends StatefulWidget {
  final Widget child;
  final int offsetMultiplier;

  const _FloatingIconWidget({required this.child, required this.offsetMultiplier});

  @override
  State<_FloatingIconWidget> createState() => _FloatingIconWidgetState();
}

class _FloatingIconWidgetState extends State<_FloatingIconWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 2500 + widget.offsetMultiplier * 500),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: -8, end: 8).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_animation.value * 0.4, _animation.value),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
