import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _pulseController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  void _copyToClipboard(String text, String label) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 12),
            Text('$label copied to clipboard!'),
          ],
        ),
        backgroundColor: Colors.green.shade700,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _launchURL(String url, String errorMessage) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.error_outline, color: Colors.white),
                const SizedBox(width: 12),
                Expanded(child: Text(errorMessage)),
              ],
            ),
            backgroundColor: Colors.red.shade700,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;
    final isWide = size.width > 900;

    final contactMethods = [
      {
        'icon': Icons.email_rounded,
        'title': 'Email',
        'value': 'devmontasir@gmail.com',
        'action': 'mailto:devmontasir@gmail.com',
        'color': Colors.red,
      },
      {
        'icon': Icons.phone_rounded,
        'title': 'Phone',
        'value': '+880 1757150553',
        'action': 'tel:+8801757150553',
        'color': Colors.green,
      },
      {
        'icon': Icons.location_on_rounded,
        'title': 'Location',
        'value': 'Dhaka, Bangladesh',
        'action': null,
        'color': Colors.blue,
      },
    ];

    final socialLinks = [
      {
        'name': 'GitHub',
        'icon': Icons.code_rounded,
        'url': 'https://github.com/MontasirOpi',
        'color': isDark ? Colors.white : Colors.black,
        'username': '@MontasirOpi',
      },
      {
        'name': 'LinkedIn',
        'icon': Icons.work_rounded,
        'url': 'https://www.linkedin.com/in/fahim-montasir-opi-161b65256/',
        'color': const Color(0xFF0077B5),
        'username': 'Fahim Montasir Opi',
      },
      {
        'name': 'Twitter',
        'icon': Icons.tag_rounded,
        'url': 'https://twitter.com',
        'color': const Color(0xFF1DA1F2),
        'username': '@YourHandle',
      },
      {
        'name': 'Stack Overflow',
        'icon': Icons.question_answer_rounded,
        'url': 'https://stackoverflow.com',
        'color': const Color(0xFFF48024),
        'username': 'Your Profile',
      },
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.all(isWide ? 32 : 16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Column(
                children: [
                  // Header
                  _buildHeader(isDark),
                  const SizedBox(height: 40),

                  // Contact Methods
                  if (isWide)
                    Row(
                      children: contactMethods
                          .map(
                            (method) => Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                child: _buildContactMethod(method, isDark),
                              ),
                            ),
                          )
                          .toList(),
                    )
                  else
                    Column(
                      children: contactMethods
                          .map(
                            (method) => Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: _buildContactMethod(method, isDark),
                            ),
                          )
                          .toList(),
                    ),

                  const SizedBox(height: 40),

                  // Download CV Button
                  _buildDownloadCV(isDark),

                  const SizedBox(height: 40),

                  // Social Links
                  _buildSectionTitle('Connect With Me', isDark),
                  const SizedBox(height: 24),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: isWide ? 4 : 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1.2,
                    ),
                    itemCount: socialLinks.length,
                    itemBuilder: (context, index) {
                      return _buildSocialCard(socialLinks[index], isDark);
                    },
                  ),

                  const SizedBox(height: 40),

                  // Call to Action
                  _buildCallToAction(isDark),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(bool isDark) {
    return Column(
      children: [
        AnimatedBuilder(
          animation: _pulseController,
          builder: (context, child) {
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isDark
                      ? [Colors.indigo.shade700, Colors.purple.shade700]
                      : [Colors.indigo.shade400, Colors.purple.shade400],
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color:
                        (isDark
                                ? Colors.indigo.shade700
                                : Colors.indigo.shade300)
                            .withOpacity(0.3 + (_pulseController.value * 0.2)),
                    blurRadius: 20 + (_pulseController.value * 10),
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: const Icon(
                Icons.mail_rounded,
                size: 48,
                color: Colors.white,
              ),
            );
          },
        ),
        const SizedBox(height: 24),
        Text(
          'Get In Touch',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black87,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'I\'m always open to discussing new projects, creative ideas, or opportunities',
          style: TextStyle(
            fontSize: 16,
            color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildContactMethod(Map<String, dynamic> method, bool isDark) {
    return InkWell(
      onTap: () {
        if (method['action'] != null) {
          _launchURL(method['action'], 'Could not open ${method['title']}');
        }
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isDark ? Colors.grey.shade900 : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
          ),
          boxShadow: [
            if (!isDark)
              BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: method['color'].withOpacity(isDark ? 0.2 : 0.1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(method['icon'], color: method['color'], size: 32),
            ),
            const SizedBox(height: 16),
            Text(
              method['title'],
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              method['value'],
              style: TextStyle(
                fontSize: 14,
                color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
            if (method['title'] == 'Email') ...[
              const SizedBox(height: 12),
              TextButton.icon(
                onPressed: () => _copyToClipboard(method['value'], 'Email'),
                icon: const Icon(Icons.copy_rounded, size: 16),
                label: const Text('Copy'),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDownloadCV(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [Colors.indigo.shade900, Colors.purple.shade900]
              : [Colors.indigo.shade400, Colors.purple.shade400],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.indigo.shade900.withOpacity(0.5)
                : Colors.indigo.shade300,
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          const Icon(Icons.description_rounded, size: 48, color: Colors.white),
          const SizedBox(height: 16),
          const Text(
            'Want to know more about me?',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Download my CV to see my full experience and qualifications',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.9),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () => _launchURL(
              'https://drive.google.com/file/d/1JHU78JyZ6uvTgvS6A9QLpBDVaBHc2hON/view?usp=sharing',
              'Could not open CV',
            ),
            icon: const Icon(Icons.download_rounded, size: 20),
            label: const Text(
              'Download CV',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: isDark
                  ? Colors.indigo.shade900
                  : Colors.indigo.shade700,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, bool isDark) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: isDark ? Colors.white : Colors.black87,
        letterSpacing: -0.3,
      ),
    );
  }

  Widget _buildSocialCard(Map<String, dynamic> social, bool isDark) {
    return InkWell(
      onTap: () =>
          _launchURL(social['url'], 'Could not open ${social['name']}'),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isDark ? Colors.grey.shade900 : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
          ),
          boxShadow: [
            if (!isDark)
              BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: social['color'].withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(social['icon'], color: social['color'], size: 28),
            ),
            const SizedBox(height: 12),
            Text(
              social['name'],
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              social['username'],
              style: TextStyle(
                fontSize: 11,
                color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCallToAction(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey.shade900 : Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.handshake_rounded,
            size: 48,
            color: isDark ? Colors.indigo.shade300 : Colors.indigo.shade700,
          ),
          const SizedBox(height: 16),
          Text(
            'Let\'s Work Together!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Whether you have a project in mind or just want to chat about tech, feel free to reach out. I\'m always excited to collaborate on interesting projects!',
            style: TextStyle(
              fontSize: 15,
              color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
