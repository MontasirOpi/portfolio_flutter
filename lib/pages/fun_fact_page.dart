import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FunFactsPage extends StatelessWidget {
  const FunFactsPage({super.key});

  final double sectionSpacing = 24;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final favoriteMovies = [
      {'name': 'Inception', 'emoji': '🎥'},
      {'name': 'The Dark Knight Trilogy', 'emoji': '🎬'},
      {'name': 'Interstellar', 'emoji': '🚀'},
    ];

    final favoriteQuotes = [
      {
        'quote':
            '"You mustn\'t be afraid to dream a little bigger, darling."',
        'source': 'Inception',
        'emoji': '💭',
      },
      {
        'quote': '"You either die a hero or you live long enough to see yourself become the villain."',
        'source': 'The Dark Knight',
        'emoji': '🥄',
      },
      {
        'quote':
            '"It\'s not possible. No, it\'s necessary."',
        'source': 'Interstellar',
        'emoji': '🌌',
      },
    ];

    final favoriteSongs = [
      {
        'title': 'Warfaze - Purnota',
        'emoji': '🎶',
        'url': 'https://www.youtube.com/watch?v=uB2rhjulY4Q&list=RDuB2rhjulY4Q&start_radio=1',
      },
      {
        'title': 'Aftermath - Utshorgo',
        'emoji': '🎤',
        'url': 'https://www.youtube.com/watch?v=PBbAj3NWLvE&list=RDPBbAj3NWLvE&start_radio=1',
      },
      {
        'title': 'Karnival - Bhrom',
        'emoji': '🔥',
        'url': 'https://www.youtube.com/watch?v=zVwDzhLp8Bs&list=RDzVwDzhLp8Bs&start_radio=1',
      },
    ];

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? Colors.black : Colors.white,
        border: Border.all(
          color: isDark ? Colors.tealAccent : Colors.deepPurple,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.tealAccent.withOpacity(0.2)
                : Colors.deepPurple.withOpacity(0.2),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sciFiTitle("🚀 Fun Facts", isDark),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Movies
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sciFiSubtitle("Favorite Movies", isDark),
                    const SizedBox(height: 8),
                    ...favoriteMovies.map(
                      (movie) => _sciFiItem(
                        movie['name']!,
                        movie['emoji']!,
                        isDark,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(width: sectionSpacing),

              // Quotes
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sciFiSubtitle("Favorite Quotes", isDark),
                    const SizedBox(height: 8),
                    ...favoriteQuotes.map(
                      (quote) => _sciFiQuote(
                        quote['quote']!,
                        quote['source']!,
                        quote['emoji']!,
                        isDark,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(width: sectionSpacing),

              // Songs
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sciFiSubtitle("Favorite Songs", isDark),
                    const SizedBox(height: 8),
                    ...favoriteSongs.map(
                      (song) => _sciFiSong(
                        song['title']!,
                        song['url']!,
                        isDark,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _sciFiTitle(String title, bool isDark) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.5,
        color: isDark ? Colors.tealAccent : Colors.deepPurple,
        fontFamily: 'Orbitron',
      ),
    );
  }

  Widget _sciFiSubtitle(String subtitle, bool isDark) {
    return Text(
      subtitle,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: isDark
            ? Colors.tealAccent.shade100
            : Colors.deepPurple.shade700,
        fontFamily: 'ShareTechMono',
      ),
    );
  }

  Widget _sciFiItem(String text, String emoji, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: isDark ? Colors.white70 : Colors.black87,
                fontFamily: 'ShareTechMono',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sciFiQuote(
    String quote,
    String source,
    String emoji,
    bool isDark,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  quote,
                  style: TextStyle(
                    fontSize: 13,
                    fontStyle: FontStyle.italic,
                    color: isDark ? Colors.white70 : Colors.black87,
                    fontFamily: 'ShareTechMono',
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  "- $source",
                  style: TextStyle(
                    fontSize: 11,
                    color: isDark
                        ? Colors.grey
                        : Colors.grey.shade800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sciFiSong(String title, String url, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: isDark ? Colors.white70 : Colors.black87,
                fontFamily: 'ShareTechMono',
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          IconButton(
            iconSize: 22,
            icon: Icon(
              Icons.play_circle_fill,
              color: isDark ? Colors.tealAccent : Colors.deepPurple,
            ),
            onPressed: () async {
              final uri = Uri.parse(url);
              if (await canLaunchUrl(uri)) {
                await launchUrl(
                  uri,
                  mode: LaunchMode.externalApplication,
                );
              }
            },
            tooltip: 'Open on YouTube',
          ),
        ],
      ),
    );
  }
}
