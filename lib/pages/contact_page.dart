import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  void _copyToClipboard(String text, String label) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$label copied to clipboard!'),
        backgroundColor: const Color(0xFF24DB67),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _launchURL(String url, String errorMessage) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red.shade700,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isWide = size.width > 900;

    final contactMethods = [
      {
        'icon': Icons.email_rounded,
        'title': 'Email',
        'value': 'devmontasir@gmail.com',
        'action': 'mailto:devmontasir@gmail.com',
      },
      {
        'icon': Icons.phone_rounded,
        'title': 'Phone',
        'value': '+880 1757150553',
        'action': 'tel:+8801757150553',
      },
      {
        'icon': Icons.location_on_rounded,
        'title': 'Location',
        'value': 'Dhaka, Bangladesh',
        'action': null,
      },
    ];

    final socialLinks = [
      {
        'name': 'GitHub',
        'icon': Icons.code_rounded,
        'url': 'https://github.com/MontasirOpi',
      },
      {
        'name': 'LinkedIn',
        'icon': Icons.work_rounded,
        'url': 'https://www.linkedin.com/in/fahim-montasir-opi-161b65256/',
      },
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: FadeTransition(
            opacity: _fadeController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 48),
                isWide
                    ? Row(
                        children: contactMethods
                            .map((m) => Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                    child: _buildContactMethod(m),
                                  ),
                                ))
                            .toList(),
                      )
                    : Column(
                        children: contactMethods
                            .map((m) => Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: _buildContactMethod(m),
                                ))
                            .toList(),
                      ),
                const SizedBox(height: 48),
                _buildDownloadCV(),
                const SizedBox(height: 48),
                Text(
                  '// CONNECT',
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF24DB67),
                  ),
                ),
                const SizedBox(height: 24),
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: socialLinks.map((s) => _buildSocialCard(s)).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '// CONTACT',
          style: GoogleFonts.jetBrainsMono(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF24DB67),
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Let\'s build something amazing together.',
          style: GoogleFonts.spaceGrotesk(
            fontSize: 16,
            color: const Color(0xFF9CA3AF),
          ),
        ),
      ],
    );
  }

  Widget _buildContactMethod(Map<String, dynamic> method) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          if (method['action'] != null) {
            _launchURL(method['action'], 'Could not open ${method['title']}');
          }
        },
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFF14161A),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFF1F2937)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(method['icon'], color: const Color(0xFF24DB67), size: 28),
              const SizedBox(height: 16),
              Text(
                method['title'],
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                method['value'],
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 14,
                  color: const Color(0xFF9CA3AF),
                ),
              ),
              if (method['title'] == 'Email') ...[
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () => _copyToClipboard(method['value'], 'Email'),
                  child: Text(
                    'COPY EMAIL',
                    style: GoogleFonts.jetBrainsMono(
                      fontSize: 12,
                      color: const Color(0xFF24DB67),
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDownloadCV() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: const Color(0xFF14161A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF1F2937)),
      ),
      child: Column(
        children: [
          const Icon(Icons.description_rounded, size: 48, color: Color(0xFF9CA3AF)),
          const SizedBox(height: 16),
          Text(
            'View my full background and experience.',
            style: GoogleFonts.spaceGrotesk(
              fontSize: 16,
              color: const Color(0xFFE0E6EB),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          OutlinedButton.icon(
            onPressed: () => _launchURL(
              'https://drive.google.com/file/d/19RfC_zxo38aq2a3ZstuaWDM79mXsj_sx/view?usp=sharing',
              'Could not open CV',
            ),
            icon: const Icon(Icons.download_rounded, size: 20),
            label: Text(
              'DOWNLOAD CV',
              style: GoogleFonts.jetBrainsMono(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF24DB67),
              side: const BorderSide(color: Color(0xFF24DB67)),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialCard(Map<String, dynamic> social) {
    return InkWell(
      onTap: () => _launchURL(social['url'], 'Could not open ${social['name']}'),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 160,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF14161A),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF1F2937)),
        ),
        child: Column(
          children: [
            Icon(social['icon'], color: const Color(0xFFE0E6EB), size: 32),
            const SizedBox(height: 12),
            Text(
              social['name'],
              style: GoogleFonts.spaceGrotesk(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
