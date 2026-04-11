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

  Widget _buildImageSection() {
    Widget imageWidget;
    if (widget.project.networkImage != null) {
      imageWidget = Image.network(
        widget.project.networkImage!,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
      );
    } else if (widget.project.image != null) {
      imageWidget = Image.asset(
        widget.project.image!,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
      );
    } else {
      imageWidget = Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFF0C0E12),
        child: const Center(
          child: Icon(
            Icons.extension_rounded,
            size: 64,
            color: Color(0xFF1F2937),
          ),
        ),
      );
    }

    return imageWidget;
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(0.0, _isHovered ? -4.0 : 0.0, 0.0),
        decoration: BoxDecoration(
          color: const Color(0xFF14161A),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isHovered ? const Color(0xFF24DB67).withOpacity(0.5) : const Color(0xFF1F2937),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 180,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Opacity(
                  opacity: _isHovered ? 1.0 : 0.8,
                  child: _buildImageSection(),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '// ${widget.project.category.toUpperCase()}',
                      style: GoogleFonts.jetBrainsMono(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1,
                        color: const Color(0xFF24DB67),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      widget.project.title,
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: -0.5,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: Text(
                        widget.project.description,
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 14.5,
                          color: const Color(0xFF9CA3AF),
                          height: 1.6,
                        ),
                        maxLines: 4,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Wrap(
                      spacing: 12,
                      runSpacing: 10,
                      children: [
                        _buildActionButton(
                          iconPath: 'assets/icons/github.svg',
                          label: 'Source',
                          url: widget.project.githubLink,
                        ),
                        if (widget.project.pubDevLink != null)
                          _buildActionButton(
                            iconPath: null,
                            iconData: Icons.extension_rounded,
                            label: 'Pub.dev',
                            url: widget.project.pubDevLink!,
                          ),
                        if (widget.project.liveDemoLink != null)
                          _buildActionButton(
                            iconPath: null,
                            iconData: Icons.open_in_new_rounded,
                            label: 'Demo',
                            url: widget.project.liveDemoLink!,
                          ),
                        if (widget.project.playStoreLink != null)
                          _buildActionButton(
                            iconPath: null,
                            iconData: Icons.play_arrow_rounded,
                            label: 'Play Store',
                            url: widget.project.playStoreLink!,
                          ),


                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
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
            height: 16,
            width: 16,
            colorFilter: const ColorFilter.mode(Color(0xFFE0E6EB), BlendMode.srcIn),
          )
        else if (iconData != null)
          Icon(iconData, size: 16, color: const Color(0xFFE0E6EB)),
        const SizedBox(width: 8),
        Text(
          label,
          style: GoogleFonts.jetBrainsMono(
            fontWeight: FontWeight.w500,
            fontSize: 13,
            color: const Color(0xFFE0E6EB),
          ),
        ),
      ],
    );

    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        side: const BorderSide(color: Color(0xFF1F2937), width: 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        foregroundColor: const Color(0xFF24DB67),
      ),
      onPressed: () => _launchUrl(context, url),
      child: child,
    );
  }
}
