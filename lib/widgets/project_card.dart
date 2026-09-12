import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_flutter/models/project.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectCard extends StatefulWidget {
  final Project project;

  const ProjectCard({super.key, required this.project});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  void _showDetailsDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.75),
      builder: (dialogContext) {
        return _ProjectDetailsDialog(project: widget.project);
      },
    );
  }

  Widget _buildStatusBadge(String category) {
    final Color badgeColor;
    final String statusText;

    switch (category) {
      case "AI & Mobile":
        badgeColor = const Color(0xFF00E5FF);
        statusText = "AI AGENT";
        break;
      case "Full-Stack":
        badgeColor = const Color(0xFFB388FF);
        statusText = "FULL-STACK";
        break;
      case "Package":
        badgeColor = const Color(0xFFFFC107);
        statusText = "PACKAGE";
        break;
      case "Web":
        badgeColor = const Color(0xFF00B0FF);
        statusText = "WEB APP";
        break;
      case "Mobile":
      default:
        badgeColor = const Color(0xFF24DB67);
        statusText = "PRODUCTION";
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF0C0E12).withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: badgeColor.withValues(alpha: 0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: badgeColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: badgeColor.withValues(alpha: 0.6),
                  blurRadius: 4,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
          const SizedBox(width: 6),
          Text(
            statusText,
            style: GoogleFonts.jetBrainsMono(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isFeatured = widget.project.title.contains("NoSafer") ||
        widget.project.title.contains("Travojet") ||
        widget.project.title.contains("Mehndi") ||
        widget.project.title.contains("date_with");

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _showDetailsDialog(context),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          transform: Matrix4.translationValues(0.0, _isHovered ? -6.0 : 0.0, 0.0),
          decoration: BoxDecoration(
            color: const Color(0xFF14161A),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _isHovered
                  ? const Color(0xFF24DB67).withValues(alpha: 0.6)
                  : (isFeatured
                      ? const Color(0xFF24DB67).withValues(alpha: 0.25)
                      : const Color(0xFF1F2937)),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: _isHovered
                    ? const Color(0xFF24DB67).withValues(alpha: 0.15)
                    : Colors.black.withValues(alpha: 0.3),
                blurRadius: _isHovered ? 25 : 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Image / Backdrop header
                SizedBox(
                  height: 165,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: _ProjectCardImage(project: widget.project),
                      ),
                      // Shadow overlay for image readability
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.black.withValues(alpha: 0.65),
                                Colors.transparent,
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                        ),
                      ),
                      // Status badge overlay
                      Positioned(
                        top: 14,
                        left: 14,
                        child: _buildStatusBadge(widget.project.category),
                      ),
                      // Featured badge overlay
                      if (isFeatured)
                        Positioned(
                          top: 14,
                          right: 14,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: const Color(0xFF24DB67),
                              borderRadius: BorderRadius.circular(4),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF24DB67).withValues(alpha: 0.4),
                                  blurRadius: 8,
                                )
                              ],
                            ),
                            child: Text(
                              "FEATURED",
                              style: GoogleFonts.jetBrainsMono(
                                fontSize: 9.5,
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFF0C0E12),
                                letterSpacing: 0.8,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                // Details section
                Expanded(
                  child: _ProjectCardDetails(
                    project: widget.project,
                    onOpenDetails: () => _showDetailsDialog(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ProjectCardImage extends StatelessWidget {
  final Project project;

  const _ProjectCardImage({required this.project});

  @override
  Widget build(BuildContext context) {
    if (project.networkImage != null) {
      return Image.network(
        project.networkImage!,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
        cacheWidth: 400,
        cacheHeight: 225,
      );
    } else if (project.image != null) {
      final webpPath = project.image!
          .replaceAll('.png', '.webp')
          .replaceAll('.jpg', '.webp')
          .replaceAll('.jpeg', '.webp');
      
      return Image.asset(
        webpPath,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
        cacheWidth: 400,
        cacheHeight: 225,
      );
    } else {
      // Tech-specific stylized placeholder
      final isTravel = project.title.toLowerCase().contains('safer') ||
          project.title.toLowerCase().contains('travojet');
      final isAI = project.category.toLowerCase().contains('ai') ||
          project.title.toLowerCase().contains('agent');
      final isFullStack = project.category.toLowerCase().contains('full') ||
          project.title.toLowerCase().contains('task');
      final isPackage = project.category.toLowerCase().contains('package');

      final IconData displayIcon;
      final Color iconAccent;
      final List<Color> gradientColors;

      if (isAI) {
        displayIcon = Icons.auto_awesome_rounded;
        iconAccent = const Color(0xFF00E5FF);
        gradientColors = const [Color(0xFF092026), Color(0xFF0C0E12)];
      } else if (isFullStack) {
        displayIcon = Icons.layers_rounded;
        iconAccent = const Color(0xFFB388FF);
        gradientColors = const [Color(0xFF1D142E), Color(0xFF0C0E12)];
      } else if (isTravel) {
        displayIcon = Icons.flight_takeoff_rounded;
        iconAccent = const Color(0xFF24DB67);
        gradientColors = const [Color(0xFF0E2419), Color(0xFF0C0E12)];
      } else if (isPackage) {
        displayIcon = Icons.extension_rounded;
        iconAccent = const Color(0xFFFFC107);
        gradientColors = const [Color(0xFF262010), Color(0xFF0C0E12)];
      } else {
        displayIcon = Icons.phone_android_rounded;
        iconAccent = const Color(0xFF24DB67);
        gradientColors = const [Color(0xFF1A1D24), Color(0xFF0C0E12)];
      }

      final words = project.title.split(' ');
      final initials = words.length > 1
          ? '${words[0][0]}${words[1][0]}'.toUpperCase()
          : project.title.substring(0, (project.title.length >= 2 ? 2 : 1)).toUpperCase();

      return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              right: -10,
              bottom: -20,
              child: Text(
                initials,
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 90,
                  fontWeight: FontWeight.w900,
                  color: Colors.white.withValues(alpha: 0.03),
                  letterSpacing: -4,
                ),
              ),
            ),
            Center(
              child: Icon(
                displayIcon,
                size: 52,
                color: iconAccent.withValues(alpha: 0.35),
              ),
            ),
          ],
        ),
      );
    }
  }
}

class _ProjectCardDetails extends StatelessWidget {
  final Project project;
  final VoidCallback onOpenDetails;

  const _ProjectCardDetails({
    required this.project,
    required this.onOpenDetails,
  });

  Future<void> _launchUrl(BuildContext context, String urlString) async {
    final url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Could not open link'),
          backgroundColor: Colors.red.shade700,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            project.title,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: -0.5,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 6),

          // Metrics Chips (Performance & Impact)
          if (project.performanceMetric != null || project.userMetric != null) ...[
            Wrap(
              spacing: 6,
              runSpacing: 4,
              children: [
                if (project.performanceMetric != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFF24DB67).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: const Color(0xFF24DB67).withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.bolt_rounded, size: 12, color: Color(0xFF24DB67)),
                        const SizedBox(width: 3),
                        Text(
                          project.performanceMetric!,
                          style: GoogleFonts.jetBrainsMono(
                            fontSize: 9.5,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF24DB67),
                          ),
                        ),
                      ],
                    ),
                  ),
                if (project.userMetric != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1F2937).withValues(alpha: 0.8),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: const Color(0xFF374151)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.verified_rounded, size: 11, color: Color(0xFF60A5FA)),
                        const SizedBox(width: 3),
                        Text(
                          project.userMetric!,
                          style: GoogleFonts.jetBrainsMono(
                            fontSize: 9.5,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFFD1D5DB),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
          ],

          // Description
          Text(
            project.description,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 12.5,
              color: const Color(0xFF9CA3AF),
              height: 1.35,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),

          // Tech Badges
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              ...project.technologies.take(3).map((tech) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F2937).withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: const Color(0xFF1F2937)),
                  ),
                  child: Text(
                    tech,
                    style: GoogleFonts.jetBrainsMono(
                      fontSize: 9.5,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF24DB67),
                    ),
                  ),
                );
              }),
              if (project.technologies.length > 3)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F2937).withValues(alpha: 0.8),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: const Color(0xFF374151)),
                  ),
                  child: Text(
                    '+${project.technologies.length - 3}',
                    style: GoogleFonts.jetBrainsMono(
                      fontSize: 9.5,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF9CA3AF),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),

          // Divider
          Container(height: 1, color: const Color(0xFF1F2937)),
          const SizedBox(height: 8),

          // Achievements Checklist Header
          Text(
            "KEY HIGHLIGHTS",
            style: GoogleFonts.jetBrainsMono(
              fontSize: 9.5,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF9CA3AF),
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 6),

          // Key Highlights (top 2 to guarantee zero overflow)
          Expanded(
            child: Column(
              children: project.keyAchievements.take(2).map((achievement) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 3.0),
                        child: Icon(
                          Icons.check_circle_outline_rounded,
                          size: 12,
                          color: Color(0xFF24DB67),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          achievement,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 12,
                            color: const Color(0xFFE0E6EB),
                            height: 1.25,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 8),

          // Buttons CTA Wrap
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              // Details Button
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  side: const BorderSide(color: Color(0xFF24DB67), width: 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  foregroundColor: const Color(0xFF24DB67),
                ),
                onPressed: onOpenDetails,
                icon: const Icon(Icons.visibility_outlined, size: 13),
                label: Text(
                  'Details',
                  style: GoogleFonts.jetBrainsMono(
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              ),
              _buildActionButton(
                context: context,
                iconPath: 'assets/icons/github.svg',
                label: 'Source',
                url: project.githubLink,
              ),
              if (project.pubDevLink != null)
                _buildActionButton(
                  context: context,
                  iconPath: null,
                  iconData: Icons.extension_rounded,
                  label: 'Pub.dev',
                  url: project.pubDevLink!,
                ),
              if (project.liveDemoLink != null)
                _buildActionButton(
                  context: context,
                  iconPath: null,
                  iconData: Icons.open_in_new_rounded,
                  label: 'Demo',
                  url: project.liveDemoLink!,
                ),
              if (project.playStoreLink != null)
                _buildActionButton(
                  context: context,
                  iconPath: null,
                  iconData: Icons.play_arrow_rounded,
                  label: 'Play Store',
                  url: project.playStoreLink!,
                ),
              if (project.appStoreLink != null)
                _buildActionButton(
                  context: context,
                  iconPath: null,
                  iconData: Icons.apple_rounded,
                  label: 'App Store',
                  url: project.appStoreLink!,
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required BuildContext context,
    required String? iconPath,
    IconData? iconData,
    required String label,
    required String url,
  }) {
    final child = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (iconPath != null)
          SvgPicture.asset(
            iconPath,
            height: 13,
            width: 13,
            colorFilter: const ColorFilter.mode(Color(0xFFE0E6EB), BlendMode.srcIn),
          )
        else if (iconData != null)
          Icon(iconData, size: 13, color: const Color(0xFFE0E6EB)),
        const SizedBox(width: 5),
        Text(
          label,
          style: GoogleFonts.jetBrainsMono(
            fontWeight: FontWeight.bold,
            fontSize: 10.5,
            color: const Color(0xFFE0E6EB),
          ),
        ),
      ],
    );

    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        side: const BorderSide(color: Color(0xFF1F2937), width: 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        foregroundColor: const Color(0xFF24DB67),
      ),
      onPressed: () => _launchUrl(context, url),
      child: child,
    );
  }
}

class _ProjectDetailsDialog extends StatelessWidget {
  final Project project;

  const _ProjectDetailsDialog({required this.project});

  Future<void> _launchUrl(BuildContext context, String urlString) async {
    final url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Could not open link'),
          backgroundColor: Colors.red.shade700,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 32,
        vertical: 24,
      ),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 700, maxHeight: 720),
        decoration: BoxDecoration(
          color: const Color(0xFF111418),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: const Color(0xFF24DB67).withValues(alpha: 0.35),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.7),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
            BoxShadow(
              color: const Color(0xFF24DB67).withValues(alpha: 0.08),
              blurRadius: 40,
              spreadRadius: 2,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Dialog Header
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                decoration: const BoxDecoration(
                  color: Color(0xFF16191F),
                  border: Border(
                    bottom: BorderSide(color: Color(0xFF1F2937), width: 1),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF24DB67).withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: const Color(0xFF24DB67).withValues(alpha: 0.3),
                        ),
                      ),
                      child: Text(
                        project.category.toUpperCase(),
                        style: GoogleFonts.jetBrainsMono(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF24DB67),
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.close_rounded, color: Color(0xFF9CA3AF), size: 22),
                      tooltip: 'Close',
                      splashRadius: 20,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),

              // Dialog Scrollable Content
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Project Title
                      Text(
                        project.title,
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Key Metrics Banner (if present)
                      if (project.performanceMetric != null || project.userMetric != null) ...[
                        Wrap(
                          spacing: 12,
                          runSpacing: 10,
                          children: [
                            if (project.performanceMetric != null)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF24DB67).withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: const Color(0xFF24DB67).withValues(alpha: 0.35),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.bolt_rounded, size: 16, color: Color(0xFF24DB67)),
                                    const SizedBox(width: 6),
                                    Text(
                                      "Performance: ${project.performanceMetric!}",
                                      style: GoogleFonts.jetBrainsMono(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFF24DB67),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            if (project.userMetric != null)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF1F2937).withValues(alpha: 0.8),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: const Color(0xFF374151)),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.verified_rounded, size: 16, color: Color(0xFF60A5FA)),
                                    const SizedBox(width: 6),
                                    Text(
                                      "Impact: ${project.userMetric!}",
                                      style: GoogleFonts.jetBrainsMono(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFFE5E7EB),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],

                      // Section: Overview
                      Text(
                        "// OVERVIEW",
                        style: GoogleFonts.jetBrainsMono(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF24DB67),
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        project.description,
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 15,
                          color: const Color(0xFFD1D5DB),
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Section: Key Architectural Highlights
                      Text(
                        "// KEY ARCHITECTURAL HIGHLIGHTS",
                        style: GoogleFonts.jetBrainsMono(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF24DB67),
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ...project.keyAchievements.map((achievement) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 3.0),
                                child: Icon(
                                  Icons.check_circle_rounded,
                                  size: 16,
                                  color: Color(0xFF24DB67),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  achievement,
                                  style: GoogleFonts.spaceGrotesk(
                                    fontSize: 13.5,
                                    color: const Color(0xFFE5E7EB),
                                    height: 1.45,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                      const SizedBox(height: 20),

                      // Section: Tech Stack
                      Text(
                        "// FULL TECH STACK",
                        style: GoogleFonts.jetBrainsMono(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF24DB67),
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: project.technologies.map((tech) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1A1D24),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: const Color(0xFF2D3748),
                              ),
                            ),
                            child: Text(
                              tech,
                              style: GoogleFonts.jetBrainsMono(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF24DB67),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),

              // Dialog Footer Action Buttons
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                decoration: const BoxDecoration(
                  color: Color(0xFF16191F),
                  border: Border(
                    top: BorderSide(color: Color(0xFF1F2937), width: 1),
                  ),
                ),
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  alignment: WrapAlignment.end,
                  children: [
                    _buildModalButton(
                      context: context,
                      label: 'Source Code',
                      iconData: Icons.code_rounded,
                      url: project.githubLink,
                    ),
                    if (project.pubDevLink != null)
                      _buildModalButton(
                        context: context,
                        label: 'View on Pub.dev',
                        iconData: Icons.extension_rounded,
                        url: project.pubDevLink!,
                        highlight: true,
                      ),
                    if (project.playStoreLink != null)
                      _buildModalButton(
                        context: context,
                        label: 'Google Play',
                        iconData: Icons.play_arrow_rounded,
                        url: project.playStoreLink!,
                        highlight: true,
                      ),
                    if (project.appStoreLink != null)
                      _buildModalButton(
                        context: context,
                        label: 'App Store',
                        iconData: Icons.apple_rounded,
                        url: project.appStoreLink!,
                        highlight: true,
                      ),
                    if (project.liveDemoLink != null)
                      _buildModalButton(
                        context: context,
                        label: 'Live Demo',
                        iconData: Icons.open_in_new_rounded,
                        url: project.liveDemoLink!,
                        highlight: true,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModalButton({
    required BuildContext context,
    required String label,
    required IconData iconData,
    required String url,
    bool highlight = false,
  }) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: highlight ? const Color(0xFF24DB67) : const Color(0xFF1F2937),
        foregroundColor: highlight ? const Color(0xFF0C0E12) : const Color(0xFFE0E6EB),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 0,
      ),
      onPressed: () => _launchUrl(context, url),
      icon: Icon(iconData, size: 16),
      label: Text(
        label,
        style: GoogleFonts.jetBrainsMono(
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
