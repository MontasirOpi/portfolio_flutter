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
  final String? appStoreLink; // New field for iOS apps
  final List<String> keyAchievements;
  final String? performanceMetric;
  final String? userMetric;
  final List<String> technologies;

  const Project({
    required this.title,
    required this.description,
    this.image,
    required this.githubLink,
    required this.category,
    this.networkImage,
    this.liveDemoLink,
    this.pubDevLink,
    this.playStoreLink,
    this.appStoreLink,
    required this.keyAchievements,
    this.performanceMetric,
    this.userMetric,
    required this.technologies,
  });

  static const List<Project> sampleProjects = [
    // ✅ Production Mobile Apps
    Project(
      title: "NoSafer Travel Agency",
      description: "A premium B2C travel booking platform enabling travelers to discover, compare, and book flights, hotels, and holiday trips in one high-performance, seamless mobile app.",
      category: "Mobile",
      githubLink: "https://github.com/MontasirOpi",
      playStoreLink: "https://play.google.com/store/apps/details?id=com.nosafer.b2c",
      appStoreLink: "https://apps.apple.com/us/app/nosafer/id6766163567",
      keyAchievements: [
        "Architected end-to-end flight booking and hotel search modules using modular structures",
        "Integrated secure travel insurance purchase steps and direct eSIM setup modules",
        "Optimized image loading, caching, and state rebuild loops to guarantee 60 FPS transitions"
      ],
      performanceMetric: "60 FPS Scrolling",
      userMetric: "15k+ Deployed Users",
      technologies: ["Flutter", "Dart", "GetX", "REST API", "OTA Systems"],
    ),
    Project(
      title: "Travojet Mobile App",
      description: "An all-in-one travel agency application offering visa support, holiday package planning, flight bookings, and hotel reservations with professional guidance and custom booking workflows.",
      category: "Mobile",
      githubLink: "https://github.com/MontasirOpi",
      playStoreLink: "https://play.google.com/store/apps/details?id=com.travojet.app",
      appStoreLink: "https://apps.apple.com/in/app/travojet/id6775792334",
      keyAchievements: [
        "Implemented flight seat selections and booking flow state using GetX",
        "Built document scanner uploads and real-time status trackers for tourist visa applications",
        "Connected push notifications and campaign banners to increase active engagement by 20%"
      ],
      performanceMetric: "35% Faster Checkout",
      userMetric: "10k+ Downloads",
      technologies: ["Flutter", "Dart", "GetX", "REST API", "Push Notification"],
    ),

    // ✅ Packages
    Project(
      title: "date_with_range_picker",
      description:
          "A highly customizable flutter package for selecting a single date or a date range with a premium user interface and ease of use.",
      githubLink: "https://github.com/MontasirOpi/date_range_picker",
      category: "Package",
      pubDevLink: "https://pub.dev/packages/date_with_range_picker",
      keyAchievements: [
        "Engineered smooth grid-calendar rendering with customized range selection logic",
        "Optimized gesture detection, reducing calendar state rebuild counts by 80%",
        "Published open-source on pub.dev, maintaining modular code with clean API interfaces"
      ],
      performanceMetric: "80% Less Rebuilds",
      userMetric: "150+ Pub Points",
      technologies: ["Flutter", "Dart", "Package", "Open Source"],
    ),

    // ✅ Mobile Projects

    Project(
      title: "Jomi Converter BD",
      description:
      "A land measurement converter app for Bangladesh with simple and user-friendly UI.",
      image: "assets/images/jomi.webp",
      githubLink: "https://github.com/MontasirOpi/jomi_converter",
      playStoreLink: "https://play.google.com/store/apps/details?id=app.opi.land",
      category: "Mobile",
      keyAchievements: [
        "Designed land area conversions (Katha, Bigha, Decimal) using local mathematical formulas",
        "Built responsive, clean grid layout that scales across standard and tablet screen sizes",
        "Managed database cache for recent conversions using SQLite offline caching"
      ],
      performanceMetric: "Offline-First Support",
      userMetric: "5k+ Downloads",
      technologies: ["Flutter", "Dart", "SQLite", "Responsive Grid"],
    ),
    Project(
      title: "Library Management System",
      description:
          "A full-featured Flutter app designed to manage books, users, and transactions efficiently. Built using Flutter (Front-end) and Supabase (Backend).",
      image: "assets/images/lms.webp",
      githubLink: "https://github.com/MontasirOpi/library_management_system",
      category: "Mobile",
      keyAchievements: [
        "Linked Flutter front-end with Supabase databases for real-time inventory updates",
        "Configured secure authentication flows (JWT tokens) and user role dashboard access controls",
        "Added local database caches using Hive to enable offline book reads"
      ],
      performanceMetric: "Real-time Syncing",
      userMetric: "B2B Admin Dashboard",
      technologies: ["Flutter", "Dart", "Supabase", "Hive Database"],
    ),
    Project(
      title: "Grocery App Using BLoC",
      description:
          "A simple grocery app built with Flutter using the BLoC pattern for scalable and maintainable state management.",
      image: "assets/images/grocery.webp",
      githubLink: "https://github.com/MontasirOpi/grocery_app_using_bloc",
      category: "Mobile",
      keyAchievements: [
        "Structured state flows using BLoC (Business Logic Component) pattern separation",
        "Implemented dynamic shopping cart calculations and price aggregate animations",
        "Optimized list widgets to prevent rebuilding off-screen product items"
      ],
      performanceMetric: "Pure BLoC Architecture",
      userMetric: "60 FPS Animation",
      technologies: ["Flutter", "Dart", "BLoC Pattern", "State Management"],
    ),
    Project(
      title: "Fast Food App",
      description:
          "Browse foods, manage your cart, and enjoy smooth UI animations with this responsive Flutter food ordering app.",
      image: "assets/images/fastfood.webp",
      githubLink: "https://github.com/MontasirOpi/FAST-FOOD-APP-FLUTTER",
      category: "Mobile",
      keyAchievements: [
        "Built high-fidelity hero page custom transitions for food item cards",
        "Integrated dynamic list filter chips for food categories",
        "Optimized memory usage during heavy horizontal asset sliding"
      ],
      performanceMetric: "Custom Transitions",
      userMetric: "Rich Visual Assets",
      technologies: ["Flutter", "Dart", "Animations", "UI Transitions"],
    ),
    Project(
      title: "Weather App",
      description:
          "A weather app that fetches real-time data from OpenWeatherMap API. Includes dark mode and smooth animations.",
      image: "assets/images/weather.webp",
      githubLink: "https://github.com/MontasirOpi/weather-app-using-flutter",
      category: "Mobile",
      keyAchievements: [
        "Connected OpenWeatherMap API JSON endpoints using secure HTTP configurations",
        "Designed responsive state updates, handling active loading, empty, and offline errors",
        "Added weather-matching dynamic gradients and custom lottie weather indicators"
      ],
      performanceMetric: "API Optimization",
      userMetric: "Clean Architecture",
      technologies: ["Flutter", "Dart", "REST API", "Weather Lottie"],
    ),
    Project(
      title: "আবহাওয়া Pal (Weather Pal)",
      description:
          "A bilingual weather app (Bangla & English) for Bangla-speaking users. Shows real-time forecasts and weather details.",
      image: "assets/images/abohawa_pal.webp",
      githubLink: "https://github.com/MontasirOpi/weather_pal",
      category: "Mobile",
      keyAchievements: [
        "Implemented Flutter localization (English / Bangla strings) dynamically",
        "Integrated regional meteorological databases to support local predictions",
        "Optimized UI layout grids to adapt smoothly to localized Bengali script typography"
      ],
      performanceMetric: "Bilingual Localization",
      userMetric: "Regional Launch",
      technologies: ["Flutter", "Dart", "Localization", "Bilingual"],
    ),


    // ✅ Web Projects
    Project(
      title: "Tea Stall Review Website",
      description:
          "A modern tea stall review website built with react and firebase. Users can browse, review, and rate local tea stalls.",
      image: "assets/images/tea.webp",
      githubLink: "https://github.com/MontasirOpi/TEA-STALL-REVIEW",
      category: "Web",
      liveDemoLink: "https://teareview.vercel.app/",
      keyAchievements: [
        "Integrated Firebase Firestore to support real-time user ratings and reviews",
        "Built responsive grid layouts with custom TailwindCSS styles",
        "Configured secure authentication, ensuring authors can only edit their own reviews"
      ],
      performanceMetric: "Fast Cloud Integration",
      userMetric: "Active Web Community",
      technologies: ["React", "Firebase", "Firestore", "TailwindCSS"],
    ),
  ];
}
