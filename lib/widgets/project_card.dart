import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

  void _showFullImage(BuildContext context) {
    if (widget.project.image == null && widget.project.networkImage == null) {
      return;
    }

    showDialog(
      context: context,
      barrierColor: Colors.black87,
      builder: (dialogContext) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(20),
        child: Stack(
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(dialogContext),
              child: Container(
                color: Colors.transparent,
                child: Center(
                  child: InteractiveViewer(
                    panEnabled: true,
                    minScale: 0.5,
                    maxScale: 4.0,
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.9,
                        maxHeight: MediaQuery.of(context).size.height * 0.9,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 30,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: widget.project.networkImage != null
                            ? Image.network(
                                widget.project.networkImage!,
                                fit: BoxFit.contain,
                              )
                            : Image.asset(
                                widget.project.image!,
                                fit: BoxFit.contain,
                              ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 20,
              right: 20,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.close_rounded,
                    color: Colors.white,
                    size: 28,
                  ),
                  onPressed: () => Navigator.pop(dialogContext),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection(bool isDark) {
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
      // Fallback for packages without images
      imageWidget = Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? [Colors.indigo.shade900, Colors.purple.shade900]
                : [Colors.indigo.shade100, Colors.purple.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Icon(
            widget.project.category == 'Package'
                ? Icons.extension_rounded
                : Icons.code_rounded,
            size: 64,
            color: isDark ? Colors.indigo.shade200 : Colors.indigo.shade600,
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: () => _showFullImage(context),
      child: Stack(
        fit: StackFit.expand,
        children: [
          imageWidget,
          // Hover overlay
          AnimatedOpacity(
            opacity: _isHovered ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 200),
            child: Container(
              color: Colors.black54,
              child: const Center(
                child: Icon(
                  Icons.zoom_in_rounded,
                  color: Colors.white,
                  size: 48,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(0.0, _isHovered ? -8.0 : 0.0, 0.0),
        decoration: BoxDecoration(
          color: isDark ? Colors.grey.shade900 : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.black.withOpacity(_isHovered ? 0.6 : 0.2)
                  : Colors.grey.withOpacity(_isHovered ? 0.3 : 0.1),
              blurRadius: _isHovered ? 24 : 10,
              offset: Offset(0, _isHovered ? 12 : 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image Area - Fixed height
            SizedBox(
              height: 200,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                child: _buildImageSection(isDark),
              ),
            ),
            
            // Content Area - Takes remaining space smoothly
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category Chip
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.indigo.shade900.withOpacity(0.4)
                            : Colors.indigo.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        widget.project.category.toUpperCase(),
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                          color: isDark
                              ? Colors.indigo.shade300
                              : Colors.indigo.shade700,
                        ),
                      ),
                    ),
                    
                    // Title
                    Text(
                      widget.project.title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: isDark ? Colors.white : Colors.black87,
                        letterSpacing: -0.3,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),

                    // Description
                    Expanded(
                      child: Text(
                        widget.project.description,
                        style: TextStyle(
                          fontSize: 14,
                          color: isDark
                              ? Colors.grey.shade400
                              : Colors.grey.shade600,
                          height: 1.5,
                        ),
                        maxLines: 4,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                    
                    const SizedBox(height: 16),

                    // Actions
                    Wrap(
                      spacing: 12,
                      runSpacing: 10,
                      children: [
                        _buildActionButton(
                          iconPath: 'assets/icons/github.svg',
                          label: 'GitHub',
                          url: widget.project.githubLink,
                          isPrimary: true,
                          isDark: isDark,
                        ),
                        if (widget.project.pubDevLink != null)
                          _buildActionButton(
                            iconPath: null,
                            iconData: Icons.extension_rounded,
                            label: 'Pub.dev',
                            url: widget.project.pubDevLink!,
                            isPrimary: false,
                            isDark: isDark,
                          ),
                        if (widget.project.liveDemoLink != null)
                          _buildActionButton(
                            iconPath: null,
                            iconData: Icons.open_in_new_rounded,
                            label: 'Demo',
                            url: widget.project.liveDemoLink!,
                            isPrimary: false,
                            isDark: isDark,
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
    required bool isPrimary,
    required bool isDark,
  }) {
    final child = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (iconPath != null)
          SvgPicture.asset(
            iconPath,
            height: 16,
            width: 16,
            colorFilter: ColorFilter.mode(
              isPrimary
                  ? Colors.white
                  : (isDark ? Colors.indigo.shade300 : Colors.indigo.shade700),
              BlendMode.srcIn,
            ),
          )
        else if (iconData != null)
          Icon(
            iconData,
            size: 16,
            color: isPrimary
                ? Colors.white
                : (isDark ? Colors.indigo.shade300 : Colors.indigo.shade700),
          ),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 13,
            color: isPrimary
                ? Colors.white
                : (isDark ? Colors.indigo.shade300 : Colors.indigo.shade700),
          ),
        ),
      ],
    );

    if (isPrimary) {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isDark ? Colors.indigo.shade700 : Colors.indigo.shade600,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 0,
        ),
        onPressed: () => _launchUrl(context, url),
        child: child,
      );
    } else {
      return OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          side: BorderSide(
            color: isDark ? Colors.indigo.shade900 : Colors.indigo.shade100,
            width: 1.5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () => _launchUrl(context, url),
        child: child,
      );
    }
  }
}
