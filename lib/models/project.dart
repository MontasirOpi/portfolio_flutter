class Project {
  final String title;
  final String description;
  final String image;
  final String githubLink;
  final String category; // ✅ Added category field
  final String? networkImage; // Optional
  final String? liveDemoLink; // Optional

  Project({
    required this.title,
    required this.description,
    required this.image,
    required this.githubLink,
    required this.category,
    this.networkImage,
    this.liveDemoLink,
  });

  static List<Project> get sampleProjects => [
    // ✅ Mobile Projects
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
      title: "tea Stall review website",
      description:
          "A modern tea stall review website built with react and firebase. Users can browse, review, and rate local tea stalls.",
      image: "assets/images/tea.png",
      githubLink: "https://github.com/MontasirOpi/TEA-STALL-REVIEW",
      category: "Web",
      liveDemoLink: "https://teareview.vercel.app/",
    ),
    // Project(
    //   title: "Blog Dashboard (Admin Panel)",
    //   description:
    //       "A responsive blog admin dashboard for managing posts, users, and comments. Built using Flutter Web + Supabase for backend.",
    //   image: "assets/images/blog_dashboard.jpg",
    //   githubLink: "https://github.com/MontasirOpi/blog_dashboard_web",
    //   category: "Web",
    // ),
  ];
}
