class Project {
  final String title;
  final String description;
  final String? image; // Made nullable
  final String githubLink;
  final String category;
  final String? networkImage;
  final String? liveDemoLink;
  final String? pubDevLink; // New field for Pub.dev packages
  final String? playStoreLink; // New field for Play Store apps


  Project({
    required this.title,
    required this.description,
    this.image,
    required this.githubLink,
    required this.category,
    this.networkImage,
    this.liveDemoLink,
    this.pubDevLink,
    this.playStoreLink,
  });

  static List<Project> get sampleProjects => [
    // ✅ Packages
    Project(
      title: "date_with_range_picker",
      description:
          "A highly customizable flutter package for selecting a single date or a date range with a premium user interface and ease of use.",
      githubLink: "https://github.com/MontasirOpi/date_range_picker",
      category: "Package",
      pubDevLink: "https://pub.dev/packages/date_with_range_picker",
    ),

    // ✅ Mobile Projects

    Project(
      title: "Jomi Converter BD",
      description:
      "A land measurement converter app for Bangladesh with simple and user-friendly UI.",
      image: "assets/images/jomi.jpg",
      githubLink: "https://github.com/MontasirOpi/jomi_converter",
      playStoreLink: "https://play.google.com/store/apps/details?id=app.opi.land",
      category: "Mobile",
    ),
    Project(
      title: "Library Management System",
      description:
          "A full-featured Flutter app designed to manage books, users, and transactions efficiently. Built using Flutter (Front-end) and Supabase (Backend).",
      image: "assets/images/lms.jpg",
      githubLink: "https://github.com/MontasirOpi/library_management_system",
      category: "Mobile",
    ),
    Project(
      title: "Grocery App Using BLoC",
      description:
          "A simple grocery app built with Flutter using the BLoC pattern for scalable and maintainable state management.",
      image: "assets/images/grocery.png",
      githubLink: "https://github.com/MontasirOpi/grocery_app_using_bloc",
      category: "Mobile",
    ),
    Project(
      title: "Fast Food App",
      description:
          "Browse foods, manage your cart, and enjoy smooth UI animations with this responsive Flutter food ordering app.",
      image: "assets/images/fastfood.jpg",
      githubLink: "https://github.com/MontasirOpi/FAST-FOOD-APP-FLUTTER",
      category: "Mobile",
    ),
    Project(
      title: "Weather App",
      description:
          "A weather app that fetches real-time data from OpenWeatherMap API. Includes dark mode and smooth animations.",
      image: "assets/images/weather.png",
      githubLink: "https://github.com/MontasirOpi/weather-app-using-flutter",
      category: "Mobile",
    ),
    Project(
      title: "আবহাওয়া Pal (Weather Pal)",
      description:
          "A bilingual weather app (Bangla & English) for Bangla-speaking users. Shows real-time forecasts and weather details.",
      image: "assets/images/abohawa_pal.jpg",
      githubLink: "https://github.com/MontasirOpi/weather_pal",
      category: "Mobile",
    ),


    // ✅ Web Projects
    Project(
      title: "Tea Stall Review Website",
      description:
          "A modern tea stall review website built with react and firebase. Users can browse, review, and rate local tea stalls.",
      image: "assets/images/tea.png",
      githubLink: "https://github.com/MontasirOpi/TEA-STALL-REVIEW",
      category: "Web",
      liveDemoLink: "https://teareview.vercel.app/",
    ),
  ];
}
