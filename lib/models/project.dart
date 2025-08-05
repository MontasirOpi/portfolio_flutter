

class Project {
  final String title;
  final String description;
  final String image;
  final String githubLink;

  Project({
    required this.title,
    required this.description,
    required this.image,
    required this.githubLink,
  });

  static List<Project> get sampleProjects => [
        Project(
          title: "Library management system",
          description: "The Library Management System is a full-featured Flutter application designed to streamline and digitize the process of managing books, users, and transactions in a library environment. Flutter (Front-end),Supabase(Authentication + Database)",
          image: "assets/images/lms.jpg",  
          githubLink: "https://github.com/MontasirOpi/library_management_system",
        ),
        Project(
          title: "Grocery app using bloc",
          description: "This Grocery App is a simple Flutter application using the BLoC pattern for state management. It lets users browse grocery items, add them to a cart, and manage selections efficiently. The app is designed with clean architecture, separating UI from business logic. It’s perfect for beginners to learn BLoC in a real-world scenario and serves as a foundation for building scalable e-commerce apps with Flutter.",
          image: "assets/images/grocery.png",
          githubLink: "https://github.com/MontasirOpi/grocery_app_using_bloc",
        ),
        Project(
          title: "Fast food app",
          description: "This Fast Food App allows users to browse food items, view details, and add them to the cart. It features a clean UI, category-based filtering, real-time cart updates, and smooth navigation. Built with Flutter, it offers responsive design and modular code, making it ideal for learning food ordering app basics and enhancing with more advanced features.",
          image: "assets/images/fastfood.jpg",
          githubLink: "https://github.com/MontasirOpi/FAST-FOOD-APP-FLUTTER?tab=readme-ov-file",
        ),
        // Project(
        //   title: "Student Attendance",
        //   description: "Role-based Flutter app to track student attendance.",
        //   image: "assets/images/dummy_project.png",
        //   githubLink: "https://github.com/username/student-attendance",
        // ),
        // Project(
        //   title: "Skin Cancer Detector",
        //   description: "Deep learning app to classify skin cancer types.",
        //   image: "assets/images/dummy_project.png",
        //   githubLink: "https://github.com/username/skin-cancer-detector",
        // ),
      ];
}