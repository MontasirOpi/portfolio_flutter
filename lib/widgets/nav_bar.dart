import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class NavBar extends StatelessWidget {
  final VoidCallback toggleTheme;
  final bool isDarkMode;

  const NavBar({
    super.key,
    required this.toggleTheme,
    required this.isDarkMode,
  });
  // Generic URL launcher
  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 32,
        vertical: 16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Text(
                "Fahim Montasir Opi",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 30),
                  Material(
                    color: Colors
                        .transparent, // keep background transparent
                    child: InkWell(
                      borderRadius: BorderRadius.circular(
                        4,
                      ), // optional for ripple shape
                      onTap: () => _launchURL('https://dart.dev/'),

                      child: Padding(
                        padding: const EdgeInsets.all(
                          4.0,
                        ), // optional padding
                        child: SvgPicture.asset(
                          'assets/icons/dart.svg',
                          height: 30,
                          width: 30,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 30),
                  Material(
                    color: Colors
                        .transparent, // keep background transparent
                    child: InkWell(
                      borderRadius: BorderRadius.circular(
                        4,
                      ), // optional for ripple shape
                      onTap: () => _launchURL('https://flutter.dev/'),

                      child: Padding(
                        padding: const EdgeInsets.all(
                          4.0,
                        ), // optional padding
                        child: SvgPicture.asset(
                          'assets/icons/flutter-logo.svg',
                          height: 30,
                          width: 30,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          
          Row(
            children: [
               Material(
                    color: Colors
                        .transparent, // keep background transparent
                    child: InkWell(
                      borderRadius: BorderRadius.circular(
                        4,
                      ), // optional for ripple shape
                      onTap: () => _launchURL('https://github.com/MontasirOpi'),
                        
                      child: Padding(
                        padding: const EdgeInsets.all(
                          4.0,
                        ), // optional padding
                        child: SvgPicture.asset(
                          'assets/icons/github.svg',
                          height: 40,
                          width: 40,
                        ),
                      ),
                    ),
                  ),
                   Material(
                    color: Colors
                        .transparent, // keep background transparent
                    child: InkWell(
                      borderRadius: BorderRadius.circular(
                        4,
                      ), // optional for ripple shape
                      onTap: () => _launchURL('https://www.linkedin.com/in/fahim-montasir-opi-161b65256/'),
                        
                      child: Padding(
                        padding: const EdgeInsets.all(
                          4.0,
                        ), // optional padding
                        child: SvgPicture.asset(
                          'assets/icons/linkedin.svg',
                          height: 30,
                          width: 30,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 100,),
                  IconButton(
            icon: Icon(
              isDarkMode ? Icons.light_mode : Icons.dark_mode,
            ),
            onPressed: toggleTheme,
          ),
            ],
          ),
          
        ],
      ),
    );
  }
}
