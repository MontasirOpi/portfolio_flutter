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
  late final Widget _cachedContent;

  @override
  void initState() {
    super.initState();
    
    // Check if project is a key professional release
    final isFeatured = widget.project.title.contains("NoSafer") || 
                       widget.project.title.contains("Travojet") ||
                       widget.project.title.contains("date_with");

    // Cache the static contents to isolate hover triggers and boost render speed
    _cachedContent = ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Image / Backdrop header
          SizedBox(
            height: 180,
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
                        colors: [Colors.black.withValues(alpha: 0.6), Colors.transparent],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                ),
                // Status badge overlay
                Positioned(
                  top: 16,
                  left: 16,
                  child: _buildStatusBadge(widget.project.category),
                ),
                // Featured badge overlay
                if (isFeatured)
                  Positioned(
                    top: 16,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF0C0E12),
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          // Details section
          Expanded(
            child: _ProjectCardDetails(project: widget.project),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String category) {
    final isProd = category == "Mobile" || category == "Web";
    final dotColor = isProd ? const Color(0xFF24DB67) : const Color(0xFFFFC107);
    final statusText = isProd ? "PRODUCTION" : "PACKAGE";

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF0C0E12).withValues(alpha: 0.75),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFF1F2937)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: dotColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: dotColor.withValues(alpha: 0.5),
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
                       widget.project.title.contains("date_with");

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
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
                : (isFeatured ? const Color(0xFF24DB67).withValues(alpha: 0.25) : const Color(0xFF1F2937)),
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
        child: _cachedContent,
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
      // Create a gorgeous gradient placeholder with large stylized initials
      final isTravel = project.title.toLowerCase().contains('safer') || 
                       project.title.toLowerCase().contains('travojet');
      final words = project.title.split(' ');
      final initials = words.length > 1 
          ? '${words[0][0]}${words[1][0]}'.toUpperCase()
          : project.title.substring(0, 2).toUpperCase();

      return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1A1D24), Color(0xFF0C0E12)],
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
                  fontSize: 100,
                  fontWeight: FontWeight.w900,
                  color: Colors.white.withValues(alpha: 0.03),
                  letterSpacing: -5,
                ),
              ),
            ),
            Center(
              child: Icon(
                isTravel ? Icons.explore_rounded : Icons.extension_rounded,
                size: 56,
                color: const Color(0xFF24DB67).withValues(alpha: 0.2),
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

  const _ProjectCardDetails({required this.project});

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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            project.title,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: -0.5,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          // Description
          Text(
            project.description,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 13,
              color: const Color(0xFF9CA3AF),
              height: 1.35,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          // Tech Badges
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: project.technologies.take(4).map((tech) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
            }).toList(),
          ),
          const SizedBox(height: 10),
          // Divider
          Container(height: 1, color: const Color(0xFF1F2937)),
          const SizedBox(height: 8),
          // Achievements Checklist Header
          Text(
            "KEY ACHIEVEMENTS",
            style: GoogleFonts.jetBrainsMono(
              fontSize: 9.5,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF9CA3AF),
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 6),
          // Achievements list
          Expanded(
            child: Column(
              children: project.keyAchievements.take(3).map((achievement) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 5),
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
          const SizedBox(height: 12),
          // Buttons CTA Wrap
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
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
            height: 14,
            width: 14,
            colorFilter: const ColorFilter.mode(Color(0xFFE0E6EB), BlendMode.srcIn),
          )
        else if (iconData != null)
          Icon(iconData, size: 14, color: const Color(0xFFE0E6EB)),
        const SizedBox(width: 6),
        Text(
          label,
          style: GoogleFonts.jetBrainsMono(
            fontWeight: FontWeight.bold,
            fontSize: 11,
            color: const Color(0xFFE0E6EB),
          ),
        ),
      ],
    );

    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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
