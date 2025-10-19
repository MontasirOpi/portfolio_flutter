class Project {
  final String title;
  final String description;
  final String image;
  final String githubLink;
  final String? networkImage; // ✅ Nullable (optional)

  Project({
    required this.title,
    required this.description,
    required this.image,
    required this.githubLink,
    this.networkImage,
  });

  static List<Project> get sampleProjects => [
    Project(
      title: "Library Management System",
      description:
          "A full-featured Flutter application designed to streamline and digitize the process of managing books, users, and transactions in a library environment. Flutter (Front-end), Supabase (Authentication + Database).",
      image: "assets/images/lms.jpg",
      githubLink: "https://github.com/MontasirOpi/library_management_system",
    ),
    Project(
      title: "Grocery App Using BLoC",
      description:
          "A simple Flutter grocery app using the BLoC pattern for clean state management. Users can browse grocery items, add to cart, and manage selections efficiently — ideal for beginners learning scalable app architecture.",
      image: "assets/images/grocery.png",
      githubLink: "https://github.com/MontasirOpi/grocery_app_using_bloc",
    ),
    Project(
      title: "Fast Food App",
      description:
          "Browse food items, view details, and manage your cart. Built with Flutter and featuring category-based filtering, real-time cart updates, and smooth navigation with responsive UI design.",
      image: "assets/images/fastfood.jpg",
      githubLink: "https://github.com/MontasirOpi/FAST-FOOD-APP-FLUTTER",
    ),
    Project(
      title: "Weather App",
      description:
          "A Flutter weather app that fetches real-time data from OpenWeatherMap API, supports light/dark modes, and provides temperature, humidity, and wind details with clean, responsive design.",
      image: "assets/images/weather.png",
      githubLink: "https://github.com/MontasirOpi/weather-app-using-flutter",
    ),
    Project(
      title: "আবহাওয়া Pal (Weather Pal)",
      description:
          "A bilingual weather app (Bangla & English) designed for Bangla-speaking users in Bangladesh and West Bengal. Provides real-time weather updates, forecasts, and local tips.",
      image: "assets/images/abohawa_pal.jpg",
      githubLink: "https://github.com/MontasirOpi/weather_pal",
    ),
  ];
}
