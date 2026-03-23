import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = true;

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  TextTheme _buildTextTheme(TextTheme base) {
    return GoogleFonts.spaceGroteskTextTheme(base);
  }

  @override
  Widget build(BuildContext context) {
    const primaryNeon = Color(0xFF24DB67);
    const darkBg = Color(0xFF0C0E12);
    const darkSurface = Color(0xFF14161A);
    const lightBg = Color(0xFFF9FAFB);
    const lightSurface = Color(0xFFFFFFFF);

    return MaterialApp(
      title: 'Fahim Montasir Opi — Flutter Developer',
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: lightBg,
        primaryColor: primaryNeon,
        textTheme: _buildTextTheme(ThemeData.light().textTheme),
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryNeon,
          brightness: Brightness.light,
          surface: lightSurface,
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: darkBg,
        primaryColor: primaryNeon,
        textTheme: _buildTextTheme(ThemeData.dark().textTheme),
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryNeon,
          brightness: Brightness.dark,
          surface: darkSurface,
          background: darkBg,
        ),
        appBarTheme: const AppBarTheme(backgroundColor: darkBg, elevation: 0),
      ),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: SelectableRegion(
        focusNode: FocusNode(),
        selectionControls: MaterialTextSelectionControls(),
        child: HomePage(toggleTheme: toggleTheme, isDarkMode: isDarkMode),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
