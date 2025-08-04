

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
          description: "An IoT-based app to control temperature and humidity.",
          image: "assets/images/lms.jpg",
          githubLink: "https://github.com/MontasirOpi/library_management_system",
        ),
        Project(
          title: "Grocery app using bloc",
          description: "A real-time parking slot manager using Flutter & Firebase.",
          image: "assets/images/grocery.png",
          githubLink: "https://github.com/MontasirOpi/grocery_app_using_bloc",
        ),
        Project(
          title: "News Reader",
          description: "A Flutter app fetching news via NewsAPI.",
          image: "assets/images/dummy_project.png",
          githubLink: "https://github.com/username/news-reader",
        ),
        Project(
          title: "Student Attendance",
          description: "Role-based Flutter app to track student attendance.",
          image: "assets/images/dummy_project.png",
          githubLink: "https://github.com/username/student-attendance",
        ),
        Project(
          title: "Skin Cancer Detector",
          description: "Deep learning app to classify skin cancer types.",
          image: "assets/images/dummy_project.png",
          githubLink: "https://github.com/username/skin-cancer-detector",
        ),
      ];
}